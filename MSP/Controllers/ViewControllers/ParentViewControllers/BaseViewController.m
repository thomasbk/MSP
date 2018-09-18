//
//  BaseViewController.m
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_constraintSafeArea)
    {
        CGFloat topSafeArea;
        
        if (@available(iOS 11.0, *))
        {
            UIWindow *window = UIApplication.sharedApplication.keyWindow;
            topSafeArea = window.safeAreaInsets.top;
        }
        else
        {
            topSafeArea = self.topLayoutGuide.length;
        }
        
        if (topSafeArea == 0)
        {
            topSafeArea = 10;
        }
        
        _constraintSafeArea.constant = topSafeArea;
    }
    
    if (_constraintSafeAreaBottom)
    {
        CGFloat bottomSafeArea;
        
        if (@available(iOS 11.0, *))
        {
            UIWindow *window = UIApplication.sharedApplication.keyWindow;
            bottomSafeArea = window.safeAreaInsets.bottom;
        }
        else
        {
            bottomSafeArea = self.bottomLayoutGuide.length;
        }
        
        if (bottomSafeArea == 0)
        {
            bottomSafeArea = 10;
        }
        
        _constraintSafeAreaBottom.constant = bottomSafeArea;
    }
    
    [_lblTitle setText:self.title];
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showDialog:(NSString *)title withMessage:(NSString *)message withActions:(NSArray *)actions {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (actions == nil)
    {
        UIAlertAction *btnAceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
        }];
        
        actions = [[NSArray alloc] initWithObjects:btnAceptar, nil];
    }
    
    for (UIAlertAction *action in actions)
    {
        [alert addAction:action];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showDialog:(NSString *)title withMessage:(NSString *)message {
    [self showDialog:title withMessage:message withActions:nil];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
}


@end
