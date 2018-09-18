//
//  GMSMarkerWithID.h
//  MSP
//
//  Created by Pro Retina on 8/23/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface GMSMarkerWithID : GMSMarker

@property (nonatomic) int markerID;
@property (nonatomic) int order;
@property (strong, nonatomic) NSObject* referenceObject;
@property (nonatomic) BOOL selected;

@end
