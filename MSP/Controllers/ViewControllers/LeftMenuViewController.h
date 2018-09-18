//
//  LeftMenuViewController.h
//  MSP
//
//  Created by Novacomp on 5/21/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
