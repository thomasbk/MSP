//
//  MapViewController.h
//  MSP
//
//  Created by Novacomp on 5/10/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

#import "BaseViewController.h"

@interface MapViewController : BaseViewController <GMSMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;

@property (nonatomic) CGFloat latitude;
@property (nonatomic) CGFloat longitude;

- (void)centerToLocation;
- (void)centerToLocation:(double)latitude longitude:(double)longitude;
- (GMSMarker *)addMapMarker:(NSString *)title withSnippet:(NSString *)snippet atLatitude:(CGFloat)latitude atLongitude:(CGFloat)longitude;
- (GMSMarker *)setMapMarker:(NSString *)title withSnippet:(NSString *)snippet atLatitude:(CGFloat)latitude atLongitude:(CGFloat)longitude withID:(int)myID;

@end
