//
//  AppDelegate.h
//  MSP
//
//  Created by Novacomp on 5/4/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic) BOOL isLogged;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

- (void)redirectToHome;

@end

