//
//  DatePickerViewController.m
//  MSP
//
//  Created by Novacomp on 7/6/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "UIViewController+ActionSheetSimulation.h"

@implementation UIViewController (ActionSheetSimulation)

-(UIView *)actionSheetSimulationWithPickerView:(UIDatePicker *)pickerView withToolbar:(UIToolbar *)pickerToolbar {
    
    UIView* simulatedActionSheetView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                                0,
                                                                                UIScreen.mainScreen.bounds.size.width,
                                                                                UIScreen.mainScreen.bounds.size.height)];
    [simulatedActionSheetView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat pickerViewYpositionHidden = UIScreen.mainScreen.bounds.size.height + pickerToolbar.frame.size.height;
    CGFloat pickerViewYposition = UIScreen.mainScreen.bounds.size.height -
    pickerView.frame.size.height +
    UIApplication.sharedApplication.statusBarFrame.size.height;
    [pickerToolbar setFrame:CGRectMake(0,
                                       pickerViewYpositionHidden,
                                       simulatedActionSheetView.frame.size.width,
                                       pickerToolbar.frame.size.height)];
    
    [pickerView setFrame:CGRectMake(0,
                                    pickerViewYpositionHidden,
                                    simulatedActionSheetView.frame.size.width,
                                    200)];
    
    pickerView.backgroundColor = [UIColor whiteColor];
    [simulatedActionSheetView addSubview:pickerToolbar];
    [simulatedActionSheetView addSubview:pickerView];
    
    [UIApplication.sharedApplication.keyWindow?UIApplication.sharedApplication.keyWindow:UIApplication.sharedApplication.windows[0]
                                                                              addSubview:simulatedActionSheetView];
    [simulatedActionSheetView.superview bringSubviewToFront:simulatedActionSheetView];
    
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [simulatedActionSheetView setBackgroundColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5]];
                         [self.view setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
                         [self.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeDimmed];
                         [pickerView setFrame:CGRectMake(pickerView.frame.origin.x,
                                                         pickerViewYposition,
                                                         pickerView.frame.size.width,
                                                         pickerView.frame.size.height)];
                         [pickerToolbar setFrame:CGRectMake(pickerToolbar.frame.origin.x,
                                                            pickerViewYposition - pickerToolbar.frame.size.height,
                                                            pickerToolbar.frame.size.width,
                                                            pickerToolbar.frame.size.height)];
                     }
                     completion:nil];
    
    return simulatedActionSheetView;
}

-(void)dismissActionSheetSimulation:(UIView*)actionSheetSimulation {
    [UIView animateWithDuration:0.25f
                     animations:^{
                         [actionSheetSimulation setBackgroundColor:[UIColor clearColor]];
                         [self.view setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
                         [self.navigationController.navigationBar setTintAdjustmentMode:UIViewTintAdjustmentModeNormal];
                         [actionSheetSimulation.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                             UIView* v = (UIView*)obj;
                             [v setFrame:CGRectMake(v.frame.origin.x,
                                                    UIScreen.mainScreen.bounds.size.height,
                                                    v.frame.size.width,
                                                    v.frame.size.height)];
                         }];
                     }
                     completion:^(BOOL finished) {
                         [actionSheetSimulation removeFromSuperview];
                     }];
    
}
@end
