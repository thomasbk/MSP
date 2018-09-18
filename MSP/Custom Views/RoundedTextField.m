//
//  RoundedTextField.m
//  Novabank
//
//  Created by Novacomp on 7/11/16.
//  Copyright © 2016 Novacomp. All rights reserved.
//

#import "RoundedTextField.h"

#import <QuartzCore/QuartzCore.h>
#import "Functions.h"

@implementation RoundedTextField

- (void)layoutSubviews {
    [super layoutSubviews];

    self.layer.cornerRadius = 20.0;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [self setClipsToBounds:YES];
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    [[UIColor whiteColor] setFill];
    [[self placeholder] drawInRect:rect withAttributes:@{
                                                   NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                   NSForegroundColorAttributeName: [UIColor whiteColor],
                                                   }];
}

@end
