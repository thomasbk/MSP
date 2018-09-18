//
//  ReportSender.h
//  MSP
//
//  Created by Pro Retina on 9/12/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReportSender : NSObject

@property (nonatomic) int index;
@property (nonatomic, retain) NSArray *savedReports;
@property (nonatomic, retain) NSMutableDictionary *currentParams;
@property (nonatomic, retain) NSData *currentImageData;
@property (nonatomic) int currentReportID;
@property (nonatomic, retain) NSString *currentReportType;

-(void) sendSavedReports;

@end
