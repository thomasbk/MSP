//
//  DelegationsMapViewController.h
//  MSP
//
//  Created by Novacomp on 7/3/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "MapViewController.h"
#import "ListItem.h"

@interface DelegationsMapViewController : MapViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewDetails;
@property (weak, nonatomic) IBOutlet UILabel *nombreLabel;
@property (weak, nonatomic) IBOutlet UILabel *direccionLabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *wazeButton;
@property (weak, nonatomic) IBOutlet UIButton *mapsButton;

@property (weak, nonatomic) IBOutlet UIButton *listadoButton;
@property (weak, nonatomic) IBOutlet UIButton *mapaButton;
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *listView;

- (IBAction)getDirectionsWaze:(id)sender;
- (IBAction)getDirectionsMaps:(id)sender;
- (IBAction)searchAction:(UIButton *)sender;
- (IBAction)viewOptionSelected:(UIButton *)sender;
- (IBAction)textFieldDidChange:(UITextField *)textField;

@end
