//
//  ListViewController.m
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "ListViewController.h"

#import "ListItemTableViewCell.h"
#import "Constants.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data = [NSMutableArray new];
    
    [self loadData];
    
    if (_information)
    {
        [_lblInformation setText:_information];
    }
    else
    {
        [_lblInformation setHidden:YES];
        [_constraintInformation setConstant:0];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListItemCell"];
    
    ListItem *item = [_data objectAtIndex:indexPath.section];
    
    [cell.lblItem setText:[item getItemName]];
    
    if ([item getImageURL])
    {
        NSString *url = [NSString stringWithFormat:@"%@%@",IMG_URL,[item getImageURL]];
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data != nil)
                {
                    [cell.imgItem setImage:[UIImage imageWithData:data]];
                }
                else
                {
                    [cell.imgItem setImage:[UIImage imageNamed:@"ic_logo"]];
                }
                
                [cell.pvItem stopAnimating];
            });
        });
    }
    else if ([item getImage])
    {
        [cell.imgItem setImage:[UIImage imageNamed:[item getImage]]];
        
        [cell.pvItem stopAnimating];
        
        if ([cell.imgItem.image isEqual:[UIImage imageNamed:@"ic_dot"]])
        {
            [cell.imgItem setContentMode:UIViewContentModeCenter];
        }
        else
        {
            [cell.imgItem setContentMode:UIViewContentModeScaleAspectFit];
        }
    }
    else
    {
        [cell.imgItem setImage:[UIImage imageNamed:@"ic_logo"]];
        
        [cell.pvItem stopAnimating];
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 1)];
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 0)];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (void)loadData {
    _data = [NSMutableArray new];
}

- (void)reloadData {
    [_tableView reloadData];
}

@end
