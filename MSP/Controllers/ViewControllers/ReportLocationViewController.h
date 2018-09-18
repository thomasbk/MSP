//
//  ReportLocationViewController.h
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "MapViewController.h"

@interface ReportLocationViewController : MapViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *actionBar;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintComments;

@end
