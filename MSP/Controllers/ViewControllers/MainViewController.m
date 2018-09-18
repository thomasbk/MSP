//
//  MainViewController.m
//  MSP
//
//  Created by Novacomp on 7/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "MainViewController.h"

#import "AppDelegate.h"
#import <LGSideMenuController.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    LGSideMenuController *sideMenuController = (LGSideMenuController *)[[(AppDelegate*) [[UIApplication sharedApplication] delegate] window] rootViewController];
    
    sideMenuController.leftViewSwipeGestureEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
