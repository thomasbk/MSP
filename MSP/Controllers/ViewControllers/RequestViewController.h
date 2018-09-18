//
//  RequestViewController.h
//  MSP
//
//  Created by Novacomp on 7/3/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "MapViewController.h"

@interface RequestViewController : MapViewController

@property (weak, nonatomic) IBOutlet UIView *actionBar;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintComments;

@end
