//
//  MenuViewController.m
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "MenuViewController.h"

#import "TypeSelectionViewController.h"

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITapGestureRecognizer class]])
    {
        UITapGestureRecognizer *gestureRecognizer = (UITapGestureRecognizer *)sender;
        
        UIView *view = gestureRecognizer.view;
        
        UIViewController *vc = segue.destinationViewController;
        
        UILabel *lblMenu = (UILabel *)[view.subviews lastObject];
        
        [vc setTitle:lblMenu.text];
        
        if ([vc isKindOfClass:TypeSelectionViewController.class])
        {
            TypeSelectionViewController *vc = segue.destinationViewController;
            
            [vc setTypeID:view.tag];
        }
    }
}

@end
