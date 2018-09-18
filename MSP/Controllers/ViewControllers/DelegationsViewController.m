//
//  DelegationsViewController.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "DelegationsViewController.h"

#import "DelegationViewController.h"

@interface DelegationsViewController ()

@end

@implementation DelegationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:DelegationViewController.class])
    {
        DelegationViewController *viewController = (DelegationViewController *)segue.destinationViewController;
        
        ListItem *item = [self.data objectAtIndex:[self.tableView indexPathForSelectedRow].section];
        
        [viewController setTitle:[item getItemName]];
        [viewController setDelegationID:[item getItemID]];
    }
}

- (void)loadData {
    self.allData = [NSMutableArray new];
    
    for (int i = 1; i <= 5; i++)
    {
        ListItem *item = [ListItem new];
        
        [item setItemID:[NSNumber numberWithInt:i]];
        [item setItem:[NSString stringWithFormat:@"Delegación %d", i]];
        
        [self.allData addObject:item];
    }
    
    [super filterData];
}

@end
