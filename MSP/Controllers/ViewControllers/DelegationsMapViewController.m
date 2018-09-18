//
//  DelegationsMapViewController.m
//  MSP
//
//  Created by Novacomp on 7/3/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "DelegationsMapViewController.h"
#import "NetworkHandler.h"
#import "ListItemTableViewCell.h"
#import "DBHandler.h"
#import "Constants.h"
#import "GMSMarkerWithID.h"
#import "User.h"

@interface DelegationsMapViewController () {
    NSArray *delegationsArray;
    NSArray *filteredArray;
    NSArray *closestDelegations;
    int selectedDelegation;
}

@end

@implementation DelegationsMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.latitude = 9.989217;
    //self.longitude = -84.0872245;
    User *user = [User sharedUser];
    self.latitude = user.latitud;
    self.longitude = user.longitud;
    
    [self getDelegations];
    
    NSString *wazeAppURL = @"waze://";
    NSString *mapsAppURL = @"comgooglemaps://";
    
    BOOL canOpenWaze = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:wazeAppURL]];
    BOOL canOpenMaps = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:mapsAppURL]];
    
    _wazeButton.hidden = !canOpenWaze;
    _mapsButton.hidden = !canOpenMaps;
    
    //[_searchField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(goToWebsite:)];
    [_urlLabel addGestureRecognizer:singleFingerTap];
    
    
    _listadoButton.selected = YES;
    
}


- (void) getClosestDelegations {
    
    [NetworkHandler getClosestDelegations:self.latitude longitud:self.longitude completion:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            NSArray *lista = [json objectForKey:@"DelegCercanas"];
            
            if (lista && lista.count > 0) {
                self->closestDelegations = [DBHandler getDelegacionesForIDs:lista];
                
                [self setMarkers];
            }
            
        }
    }];
}

- (void) setMarkers {
    int i = 0;
    for (NSManagedObject *obj in closestDelegations) {
        
        [super setMapMarker:[obj valueForKeyPath:@"nombre"]  withSnippet:[obj valueForKeyPath:@"descripcion"]  atLatitude:[[obj valueForKeyPath:@"latitud"]  doubleValue] atLongitude:[[obj valueForKeyPath:@"longitud"]  doubleValue] withID: i];
        
        i++;
    }
}


//The event handling method
- (void)goToWebsite:(UITapGestureRecognizer *)recognizer
{
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.seguridadpublica.go.cr"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.seguridadpublica.go.cr"] options:@{} completionHandler:nil];

}

- (void) getDelegations {
    
    filteredArray = delegationsArray = [DBHandler getDelegaciones];
    
    if (!delegationsArray || delegationsArray.count == 0) {
        
        [self showDialog:@"" withMessage:@"No se encontraron delegaciónes"];
    }
    else {
    
        //[self getClosestDelegation];
        [self getClosestDelegations];
    
        [self.tableView reloadData];
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //[super setMapMarker:@"Delegación" withSnippet:@"Seleccione para mostrar acciones" atLatitude:self.latitude atLongitude:self.longitude];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarkerWithID *)marker {
    _viewDetails.hidden = NO;
    _nombreLabel.text = marker.title;
    _direccionLabel.text = marker.snippet;
    selectedDelegation = marker.markerID;
    
    if ([self->delegationsArray[self->selectedDelegation] valueForKeyPath:@"imagen"]  && [delegationsArray[selectedDelegation] valueForKeyPath:@"imagen"]  != (NSString *)[NSNull null]) {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            NSString *url = [NSString stringWithFormat:@"%@%@",IMG_URL,[self->delegationsArray[self->selectedDelegation] valueForKeyPath:@"imagen"]];
            NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url ]];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data != nil) {
                    [self->_imageView setImage:[UIImage imageWithData:data]];
                }
                else {
                    [self->_imageView setImage:[UIImage imageNamed:@"img_delegation"]];
                }
                //[cell.pvItem stopAnimating];
            });
        });
    }
    else {
        [self->_imageView setImage:[UIImage imageNamed:@"img_delegation"]];
    }
    
}

- (IBAction)btnCloseDetails:(UIButton *)sender {
    _viewDetails.hidden = YES;
    
    if (_listadoButton.selected) {
        
        _listView.hidden = NO;
    }
}


- (IBAction)getDirectionsWaze:(id)sender {
    
    NSManagedObject *obj;
    
    obj = _listadoButton.selected ? filteredArray[selectedDelegation] : closestDelegations[selectedDelegation];
    
    if([[obj valueForKeyPath:@"latitud"] doubleValue] != 0) {
        NSString *urlAsString = [NSString stringWithFormat:@"waze://?ll=%lf,%lf&navigate=yes", [[obj valueForKeyPath:@"latitud"] doubleValue] , [[obj valueForKeyPath:@"longitud"] doubleValue] ];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlAsString]]) {
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAsString]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAsString] options:@{} completionHandler:nil];
        }
    }
    else {
        [self showDialog:@"" withMessage:@"No se cuenta con la ubicación de esta delegación"];
    }
}


- (IBAction)getDirectionsMaps:(id)sender {
    
    NSManagedObject *obj;
    
    obj = _listadoButton.selected ? filteredArray[selectedDelegation] : closestDelegations[selectedDelegation];
    
    if([[obj valueForKeyPath:@"latitud"]  doubleValue] != 0) {
        NSString *urlAsString = [NSString stringWithFormat:@"comgooglemaps://?q=%lf,%lf", [[obj valueForKeyPath:@"latitud"] doubleValue] , [[obj valueForKeyPath:@"longitud"] doubleValue] ];
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlAsString]]) {
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAsString]];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAsString] options:@{} completionHandler:nil];
        }
    }
    else {
        [self showDialog:@"" withMessage:@"No se cuenta con la ubicación de esta delegación"];
    }
}


/*
-(void) getClosestDelegation {
    
    CLLocation *closestLocation;
    double closestDistance = 999999999;
    
    for(NSManagedObject *obj in  delegationsArray) {
        
        if ([[obj valueForKeyPath:@"latitud"] doubleValue] > 0) {
            
            CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:self.latitude longitude:self.longitude];
            CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[[obj valueForKeyPath:@"latitud"] doubleValue] longitude:[[obj valueForKeyPath:@"longitud"] doubleValue]];
            
            CLLocationDistance distance = [startLocation distanceFromLocation:endLocation]; // aka double
            if(distance == 0) {
                
                NSLog(@"%@  -  %lf", [obj valueForKeyPath:@"descripcion"], distance);
            }
            
            NSLog(@"%@  -  %lf", [obj valueForKeyPath:@"descripcion"], distance);
            
            if(distance < closestDistance) {
                closestLocation = endLocation;
                closestDistance = distance;
            }
        }
        
    }
    
    [self centerToLocation:closestLocation.coordinate.latitude longitude:closestLocation.coordinate.longitude];
    
}
*/


- (IBAction)searchAction:(UIButton *)sender {
    _viewDetails.hidden = YES;
}


- (IBAction)viewOptionSelected:(UIButton *)sender {
    
    if(sender == _listadoButton) {
        _listView.hidden = NO;
        _listadoButton.selected = YES;
        _mapaButton.selected = NO;
    }
    else {
        
        [self.mapView clear];
        [self setMarkers];
        [self centerToLocation:self.latitude longitude:self.longitude];
        
        _listView.hidden = YES;
        _mapaButton.selected = YES;
        _listadoButton.selected = NO;
    }
    
}

- (IBAction)textFieldDidChange:(UITextField *)textField {
    
    if([textField.text length] > 0){
        //filteredArray = delegationsArray.filter {
        //    $0.cNombre.range(of: textField.text!, options: .caseInsensitive) != nil
        //}
        
        NSPredicate *sPredicate = [NSPredicate predicateWithFormat:@"(nombre contains[c] %@)", textField.text];
        filteredArray = [delegationsArray filteredArrayUsingPredicate:sPredicate];
    }
    else {
        filteredArray = delegationsArray;
    }
    
    [_tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return filteredArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListItemCell"];
    
    [cell.lblItem setText:[filteredArray[indexPath.section] valueForKeyPath:@"nombre"]];
    [cell.imgItem setImage:[UIImage imageNamed:@"ic_dot"]];
    [cell.imgItem setContentMode:UIViewContentModeCenter];
    [cell.pvItem stopAnimating];
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _viewDetails.hidden = NO;
    
    [_searchField resignFirstResponder];
    
    
    _listView.hidden = YES;
    
    NSManagedObject *obj = filteredArray[indexPath.section];
    
    _nombreLabel.text = [obj valueForKeyPath:@"nombre"];
    _direccionLabel.text = [obj valueForKeyPath:@"descripcion"];
    
    
    [self.mapView clear];
    
    if([[obj valueForKeyPath:@"latitud"] doubleValue]) {
        
        [self centerToLocation:[[obj valueForKeyPath:@"latitud"] doubleValue] longitude:[[obj valueForKeyPath:@"longitud"] doubleValue]];
        
        [super setMapMarker:[obj valueForKeyPath:@"nombre"]  withSnippet:[obj valueForKeyPath:@"descripcion"]  atLatitude:[[obj valueForKeyPath:@"latitud"]  doubleValue] atLongitude:[[obj valueForKeyPath:@"longitud"]  doubleValue] withID: indexPath.section];
    }
    else {
        
        [self centerToLocation:self.latitude longitude:self.longitude];
    }
    
    if ([obj valueForKeyPath:@"imagen"] && [obj valueForKeyPath:@"imagen"] != (NSString *)[NSNull null]) {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            
            NSString *url = [NSString stringWithFormat:@"%@%@",IMG_URL,[obj valueForKeyPath:@"imagen"]];
            NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data != nil) {
                    [self->_imageView setImage:[UIImage imageWithData:data]];
                }
                else {
                    [self->_imageView setImage:[UIImage imageNamed:@"img_delegation"]];
                }
                //[cell.pvItem stopAnimating];
            });
        });
    }
    else {
        [self->_imageView setImage:[UIImage imageNamed:@"img_delegation"]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchField resignFirstResponder];
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [[self view] endEditing:TRUE];
    
}

@end
