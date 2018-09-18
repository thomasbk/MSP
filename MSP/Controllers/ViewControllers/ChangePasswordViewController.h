//
//  ChangePasswordViewController.h
//  MSP
//
//  Created by Pro Retina on 9/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ChangePasswordViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirmationField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIButton *endSessionButton;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameTitleLabel;

@property (nonatomic) bool canLogout;

- (IBAction)changeAction:(id)sender;
- (IBAction)endSessionAction:(id)sender;

@end
