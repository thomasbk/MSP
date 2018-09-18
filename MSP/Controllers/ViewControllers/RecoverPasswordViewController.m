//
//  RecoverPasswordViewController.m
//  MSP
//
//  Created by Pro Retina on 9/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "RecoverPasswordViewController.h"
#import "NetworkHandler.h"
#import "ChangePasswordViewController.h"

@interface RecoverPasswordViewController ()

@end

@implementation RecoverPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)recoverAction:(id)sender {
    
    //NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_emailField.text,@"EMAIL", nil];

    [NetworkHandler rememberPassword:_emailField.text completion:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            if([json[@"Codigo"] intValue] == 0) {
                
                NSMutableArray *actions = [NSMutableArray new];
                
                UIAlertAction *btnAceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                
                [actions addObject:btnAceptar];
                
                [self showDialog:@"" withMessage:@"Se ha enviado una nueva contraseña a su correo. Por favor revisar el correo e ingresar de nuevo" withActions:actions];
            }
            else {
                //[self showDialog:@"" withMessage:json[@"Codigo"]];
                [self showDialog:@"" withMessage:@"El correo no se encuentra registrado"];
            }
        }
    }];
}

@end
