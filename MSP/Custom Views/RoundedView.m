//
//  RoundedView.m
//  Novabank
//
//  Created by Novacomp on 15/11/16.
//  Copyright © 2016 Novacomp. All rights reserved.
//

#import "RoundedView.h"

@implementation RoundedView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.layer.cornerRadius = 20.0;
    
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [self setClipsToBounds:YES];
}

@end
