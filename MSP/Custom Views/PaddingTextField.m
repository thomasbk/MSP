//
//  PaddingTextField.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "PaddingTextField.h"
#import "Functions.h"

@implementation PaddingTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 10, bounds.origin.y + 8,
                      bounds.size.width - 20, bounds.size.height - 16);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [Functions getRGBA:255 g:255 b:255 a:0.6];
    
    [self setTextColor:[UIColor whiteColor]];
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    [[UIColor whiteColor] setFill];
    [[self placeholder] drawInRect:rect withAttributes:@{
                                                         NSFontAttributeName: [UIFont systemFontOfSize:16],
                                                         NSForegroundColorAttributeName: [UIColor whiteColor],
                                                         }];
}

@end
