//
//  RegisterViewController.m
//  MSP
//
//  Created by Novacomp on 5/10/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "RegisterViewController.h"
#import "NetworkHandler.h"
#import "Functions.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)registerAction:(id)sender {
    
    if ([self checkFields] == 0) {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:_idField.text,@"CED", _nameField.text,@"NOM", _emailField.text,@"USR", _phoneField.text,@"TEL", _emailField.text,@"EMAIL", _passwordField.text,@"PASS", nil];
        
        
        //Show Loading
        UIAlertController *alert = [Functions getLoading:@"Enviando la información"];
        [self presentViewController:alert animated:YES completion:^{
        
        [NetworkHandler sendInfo:params completion:^(NSDictionary *json, BOOL success) {
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
            if (success)
            {
                if([json[@"Codigo"] intValue] == 0) {
                    
                    NSMutableArray *actions = [NSMutableArray new];
                    
                    UIAlertAction *btnAceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    
                    [actions addObject:btnAceptar];
                    
                    [self showDialog:@"" withMessage:json[@"Resultado"] withActions:actions];
                }
                else {
                    [self showDialog:@"" withMessage:json[@"Resultado"]];
                }
            }
            else {
                [self showDialog:@"" withMessage:@"No existe comunicación con el servidor"];
            }
                
        }];
            
            }];
    }
    else if([self checkFields] == 1) {
        [self showDialog:@"" withMessage:@"Por favor ingrese la información solicitada"];
    }
    else if([self checkFields] == 2) {
        [self showDialog:@"" withMessage:@"Las contraseñas no coinciden"];
    }
    else {
        [self showDialog:@"" withMessage:@"Debe ingresar un correo electrónico válido"];
    }
    
    
}

- (int)checkFields {
    int result = 0;
    if([_nameField.text length] == 0 || [_idField.text length] == 0 || [_passwordField.text length] == 0 || [_confirmPasswordField.text length] == 0 || [_phoneField.text length] == 0 || [_emailField.text length] == 0) {
        result = 1;
    }
    else if(![_confirmPasswordField.text isEqualToString:_passwordField.text]) {
        result = 2;
    }
    else if(![self NSStringIsValidEmail:_emailField.text]) {
        result = 3;
    }
    
    return result;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


@end
