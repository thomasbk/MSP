//
//  SearchViewController.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    _allData = [NSMutableArray new];
    
    [_searchBar setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self filterData];
}

- (void)filterData {
    self.data = [NSMutableArray new];
    
    NSString *searchText = [_searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    for (ListItem *item in self.allData)
    {
        if ([searchText isEqualToString:@""] || [[item getItemName] containsString:searchText])
        {
            [self.data addObject:item];
        }
    }
    
    [super reloadData];
}

@end
