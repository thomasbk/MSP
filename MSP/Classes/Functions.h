//
//  Functions.h
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBAlertViewController.h"

@interface Functions : NSObject

+ (UIColor *)getRGBA:(int)r g:(int)g b:(int)b a:(float)a;
+ (void)setGradientBackground:(UIView *)view;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIAlertController *) getLoading:(NSString *)message;
+ (UIAlertController *) getAlert:(NSString *)nib withTitle:(NSString *)title withMessage:(NSString *)message withActions:(NSArray *)actions;

@end
