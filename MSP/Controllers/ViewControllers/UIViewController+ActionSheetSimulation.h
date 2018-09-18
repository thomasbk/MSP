//
//  DatePickerViewController.h
//  MSP
//
//  Created by Novacomp on 7/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ActionSheetSimulation)

-(UIView*) actionSheetSimulationWithPickerView:(UIDatePicker*)pickerView withToolbar: (UIToolbar*)pickerToolbar;
-(void)dismissActionSheetSimulation:(UIView*)actionSheetSimulation;

@end
