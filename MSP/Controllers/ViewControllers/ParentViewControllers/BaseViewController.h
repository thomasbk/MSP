//
//  BaseViewController.h
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSafeArea;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintSafeAreaBottom;

- (void)showDialog:(NSString *)title withMessage:(NSString *)message withActions:(NSArray *)actions;
- (void)showDialog:(NSString *)title withMessage:(NSString *)message;

@end
