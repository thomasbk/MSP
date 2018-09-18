//
//  DelegationsTabBarController.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "DelegationsTabBarController.h"

#import "Functions.h"

@interface DelegationsTabBarController ()

@end

@implementation DelegationsTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customizeTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)customizeTabBar {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height + [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom)];
    
    [Functions setGradientBackground:backgroundView];
    
    [self.tabBar setBarTintColor:[UIColor colorWithPatternImage:[self changeViewToImage:backgroundView]]];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4, self.tabBar.frame.size.height)];
    
    [view setBackgroundColor:[UIColor clearColor]];
    
    double yPos = 0;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone && UIScreen.mainScreen.nativeBounds.size.height == 2436)
    {
        yPos = view.frame.size.height - 2;
    }
    else
    {
        yPos = 0;
    }
    
    UIImageView *border = [[UIImageView alloc]initWithFrame:CGRectMake(0, yPos, view.frame.size.width, 2)];
    
    border.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:border];
    
    [self.tabBar setSelectionIndicatorImage:[self changeViewToImage:view]];
}

- (UIImage *)changeViewToImage:(UIView *)viewForImage {
    UIGraphicsBeginImageContext(viewForImage.frame.size);
    
    [viewForImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
