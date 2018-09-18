//
//  ChangePasswordViewController.m
//  MSP
//
//  Created by Pro Retina on 9/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "NetworkHandler.h"
#import "User.h"

@interface ChangePasswordViewController () {
    User *user;
}

@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    user = [User sharedUser];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_canLogout) {
        _separatorView.hidden = YES;
        _endSessionButton.hidden = YES;
    }
    
    _userNameLabel.text = user.nombre;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeAction:(id)sender {
    
    if([self isReady]) {
        
    [NetworkHandler changePassword:user.correo old:_oldPasswordField.text new:_passwordField.text completion:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            if([json[@"Codigo"] intValue] == 0) {
                
                
                if (!self->_canLogout) {
                    [self login];
                }
                else {
                    NSMutableArray *actions = [NSMutableArray new];
                    
                    UIAlertAction *btnAceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    [self.navigationController popViewControllerAnimated:YES];
                    }];
                
                    [actions addObject:btnAceptar];
                
                    [self showDialog:@"Éxito" withMessage:@"Se ha cambiado su contraseña exitosamente" withActions:actions];
                }
            }
            else {
                [self showDialog:@"" withMessage:@"Por favor verificar los campos"];
            }
        }
    }];
    }
}


-(void) login {
    [NetworkHandler validateUser:user.correo password:_passwordField.text completion:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            if([json[@"Codigo"] intValue] == 0) {
                //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                
                //[appDelegate setIsLogged:YES];
                
                User *user = [User sharedUser];
                //user.correo = self->_userField.text;
                user.nombre = json[@"NAME"];
                user.cedula = json[@"CEDULA"];
                user.telefono = json[@"PHONE"];
                user.loggedin = YES;
                user.token = json[@"TOKEN"];
                
                NSMutableArray *actions = [NSMutableArray new];
                
                UIAlertAction *btnAceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    
                    NSArray *viewControllers = self.navigationController.viewControllers;
                    
                    [self.navigationController popToViewController:viewControllers[viewControllers.count - 3] animated:YES];
                    
                    //[self.navigationController popViewControllerAnimated:YES];
                }];
                [actions addObject:btnAceptar];
                
                [self showDialog:@"Éxito" withMessage:@"Se ha cambiado su contraseña exitosamente" withActions:actions];
                
            }
            else {
                [self showDialog:@"" withMessage:@"Usuario o contraseña inválidos"];
            }
        }
    }];
}





- (bool) isReady {
    bool result = YES;
    
    if(![_passwordField.text isEqualToString:_passwordConfirmationField.text] ) { //contraseñas no match
        result = NO;
        [self showDialog:nil withMessage:@"Las contraseñas no coinciden"];
    }
    else if(_passwordField.text.length == 0 || _oldPasswordField.text == 0) { // alguno vacio
        result = NO;
        [self showDialog:nil withMessage:@"Por favor verificar los campos"];
    }
    else if([_passwordField.text isEqualToString:_oldPasswordField.text]) { // contraseña vieja == nueva
        result = NO;
        [self showDialog:nil withMessage:@"La contraseña nueva no puede ser igual a la anterior"];
    }
    
    return result;
    
}



- (IBAction)endSessionAction:(id)sender {
    
    [user resetUser];
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"LogOutNotification"
     object:self];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
