//
//  GradientView.m
//  MSP
//
//  Created by Novacomp on 6/27/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "GradientView.h"
#import "Functions.h"

@implementation GradientView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [Functions setGradientBackground:self];
}

@end
