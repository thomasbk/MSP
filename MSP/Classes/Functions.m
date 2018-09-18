//
//  Functions.m
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "Functions.h"

@implementation Functions

+ (UIColor *)getRGBA:(int)r g:(int)g b:(int)b a:(float)a {
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

+ (void)setGradientBackground:(UIView *)view {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.layer.bounds;
    
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[Functions getRGBA:0 g:116 b:183 a:1].CGColor,
                            (id)[Functions getRGBA:25 g:39 b:64 a:1].CGColor,
                            nil];
    
    gradientLayer.locations = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0f],
                               [NSNumber numberWithFloat:1.0f],
                               nil];
    
    gradientLayer.cornerRadius = view.layer.cornerRadius;
    [view.layer insertSublayer:gradientLayer atIndex:0];
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}




+ (UIAlertController *) getLoading:(NSString *)message {
    return [self getAlert:@"Loading" withTitle:@"Un momento por favor" withMessage:message withActions:nil];
}

+ (UIAlertController *) getAlert:(NSString *)nib withTitle:(NSString *)title withMessage:(NSString *)message withActions:(NSArray *)actions {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    NBAlertViewController *alertController = [[NBAlertViewController alloc] initWithNibName:nib withTitle:title withMessage:message];
    
    [alert.view addSubview:alertController.view];
    
    CGFloat lineas = ([alertController getContentHeight] / 20);
    
    for (int i = 0; i < lineas; i++)
    {
        [alert setMessage:[alert.message stringByAppendingString:@"\n"]];
    }
    
    CGRect alertFrame = CGRectMake(0, 0, alert.view.frame.size.width, alert.view.frame.size.height);
    
    if (actions != nil)
    {
        for (UIAlertAction *action in actions) {
            [alert addAction:action];
        }
        
        if (actions.count > 2) {
            alertFrame.size.height -= (44 * actions.count) + 1;
        }
        else {
            alertFrame.size.height -= 45;
        }
    }
    
    alertController.view.frame = alertFrame;
    
    return alert;
}


@end
