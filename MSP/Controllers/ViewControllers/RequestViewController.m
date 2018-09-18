//
//  RequestViewController.m
//  MSP
//
//  Created by Novacomp on 7/3/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "RequestViewController.h"

#import "TypeSelectionViewController.h"
#import "Functions.h"

@interface RequestViewController ()

@property (nonatomic) CGFloat originalHeight;

@end

@implementation RequestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _originalHeight = _constraintComments.constant;
    
    [_constraintComments setConstant:0];
    
    [_btnCamera setHidden:YES];
    
    [Functions setGradientBackground:_actionBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [super setMapMarker:@"Ubicación" withSnippet:nil atLatitude:coordinate.latitude atLongitude:coordinate.longitude withID:0];
    
    [_constraintComments setConstant:_originalHeight];
    
    [_btnCamera setHidden:NO];
}

- (IBAction)request:(UITapGestureRecognizer *)sender {
    if (self.mapView.selectedMarker)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
    {
        
    }
}

@end
