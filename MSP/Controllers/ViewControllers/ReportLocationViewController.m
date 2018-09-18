//
//  ReportLocationViewController.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "ReportLocationViewController.h"

#import "Functions.h"
#import "Constants.h"

@interface ReportLocationViewController ()

@property (nonatomic) CGFloat originalHeight;
@property (strong, nonatomic) UIImage *imgPhoto;

@end

@implementation ReportLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _originalHeight = _constraintComments.constant;
    
    [_constraintComments setConstant:0];
    
    [_btnCamera setHidden:YES];
    
    [Functions setGradientBackground:_actionBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    [super setMapMarker:@"Ubicación" withSnippet:nil atLatitude:coordinate.latitude atLongitude:coordinate.longitude withID:0];
    
    [_constraintComments setConstant:_originalHeight];
    
    [_btnCamera setHidden:NO];
}

- (IBAction)report:(UITapGestureRecognizer *)sender {
    if (self.mapView.selectedMarker)
    {
        NSMutableArray *actions = [NSMutableArray new];
        
        UIAlertAction *btnAceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        [actions addObject:btnAceptar];
        
        [self showDialog:@"El reporte se ha enviado satisfactoriamente" withMessage:@"" withActions:actions];
    }
    else
    {
        [self showDialog:@"Reportar" withMessage:@"Debe seleccionar la ubicación del reporte"];
    }
}

- (IBAction)takePhoto:(UIButton *)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"El dispositivo no tiene cámara"
                                                             delegate:nil
                                                    cancelButtonTitle:@"Aceptar"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _imgPhoto = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
