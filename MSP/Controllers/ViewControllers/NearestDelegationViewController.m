//
//  NearestDelegationViewController.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "NearestDelegationViewController.h"

@interface NearestDelegationViewController ()

@end

@implementation NearestDelegationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.latitude = 9.989217;
    self.longitude = -84.0872245;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [super setMapMarker:@"Delegación cercana" withSnippet:@"Haga click para mostrar acciones" atLatitude:self.latitude atLongitude:self.longitude withID:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
}

@end
