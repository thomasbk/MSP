//
//  LoginViewController.m
//  MSP
//
//  Created by Novacomp on 5/4/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "LoginViewController.h"

#import "AppDelegate.h"
#import "NetworkHandler.h"
#import "User.h"
#import "ChangePasswordViewController.h"
#import "Functions.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnLogin:(UIButton *)sender {
    
    if ([self validFields]) {
        
        //Show Loading
        UIAlertController *alert = [Functions getLoading:@"Iniciando sesión"];
        [self presentViewController:alert animated:YES completion:^{
        
            [NetworkHandler validateUser:self->_userField.text password:self->_passwordField.text completion:^(NSDictionary *json, BOOL success) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (success)
        {
            if([json[@"Codigo"] intValue] == 0) {
                //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                
                //[appDelegate setIsLogged:YES];
                
                User *user = [User sharedUser];
                
                [user login:json[@"CEDULA"] nombre:json[@"NAME"] telefono:json[@"PHONE"] correo:self->_userField.text token:json[@"TOKEN"]];
                
                [[NSNotificationCenter defaultCenter]
                 postNotificationName:@"LogInNotification"
                 object:self];
                
                if ([user.token isEqualToString:@"ChangePass"]) { //cambiar contraseña
                    ChangePasswordViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
                    viewController.canLogout = NO;
                    
                    [self.navigationController pushViewController:viewController animated:YES];
                }
                else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }
            else {
                [self showDialog:@"" withMessage:@"Usuario o contraseña inválidos"];
            }
        }
        else {
            [self showDialog:@"" withMessage:@"No existe comunicación con el servidor"];
        }
    }];
            
            }];
    
    }
}

- (bool) validFields {
    bool result = NO;
    
    if (_userField.text.length > 0 && _passwordField.text.length > 0) {
        result = YES;
    }
    else {
        [self showDialog:@"Advertencia" withMessage:@"Por favor verificar los campos"];
    }
    
    return result;
}


- (IBAction)noRegistration:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)forgotPassword:(id)sender {
    
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
