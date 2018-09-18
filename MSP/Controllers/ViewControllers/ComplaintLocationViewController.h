//
//  ComplaintLocationViewController.h
//  MSP
//
//  Created by Novacomp on 7/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "MapViewController.h"
#import "ComplaintViewController.h"

@interface ComplaintLocationViewController : MapViewController

@property (weak, nonatomic) IBOutlet UIView *actionBar;

@property (weak, nonatomic) IBOutlet ComplaintViewController *delegate;

@end
