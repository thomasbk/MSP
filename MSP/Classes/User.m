//
//  User.m
//  MSP
//
//  Created by Pro Retina on 8/31/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "User.h"
#import "AppDelegate.h"

@implementation User

@synthesize nombre,cedula,telefono,correo,token,loggedin;
@synthesize latitud,longitud;

+ (id)sharedUser {
    static User *sharedMyUser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyUser = [[self alloc] init];
    });
    return sharedMyUser;
}

- (id)init {
    if (self = [super init]) {
        
        nombre = [[NSUserDefaults standardUserDefaults] stringForKey:@"nombre"];
        cedula = [[NSUserDefaults standardUserDefaults] stringForKey:@"cedula"];
        telefono = [[NSUserDefaults standardUserDefaults] stringForKey:@"telefono"];
        correo = [[NSUserDefaults standardUserDefaults] stringForKey:@"correo"];
        token = [[NSUserDefaults standardUserDefaults] stringForKey:@"token"];
        loggedin = [[NSUserDefaults standardUserDefaults] boolForKey:@"loggedin"];
        latitud = 0;
        longitud = 0;
        
        //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        //[appDelegate setIsLogged:loggedin];
    }
    return self;
}

-(void)resetUser {
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"nombre"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"cedula"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"telefono"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"correo"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loggedin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    nombre = @"";
    cedula = @"";
    telefono = @"";
    correo = @"";
    token = @"";
    loggedin = NO;
}

-(void)login:(NSString *)cedula nombre:(NSString *)nombre telefono:(NSString *)telefono correo:(NSString *)correo token:(NSString *)token {
    
    [[NSUserDefaults standardUserDefaults] setObject:nombre forKey:@"nombre"];
    [[NSUserDefaults standardUserDefaults] setObject:cedula forKey:@"cedula"];
    [[NSUserDefaults standardUserDefaults] setObject:telefono forKey:@"telefono"];
    [[NSUserDefaults standardUserDefaults] setObject:correo forKey:@"correo"];
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loggedin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    self.nombre = nombre;
    self.cedula = cedula;
    self.telefono = telefono;
    self.correo = correo;
    self.token = token;
    self.loggedin = YES;
}


@end
