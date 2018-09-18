//
//  ComplaintViewController.m
//  MSP
//
//  Created by Novacomp on 6/28/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "ComplaintViewController.h"

#import "ComplaintLocationViewController.h"

#import "UIViewController+ActionSheetSimulation.h"
#import "NetworkHandler.h"
#import "DBHandler.h"
#import "ListItem.h"
#import "Functions.h"
#import "User.h"
#import "ASIHTTPRequest.h"


@interface ComplaintViewController () {
    int pickerType;
    NSArray *generoList;
    int selectedGenero;
    NSArray *discriminatedList;
    int selectedDiscriminated;
    CGSize imageSize;
    bool anonymous;
    User *user;
    UITextField *currentTextField;
    
    NSData *imageData;
    NSMutableDictionary *params;
}

@property (strong, nonatomic) NSString *genre;
@property (strong, nonatomic) UIView *datePickerView;
@property (strong, nonatomic) NSNumber *complaintID;
@property (strong, nonatomic) NSString *selectedDate;
@property (strong, nonatomic) NSString *selectedDateShort;
@property (strong, nonatomic) NSString *location;


@end

@implementation ComplaintViewController

@synthesize type;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageSize = CGSizeMake(960, 640);
    
    pickerType = 1;
    selectedGenero = -1;
    selectedDiscriminated = -1;
    
    generoList = [DBHandler getGeneros];
    discriminatedList = [DBHandler getDiscriminaciones];
    
    anonymous = NO;
    user = [User sharedUser];
    
    
    _constraintHeightGenero.constant = 0;
    _constraintHeightRazon.constant = 0;
    _constraintHeightUbicacion.constant = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Listen for keyboard appearances and disappearances
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [self setOptions];
    
    // Logged in
    if (user.loggedin) {
        _nombreField.text = user.nombre;
        _cedulaField.text = user.cedula;
        _telefonoField.text = user.telefono;
    }
}

- (void)keyboardDidShow: (NSNotification *) notif {
    
    if(!currentTextField) {
        NSValue *val = notif.userInfo[UIKeyboardFrameBeginUserInfoKey];
        CGRect keyboardSize = val.CGRectValue;
        
        if (self.view.frame.origin.y == 0) {
            //self.view.frame.origin.y -= keyboardSize.size.height;
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardSize.size.height, self.view.frame.size.width, self.view.frame.size.height);
        }
    }
    
}

- (void)keyboardWillHide: (NSNotification *) notif {
    
    if (self.view.frame.origin.y != 0) {
        self.view.frame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
}

-(void) setOptions {
    
    if (type == 1) { // is complaint, dont allow picture
        //_constraintHideImage.constant = 0;
        //_imgArrowImage.hidden = YES;
        _imageButton.hidden = YES;
    }
    
    if (![self.lblTitle.text isEqualToString: @"Abuso de autoridad"]) {
        
        //[_constraintHideReason setActive:YES];
        _constraintHideReason.constant = 0;
        _imgArrowReason.hidden = YES;
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_constraintGenres setActive:YES];
    [_constraintReason setActive:YES];
    
    [_viewGenres setHidden:YES];
    [_viewReason setHidden:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)swAnonymous:(UISwitch *)sender {
    _constraintPersonalData.active = sender.isOn;
    anonymous = sender.isOn;
}

- (void)setData:(ListItem*)data {
    _complaintID = data.getItemID;
}

- (void)isAbuse:(BOOL)abuse {
    _constraintReasonTitleOff.active = YES;
    //_constraintReasonTitleOn.active = !abuse;
}

- (IBAction)genreSelect:(NSLayoutConstraint *)sender {
    /*if (_constraintGenres.isActive) {
        [_imgArrowGenre setImage:[UIImage imageNamed:@"ic_up"]];
    }
    else {
        [_imgArrowGenre setImage:[UIImage imageNamed:@"ic_down"]];
    }
    */
    //[_constraintGenres setActive:!_constraintGenres.isActive];
    //[_viewGenres setHidden:_constraintGenres.isActive];
    
    pickerType = 1;
    [_pickerView selectRow:selectedGenero inComponent:0 animated:NO];
    [_pickerView reloadAllComponents];
    _pickerViewBack.hidden = false;
}

- (IBAction)reasonSelect:(NSLayoutConstraint *)sender {
    /*
    if (_constraintReason.isActive) {
        [_imgArrowReason setImage:[UIImage imageNamed:@"ic_up"]];
    }
    else {
        [_imgArrowReason setImage:[UIImage imageNamed:@"ic_down"]];
    }
    */
    //[_constraintReason setActive:!_constraintReason.isActive];
    //[_viewReason setHidden:_constraintReason.isActive];
    
    pickerType = 2;
    [_pickerView selectRow:selectedDiscriminated inComponent:0 animated:NO];
    [_pickerView reloadAllComponents];
    _pickerViewBack.hidden = false;
}


- (IBAction)cancelPickerView:(id)sender {
    
    _pickerViewBack.hidden = YES;
    /*
    if(pickerType == 1) {
        [_imgArrowGenre setImage:[UIImage imageNamed:@"ic_down"]];
    }
    else {
        [_imgArrowReason setImage:[UIImage imageNamed:@"ic_down"]];
    }
     */
}

- (IBAction)acceptPickerView:(id)sender {
    
    _pickerViewBack.hidden = YES;
    
    if(pickerType == 1) {
        //[_imgArrowGenre setImage:[UIImage imageNamed:@"ic_down"]];
        selectedGenero = [_pickerView selectedRowInComponent:0];
        _generoSelectedLabel.text = [generoList[selectedGenero] valueForKeyPath:@"descripcion"];
        
        _constraintHeightGenero.constant = 20;
    }
    else {
        //[_imgArrowReason setImage:[UIImage imageNamed:@"ic_down"]];
        selectedDiscriminated = [_pickerView selectedRowInComponent:0];
        _razonSelectedLabel.text = [discriminatedList[selectedDiscriminated] valueForKeyPath:@"descripcion"];
        
        _constraintHeightRazon.constant = 20;
    }
    
}




- (IBAction)send:(UITapGestureRecognizer *)sender {
    
    if ([self isReady]) {
    
        NSString *anonimo = anonymous ? @"1" : @"0";
        NSString *nombre = _nombreField.text;
        NSString *cedula = _cedulaField.text;
        NSString *telefono = _telefonoField.text;
        NSString *codGenero = [generoList[selectedGenero] valueForKeyPath:@"id"];
        
        NSString *codDiscriminado = _imgArrowReason.isHidden ? @"0" : [discriminatedList[selectedDiscriminated] valueForKeyPath:@"id"];
        _location = _location ? _location : @"";
        NSString *comentario = _commentField.text;
        NSString *token = anonymous ? @"ANONIMO" : user.token;
        
        params = [NSMutableDictionary dictionaryWithObjectsAndKeys:_complaintID,@"TIP", anonimo,@"ANON", nombre,@"NOM", codGenero,@"ORIE", telefono,@"TEL", codDiscriminado,@"SCDI", cedula,@"CED", _location, @"CGR", comentario,@"DET", _selectedDate, @"FEC", token,@"TOK", nil];
    
        if (!imageData) { // Doesnt have image
            
            //Show Loading
            UIAlertController *alert = [Functions getLoading:@"Obteniendo información"];
            [self presentViewController:alert animated:YES completion:^{
            
                [self sendData:self->params];
                
            }];
        }
        else { // Has image
            
            //Show Loading
            UIAlertController *alert = [Functions getLoading:@"Obteniendo información"];
            [self presentViewController:alert animated:YES completion:^{
            
                [NetworkHandler uploadImage:self->imageData delegate:self tag:@"Imagen"];
                
                }];
            
        }
        
        
    }
}

- (void) sendData:(NSDictionary*)params {
    
    NSString *tipo = type == 1 ? @"SP5" : @"SP6";
    
    int dataID = arc4random_uniform(1000);
    
    [DBHandler saveReportePorEnviar:params imageData:imageData type:tipo reporteID:dataID];
    
    
    [NetworkHandler sendComplaintIncident:params service:tipo completion:^(NSDictionary *json, BOOL success) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        if (success)
        {
            [DBHandler deleteReportePorEnviar:dataID];
            
            if([json[@"Codigo"] intValue] == 0) {
                NSMutableArray *actions = [NSMutableArray new];
                
                UIAlertAction *btnAceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }];
                
                [actions addObject:btnAceptar];
                
                if (self.type == 1) {
                    [self showDialog:@"" withMessage:@"La queja se ha sido enviado satisfactoriamente" withActions:actions];
                    
                }
                else {
                    [self showDialog:@"" withMessage:@"El reporte ha sido enviado satisfactoriamente" withActions:actions];
                }
            }
            else {
                [self showDialog:@"" withMessage:@"Por favor verificar los campos"];
            }
        }
        else {
            [self showDialog:@"" withMessage:@"Ha ocurrido un error, verifique su conexión. Su reporte ha sido almacenado y se enviará cuando exista conexión"];
        }
        
    }];
}

- (bool) isReady {
    bool result = YES;
    
    NSString *nombre = _nombreField.text;
    NSString *cedula = _cedulaField.text;
    NSString *telefono = _telefonoField.text;
    _location = _location ? _location : @"";
    NSString *comentario = _commentField.text;
    
    if(!anonymous && (nombre.length == 0 || cedula.length == 0 || telefono.length == 0) ) {
            result = NO;
            [self showDialog:nil withMessage:@"Debe ingresar sus datos o seleccionar reporte anónimo"];
    }
    else if(selectedGenero < 0) {
        result = NO;
        [self showDialog:nil withMessage:@"Debe seleccionar su género"];
    }
    else if(!_imgArrowReason.isHidden && selectedDiscriminated < 0) {
        result = NO;
        [self showDialog:nil withMessage:@"Debe seleccionar una razón de discriminación"];
    }
    else if ([_location isEqualToString:@""]) {
        result = NO;
        [self showDialog:nil withMessage:@"Debe seleccionar una ubicación"];
    }
    else if (!comentario || [comentario isEqualToString:@""] || [comentario isEqualToString:@"Comentarios"]) {
        result = NO;
        [self showDialog:nil withMessage:@"Debe ingresar un comentario"];
    }
    
    
    return result;
    
}


- (IBAction)selectDate:(UITapGestureRecognizer *)sender {
    UIDatePicker *datePicker = [UIDatePicker new];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.date = [NSDate date];
    
    [datePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    toolbar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    NSMutableArray *items = [[NSMutableArray alloc] init];
    //[items addObject:[[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleDone target:self action:@selector(cancelDatePicker)]];
    [items addObject: [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]];
    [items addObject:[[UIBarButtonItem alloc] initWithTitle:@"Aceptar   " style:UIBarButtonItemStyleDone target:self action:@selector(closeDatePicker)]];
    [toolbar setItems:items animated:NO];
    
    _datePickerView = [self actionSheetSimulationWithPickerView:datePicker withToolbar:toolbar];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
    _selectedDate = [dateFormat stringFromDate:datePicker.date];
    
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    _selectedDateShort = [dateFormat stringFromDate:datePicker.date];
}

- (IBAction)selectLocation:(UITapGestureRecognizer *)sender {
    ComplaintLocationViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComplaintLocationViewController"];

    viewController.delegate = self;
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)setLocation:(NSString*)location {
    _location = location;
    _ubicacionSelectedLabel.text = _location;
    
    _constraintHeightUbicacion.constant = 20;
}

- (void)closeDatePicker {
    
    [self dismissActionSheetSimulation:_datePickerView];
    
    [_datePickerView removeFromSuperview];
    
    _fechaSelectedLabel.text = _selectedDateShort;
    
    _datePickerView = nil;
}

- (void)dateSelected:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
    _selectedDate = [dateFormat stringFromDate:sender.date];
    
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    _selectedDateShort = [dateFormat stringFromDate:sender.date];
    
}


- (IBAction)getPicture:(id)sender {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Seleccionar" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cámara" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self takePhoto];
        // Distructive button tapped.
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Galería" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self selectPhoto];
        // OK button tapped.
    }]];
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
}


- (void)takePhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)selectPhoto {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    
    
    imageData = UIImageJPEGRepresentation([Functions imageWithImage:chosenImage scaledToSize:imageSize],0.3);
    
    _imageButton.selected = YES;
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString * tag = [request.userInfo objectForKey:@"tag"];
    NSString *response = [request responseString];
    if([tag isEqualToString:@"Imagen"])
    {
        NSLog(response);
        
        NSData* dataJson = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:dataJson options:0 error:nil];
        if(data != nil){
            if ([[data[@"Codigo"] stringValue] isEqualToString:@"0"]) {
            
                [params setObject:data[@"idImagen"] forKey:@"IMG"];
                
                [self sendData:params];
            }
            else {
            
            }
        }
    }
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    int result = 0;
    if(pickerType == 1) {
        result = generoList.count;
    }
    else {
        result = discriminatedList.count;
    }
    return result;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *result = @"";
    
    if(pickerType == 1) {
        result = [generoList[row] valueForKeyPath:@"descripcion"];
    }
    else {
        result = [discriminatedList[row] valueForKeyPath:@"descripcion"];
    }
    
    return result;
}



#pragma mark -
#pragma mark Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //currentTextField = textField;
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    currentTextField = textField;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    currentTextField = nil;
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

@end
