//
//  ComplaintViewController.h
//  MSP
//
//  Created by Novacomp on 6/28/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseViewController.h"

@interface ComplaintViewController : BaseViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintPersonalData;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintGenres;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintReason;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHideReason;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintReasonTitleOff;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintReasonTitleOn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightGenero;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightRazon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintHeightUbicacion;

@property (weak, nonatomic) IBOutlet UIImageView *imgArrowGenre;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrowReason;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrowImage;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (weak, nonatomic) IBOutlet UILabel *fechaSelectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *generoSelectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *razonSelectedLabel;
@property (weak, nonatomic) IBOutlet UILabel *ubicacionSelectedLabel;

@property (weak, nonatomic) IBOutlet UIView *viewPersonalData;
@property (weak, nonatomic) IBOutlet UIView *viewGenres;
@property (weak, nonatomic) IBOutlet UIView *viewReason;

@property (weak, nonatomic) IBOutlet UITextField *nombreField;
@property (weak, nonatomic) IBOutlet UITextField *cedulaField;
@property (weak, nonatomic) IBOutlet UITextField *telefonoField;
@property (weak, nonatomic) IBOutlet UITextView *commentField;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *pickerViewBack;
@property (nonatomic) int type;

- (void)isAbuse:(BOOL)abuse;
- (void)setData:(NSDictionary*)data;
- (void)setLocation:(NSString*)location;

@end
