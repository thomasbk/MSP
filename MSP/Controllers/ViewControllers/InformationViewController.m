//
//  InformationViewController.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "InformationViewController.h"
#import "NetworkHandler.h"
#import "DBHandler.h"

@interface InformationViewController () {
    NSString *description;
}

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _lblInformation.text = description;
    
    //[self getInformation];
}


- (void) getInformation {
    
    NSArray *consejos = [DBHandler getConsejosDetalle];
    
    if (!consejos || consejos.count == 0) {
        
        [self showDialog:@"" withMessage:@"No se encontró información"];
    }
    else {
    
    for (NSManagedObject *obj in consejos) {
        if ([[obj valueForKeyPath:@"tipo"] doubleValue] == [[_item getItemID] doubleValue]) {
            description = [obj valueForKeyPath:@"descripcion"];
            //break;
        }
    }
    }
    
    
    /*
    [NetworkHandler getAdvice:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            [self setData:json];
            
        }
    }];
     */
}

- (void) getRequest {
    
    NSArray *solicitudes = [DBHandler getSolicitudesDetalle];
    
    for (NSManagedObject *obj in solicitudes) {
        if ([[obj valueForKeyPath:@"tipo"] doubleValue] == [[_item getItemID] doubleValue]) {
            description = [obj valueForKeyPath:@"descripcion"];
            //break;
        }
    }
    
    /*
    [NetworkHandler getRequests:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            [self setData:json];
        }
    }];
     */
}


- (void)setData:(NSDictionary*)json {
    self->description = @"";
    
    NSArray *detalles = [json objectForKey:@"DETALLE"];
    
    for (NSDictionary *dict in detalles) {
        
        if ([[dict objectForKey:@"TIP"] doubleValue] == [[self->_item getItemID] doubleValue]) {
            NSArray *info = [dict objectForKey:@"INFO"];
            
            for (NSDictionary *infoDict in info) {
                
                NSString *titulo = infoDict[@"TIT"];
                NSString *descripcion = infoDict[@"DESC"];
                
                self->description = [NSString stringWithFormat:@"%@%@\n\n%@\n\n\n",self->description,titulo,descripcion];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self->_lblInformation.text = self->description;
            });
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) setDescription:(NSString*)desc {
    description = desc;
}

- (void) setItemAndGetInfo:(ListItem*)item {
    self.item = item;
    [self getInformation];
}

- (void) setItemAndGetRequest:(ListItem*)item {
    self.item = item;
    [self getRequest];
}

@end
