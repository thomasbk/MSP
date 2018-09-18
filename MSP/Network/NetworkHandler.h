//
//  NetworkHandler.h
//  MSP
//
//  Created by Pro Retina on 8/17/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface NetworkHandler : NSObject

+ (void) validateUser:(NSString *)user password:(NSString *)password completion: (void (^)(NSDictionary *json, BOOL success))completion;

+ (void) rememberPassword:(NSString*)email completion: (void (^)(NSDictionary *json, BOOL success))completion;

+ (void) changePassword:(NSString*)email old:(NSString*)oldPass new:(NSString*)newPass completion: (void (^)(NSDictionary *json, BOOL success))completion;

+ (void) getAdvice: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) getReports: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) getComplaints:(void (^)(NSDictionary *json, BOOL success))completion;
+ (void) getVersion: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) getDelegations: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) getParameters: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) getDates: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) getInformation: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) getRequests: (void (^)(NSDictionary *json, BOOL success))completion;

+ (void) getClosestDelegations:(double)latitud longitud:(double)longitud completion: (void (^)(NSDictionary *json, BOOL success))completion;

+ (void) sendInfo:params completion: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) sendComplaints:params completion: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) sendIncident:params completion: (void (^)(NSDictionary *json, BOOL success))completion;
+ (void) sendComplaintIncident:params service:(NSString*)service completion: (void (^)(NSDictionary *json, BOOL success))completion;

+ (void) sendImage:(NSData*)data completion: (void (^)(NSDictionary *json, BOOL success))completion;

+(ASIHTTPRequest *)uploadImage:(NSData *) pPostData delegate:(id) pDelegate tag:(NSString *)pTag;

@end
