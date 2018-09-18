//
//  ListViewController.h
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "BaseViewController.h"

#import "ListItem.h"

@interface ListViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *lblInformation;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintInformation;

@property (strong, nonatomic) NSString *information;
@property (strong, nonatomic) NSMutableArray *data;

- (void)loadData;
- (void)reloadData;

@end
