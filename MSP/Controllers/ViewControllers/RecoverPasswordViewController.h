//
//  RecoverPasswordViewController.h
//  MSP
//
//  Created by Pro Retina on 9/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface RecoverPasswordViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)recoverAction:(id)sender;

@end
