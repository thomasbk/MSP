//
//  SearchViewController.h
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "ListViewController.h"

@interface SearchViewController : ListViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *allData;

- (void)filterData;

@end
