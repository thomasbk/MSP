//
//  ComplaintLocationViewController.m
//  MSP
//
//  Created by Novacomp on 7/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "ComplaintLocationViewController.h"

#import "TypeSelectionViewController.h"
#import "Functions.h"
#import "Constants.h"
#import "AppDelegate.h"
#import <LGSideMenuController.h>

@interface ComplaintLocationViewController ()

@property (nonatomic) CGFloat originalHeight;
@property (nonatomic) bool seleccionado;

@end

@implementation ComplaintLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [Functions setGradientBackground:_actionBar];
    _seleccionado = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    
    _seleccionado = YES;
    [self.mapView clear];
    
    [super setMapMarker:@"Ubicación" withSnippet:nil atLatitude:coordinate.latitude atLongitude:coordinate.longitude withID:0];
    
    [_delegate setLocation:[NSString stringWithFormat:@"%f,%f", coordinate.latitude, coordinate.longitude]];
    
    
    
}

- (IBAction)report:(UITapGestureRecognizer *)sender {
    if (_seleccionado)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self showDialog:@"Quejas" withMessage:@"Debe seleccionar la ubicación del reporte"];
    }
}

@end
