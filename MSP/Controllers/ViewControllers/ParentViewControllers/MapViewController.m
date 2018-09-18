//
//  MapViewController.m
//  MSP
//
//  Created by Novacomp on 5/10/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "MapViewController.h"
#import "GMSMarkerWithID.h"
#import "User.h"

@interface MapViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView.myLocationEnabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!_latitude || !_longitude)
    {
        [self centerToCurrentLocation];
    }
    else
    {
        [self centerToLocation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)centerToCurrentLocation {
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
    }
    
    _locationManager.delegate = self;
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    _locationManager.distanceFilter = 1;
    
    if ([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            
            [self showDialog:@"" withMessage:@"Verificar permisos de localización"];
        }
    }
    [_locationManager startUpdatingLocation];
}

- (void)centerToLocation {
    [_mapView animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:_latitude longitude:_longitude zoom:13]];
}

- (void)centerToLocation:(double)latitude longitude:(double)longitude {
    [_mapView animateToCameraPosition:[GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:13]];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    _latitude = location.coordinate.latitude;
    _longitude = location.coordinate.longitude;

    [_locationManager stopUpdatingLocation];
    
    [self centerToLocation];
    
    User *user = [User sharedUser];
    user.latitud = _latitude;
    user.longitud = _longitude;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"%@",error.userInfo);
    if([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
            
            [self showDialog:@"" withMessage:@"Verificar permisos de localización"];
        }
    }
}

- (GMSMarkerWithID *)addMapMarker:(NSString *)title withSnippet:(NSString *)snippet atLatitude:(CGFloat)latitude atLongitude:(CGFloat)longitude {
    GMSMarkerWithID *marker = [GMSMarkerWithID new];
    
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title = title;
    marker.snippet = snippet;
    marker.map = _mapView;
    
    return marker;
}

- (GMSMarkerWithID *)setMapMarker:(NSString *)title withSnippet:(NSString *)snippet atLatitude:(CGFloat)latitude atLongitude:(CGFloat)longitude withID:(int)myID {
    //_latitude = latitude;
    //_longitude = longitude;
    
    //[_mapView clear];
    
    GMSMarkerWithID *marker = (GMSMarkerWithID*)[self addMapMarker:title withSnippet:snippet atLatitude:latitude atLongitude:longitude];
    
    marker.icon = [UIImage imageNamed:@"ic_marker"];
    
    marker.markerID = myID;
    
    //[_mapView setSelectedMarker:marker];
    
    //marker.map = _mapView;
    
    //[self centerToLocation];
    
    return marker;
}



@end
