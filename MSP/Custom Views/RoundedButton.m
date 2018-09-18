//
//  RoundedButton.m
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.layer.borderWidth = 0;
    
    [self setClipsToBounds:YES];
}

@end
