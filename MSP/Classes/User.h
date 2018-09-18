//
//  User.h
//  MSP
//
//  Created by Pro Retina on 8/31/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, retain) NSString *nombre;
@property (nonatomic, retain) NSString *cedula;
@property (nonatomic, retain) NSString *telefono;
@property (nonatomic, retain) NSString *correo;
@property (nonatomic, retain) NSString *token;
@property (nonatomic) double latitud;
@property (nonatomic) double longitud;
@property (nonatomic) bool loggedin;

+ (id)sharedUser;
- (void)resetUser;
-(void)login:(NSString *)cedula nombre:(NSString *)nombre telefono:(NSString *)telefono correo:(NSString *)correo token:(NSString *)token;

@end
