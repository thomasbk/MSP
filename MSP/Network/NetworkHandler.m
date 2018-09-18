//
//  NetworkHandler.m
//  MSP
//
//  Created by Pro Retina on 8/17/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "NetworkHandler.h"
#import <AFNetworking/AFHTTPSessionManager.h>

@interface NetworkHandler ()

@end

@implementation NetworkHandler

NSString * const apiURL = @"http://192.168.0.83:9081/MSPmovil/services/";

+ (void) validateUser:(NSString *)user password:(NSString *)password completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"ValidateUser"];
    
    //body = {"USR":"novacomp", "PASS":"aslddsad"}
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:user, @"USR", password, @"PASS", nil];
    
    [self postService:url params:params completion:completion];
    
}
    



+ (void) getVersion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getVersion"];
    
    [self getService:url completion:completion];
}




+ (void) changePassword:(NSString*)email old:(NSString*)oldPass new:(NSString*)newPass completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"changePass"];
    
    NSDictionary *myParams = [NSDictionary dictionaryWithObjectsAndKeys:@"SP13",@"SP", email, @"EMAIL", oldPass, @"LPASS",newPass,@"NPASS", nil];
    [self postService:url params:myParams completion:completion];
}


+ (void) rememberPassword:(NSString*) email completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"rememberPass"];
    
    NSDictionary *myParams = [NSDictionary dictionaryWithObjectsAndKeys:@"SP4",@"SP", email, @"EMAIL", nil];
    
    [self postService:url params:myParams completion:completion];
}





+ (void) getDelegations: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP10"];
    
    [self getService:url completion:completion];
}

+ (void) getParameters: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP9"];
    
    [self getService:url completion:completion];
}


+ (void) getDates: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP11"];
    
    [self getService:url completion:completion];
}


+ (void) getAdvice: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP7/C"];
    
    [self getService:url completion:completion];
}


+ (void) getComplaints: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP7/Q"];
    
    [self getService:url completion:completion];
}


+ (void) getInformation: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP7/I"];
    
    [self getService:url completion:completion];
}


+ (void) getRequests: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP7/S"];
    
    [self getService:url completion:completion];
}

    
+ (void) getReports: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP7/R"];
    
    [self getService:url completion:completion];
}





+ (void) getClosestDelegations:(double)latitud longitud:(double)longitud completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"DelegacionesCerc"];
    
    //body = {"USR":"novacomp", "PASS":"aslddsad"}
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithDouble: latitud], @"LA", [NSNumber numberWithDouble:longitud], @"LO", nil];
    
    [self postService:url params:params completion:completion];
    
}










+ (void) sendInfo:params completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"sendInfo"];
    
    NSDictionary *myParams = [NSDictionary dictionaryWithObjectsAndKeys:@"SP3",@"SP", params, @"Info", nil];
    //{"SP":"SP3", "Info": {"CED": "113280186", "NOM": "Byktor Matarrita", "TOK": "SDLWJ193WTJUC", "USR":"byktor", "TEL": "8888-8888", "EMAIL": "vmatarrita@crnova.com", "PASS": "123"}}
    
    [self postService:url params:myParams completion:completion];
}

+ (void) sendComplaints:params completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"sendInfo"];
    
    NSDictionary *myParams = [NSDictionary dictionaryWithObjectsAndKeys:@"SP5",@"SP", params, @"Info", nil];
    [self postService:url params:myParams completion:completion];
}


+ (void) sendIncident:params completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"sendInfo"];
    
    NSDictionary *myParams = [NSDictionary dictionaryWithObjectsAndKeys:@"SP6",@"SP", params, @"Info", nil];
    [self postService:url params:myParams completion:completion];
}

+ (void) sendComplaintIncident:params service:(NSString*)service completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"sendInfo"];
    
    NSDictionary *myParams = [NSDictionary dictionaryWithObjectsAndKeys:service,@"SP", params, @"Info", nil];
    
    
    [self postService:url params:myParams completion:completion];
}


+ (void) sendImage:(NSData*)data completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"updates/saveImg?"];
    
    
    //appendPostData
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PUT" URLString:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
                                    [formData appendPartWithFileData:data name:@"profile_pic" fileName:@"ProfilePic" mimeType:@"image/jpeg"];
                                        
                                    } error:nil];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      // This is not called back on the main queue.
                      // You are responsible for dispatching to the main queue for UI updates
                      
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error)
                      {
                          
                          NSLog(@"Error: %@", error);
                          completion(nil, NO);
                          
                      }
                      else
                      {
                          NSLog(@"JSON: %@", responseObject);
                          
                          NSDictionary *jsonDictionary = (NSDictionary *)responseObject;
                          
                          if (completion)
                              completion(jsonDictionary, YES);
                      }
                  }];
    
    [uploadTask resume];
    
    
    
    
    
    
    
    
    
    
    
    /*
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];// Your API
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         //do not put image inside parameters dictionary as I did, but append it!
         [formData appendPartWithFileData:data name:@"test" fileName:@"test" mimeType:@"image/jpeg"];
         
     }
          success:^(NSURLSessionDataTask *task, id responseObject)
     {
         
         NSLog(@"JSON: %@", responseObject);
         
         NSDictionary *jsonDictionary = (NSDictionary *)responseObject;
         
         if (completion)
             completion(jsonDictionary, YES);
         //here is place for code executed in success case
     }
          failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         
         NSLog(@"Error: %@", error);
         completion(nil, NO);
         //here is place for code executed in error case
     }];
    */
    
    
    
    
    
    /*
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager PUT:url parameters:params success:^(NSURLSessionTask *operation, id responseObject) {
        //[manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *jsonDictionary = (NSDictionary *)responseObject;
        
        if (completion)
            completion(jsonDictionary, YES);
        
    } failure:^(NSURLSessionTask *operation, NSError *error){
        NSLog(@"Error: %@", error);
        completion(nil, NO);
    }];
     */
}





//
+ (void) getService: url completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    //NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP7/C"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //[manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    //manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@[@"application/json"]];
    //[manager.responseSerializer setValue:@"application/json" forKey:@"Content-Type"];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *jsonDictionary = (NSDictionary *)responseObject;
        
        if (completion)
            completion(jsonDictionary, YES);
        
    } failure:^(NSURLSessionTask *operation, NSError *error){
        NSLog(@"Error: %@", error);
        completion(nil, NO);
    }];
}



+ (void) postService: url params:params completion: (void (^)(NSDictionary *json, BOOL success))completion {
    
    //NSString *url = [NSString stringWithFormat:@"%@%@",apiURL,@"getInfo/SP7/C"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager PUT:url parameters:params success:^(NSURLSessionTask *operation, id responseObject) {
    //[manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *jsonDictionary = (NSDictionary *)responseObject;
        
        if (completion)
            completion(jsonDictionary, YES);
        
    } failure:^(NSURLSessionTask *operation, NSError *error){
        NSLog(@"Error: %@", error);
        completion(nil, NO);
    }];
}



+(ASIHTTPRequest *)uploadImage:(NSData *) pPostData delegate:(id) pDelegate tag:(NSString *)pTag
{
    
    NSString *sUrl = [NSString stringWithFormat:@"%@%@",apiURL,@"updates/saveImg?"];
    
    NSURL *url = [NSURL URLWithString:sUrl];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request appendPostData:pPostData];
    [request setRequestMethod:@"PUT"];
    [request setDelegate:pDelegate];
    [request setUserInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:pTag, @"tag", nil]];
    [request startAsynchronous];
    return request;
}

@end
