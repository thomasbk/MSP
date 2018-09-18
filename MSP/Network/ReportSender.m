//
//  ReportSender.m
//  MSP
//
//  Created by Pro Retina on 9/12/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "ReportSender.h"
#import "NetworkHandler.h"
#import "DBHandler.h"
#import "ASIHTTPRequest.h"

@implementation ReportSender

@synthesize index, savedReports, currentParams, currentImageData, currentReportID, currentReportType;


- (id)init {
    if (self = [super init]) {
        
        index = 0;
    }
    return self;
}

-(void) sendSavedReports {
    savedReports = [DBHandler getReportesPorEnviar];
    
    [self sendNext];
    
}


- (void) sendNext {
    
    if (index < savedReports.count) {
        
        NSManagedObject *obj = savedReports[index];
        
        currentImageData = [obj valueForKeyPath:@"imagen"];
        currentReportID = [[obj valueForKeyPath:@"id"] intValue];
        NSData *dictionaryData = [obj valueForKeyPath:@"data"];
        currentParams = (NSMutableDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
        currentReportType = [obj valueForKeyPath:@"tipo"];
        
        if (!currentImageData) { // Doesnt have image
            
            [self sendData];//:paramsDictionary imageData:imageData type:tipo dataID:[reporteID intValue]];
        }
        else {
            [NetworkHandler uploadImage:currentImageData delegate:self tag:@"Imagen"];
        }
    }
    else {
        
    }
    
}


- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString * tag = [request.userInfo objectForKey:@"tag"];
    NSString *response = [request responseString];
    if([tag isEqualToString:@"Imagen"])
    {
        NSLog(response);
        
        NSData* dataJson = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:dataJson options:0 error:nil];
        if(data != nil){
            if ([[data[@"Codigo"] stringValue] isEqualToString:@"0"]) {
                
                [currentParams setObject:data[@"idImagen"] forKey:@"IMG"];
                
                [self sendData];//:currentParams imageData:imageData type:tipo dataID:[reporteID intValue]];
            }
            else {
                
            }
        }
    }
    
}



- (void) sendData { //:(NSDictionary*)params imageData:(NSData*)imageData type:(NSString*)type dataID:(int)dataID {
    
    [NetworkHandler sendComplaintIncident:currentParams service:currentReportType completion:^(NSDictionary *json, BOOL success) {
        
        if (success)
        {
            [DBHandler deleteReportePorEnviar:self.currentReportID];
            
            if([json[@"Codigo"] intValue] == 0) {
                
            }
            else {
                //[self showDialog:@"" withMessage:@"Por favor verificar los campos"];
            }
        }
        
        self.index++;
        [self sendNext];
        
    }];
}



@end
