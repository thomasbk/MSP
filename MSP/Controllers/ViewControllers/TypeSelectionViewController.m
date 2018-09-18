//
//  TypeSelectionViewController.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "TypeSelectionViewController.h"

#import "ReportLocationViewController.h"
#import "LoginViewController.h"
#import "ListItemTableViewCell.h"
#import "ListItem.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "NetworkHandler.h"
#import "ComplaintViewController.h"
#import "InformationViewController.h"
#import "DBHandler.h"
#import "User.h"

@interface TypeSelectionViewController () {
    
    NSArray *dataArray;
    User *user;
    
}

@end

@implementation TypeSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user = [User sharedUser];
    //AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    //if (!appDelegate.isLogged)
    if (!user.loggedin)
    {
        if (_typeID == TYPE_REPORT)
        {
            [self setInformation:@"Su denuncia nos permitirá tomar acciones preventivas. Con esta herramienta no se genera despacho policial."];
            
            [self showLogin];
        }
        else if (_typeID == TYPE_COMPLAINT)
        {
            [self setInformation:@"Su reporte nos permitirá tomar acciones preventivas. Denuncie en la entidad correspondiente."];
            
            [self showLogin];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSString*)getURLFromText:(NSString*)string {
    NSString *result = @"";
    
    NSArray *words = [string componentsSeparatedByString:@" "];
    for (NSString *word in words) {
        if ([word rangeOfString:@"www."].location == NSNotFound) {
            NSLog(@"string does not contain bla");
        } else {
            result = word;
            break;
        }
    }
    
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListItemTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIViewController *viewController;
    
    ListItem *item = [self.data objectAtIndex:indexPath.section];
    
    if (_typeID == TYPE_REPORT)
    {
        //viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ReportLocationViewController"];
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComplaintViewController"];
        [(ComplaintViewController *)viewController setData:self.data[indexPath.section]];
        [(ComplaintViewController *)viewController setType:0];
    }
    else if (_typeID == TYPE_REQUEST)
    {
        //viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestViewController"];
        
        
        NSString *url = [self getURLFromText:[item getItemDescription]];
        if ([url isEqualToString:@""]) {
            viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
            
            [viewController setTitle:[item getItemName]];
            
            [(InformationViewController *)viewController setItemAndGetRequest:item];
        }
        else {
            NSString *newURL = [NSString stringWithFormat:@"http://%@",url];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:newURL] options:@{} completionHandler:nil];
            
        }
    }
    else if (_typeID == TYPE_COMPLAINT)
    {
        switch (indexPath.section)
        {
            case 0:
            {
                viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComplaintViewController"];
                
                //[(ComplaintViewController *)viewController isAbuse:[cell.lblItem.text isEqualToString:@"Abuso de autoridad"] ];
                [(ComplaintViewController *)viewController isAbuse:YES];
                [(ComplaintViewController *)viewController setData:self.data[indexPath.section]];
                [(ComplaintViewController *)viewController setType:1];
                
                break;
            }
            default:
            {
                viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ComplaintViewController"];
                
                [(ComplaintViewController *)viewController isAbuse:NO];
                [(ComplaintViewController *)viewController setData:self.data[indexPath.section]];
                [(ComplaintViewController *)viewController setType:1];
                
                break;
            }
        }
    }
    else if (_typeID == TYPE_ADVICE)
    {
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"InformationViewController"];
        
        [viewController setTitle:[item getItemName]];
        //[(InformationViewController *)viewController setDescription:[item getItemDescription]];
        [(InformationViewController *)viewController setItemAndGetInfo:item];
    }
    else if (_typeID == TYPE_INFORMATION)
    {
        switch (indexPath.section)
        {
            case 0:
{
                viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DelegationsMapViewController"];
                
                break;
            }
            case 1:
            {
                viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ServicesViewController"];
                
                break;
            }
        }
    }
    
    if (viewController)
    {
        [viewController setTitle:cell.lblItem.text];
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)loadData {
    self.data = [NSMutableArray new];
    
    if (_typeID == TYPE_REPORT)
    {
        dataArray = [DBHandler getCategoriesReportar];
        if (!dataArray || dataArray.count == 0) {
            
            [self showDialog:@"" withMessage:@"No existen datos disponibles"];
        }
        else {
        for (NSManagedObject *obj in self->dataArray) {
            
            ListItem *item = [ListItem new];
            
            [item setItemID:[obj valueForKeyPath:@"id"]];
            [item setItem:[obj valueForKeyPath:@"nombre"]];
            [item setItemDescription:[obj valueForKeyPath:@"descripcion"]];
            if ([[obj valueForKeyPath:@"imagen"] length] > 0) {
                [item setImageURL:[obj valueForKeyPath:@"imagen"]];
            }
            else {
                [item setImage:@"ic_crime_drugs"];
            }
            
            [self.data addObject:item];
        }
        [super reloadData];
        }
    }
    else if (_typeID == TYPE_REQUEST)
    {
        dataArray = [DBHandler getCategoriesSolicitudes];
        if (!dataArray || dataArray.count == 0) {
            
            [self showDialog:@"" withMessage:@"No existen datos disponibles"];
        }
        else {
        for (NSManagedObject *obj in self->dataArray) {
            
            ListItem *item = [ListItem new];
            
            [item setItemID:[obj valueForKeyPath:@"id"]];
            [item setItem:[obj valueForKeyPath:@"nombre"]];
            [item setItemDescription:[obj valueForKeyPath:@"descripcion"]];
            //if ([[obj valueForKeyPath:@"imagen"] length] > 0) {
            //[item setImage:[obj valueForKeyPath:@"imagen"]];
            //}
            //else {
                [item setImage:@"ic_dot"];
            //}
            
            [self.data addObject:item];
        }
        [super reloadData];
        }
        
    }
    else if (_typeID == TYPE_COMPLAINT)
    {
        dataArray = [DBHandler getCategoriesQuejas];
        
        if (!dataArray || dataArray.count == 0) {
            
            [self showDialog:@"" withMessage:@"No existen datos disponibles"];
        }
        else {
        for (NSManagedObject *obj in self->dataArray) {
            
            ListItem *item = [ListItem new];
            
            [item setItemID:[obj valueForKeyPath:@"id"]];
            [item setItem:[obj valueForKeyPath:@"nombre"]];
            [item setItemDescription:[obj valueForKeyPath:@"descripcion"]];
            if ([[obj valueForKeyPath:@"imagen"] length] > 0) {
                [item setImageURL:[obj valueForKeyPath:@"imagen"]];
            }
            else {
                [item setImage:@"ic_dot"];
            }
            
            [self.data addObject:item];
        }
        [super reloadData];
        }
        
    }
    else if (_typeID == TYPE_ADVICE)
    {
        dataArray = [DBHandler getCategoriesConsejos];
        if (!dataArray || dataArray.count == 0) {
            
            [self showDialog:@"" withMessage:@"No existen datos disponibles"];
        }
        else {
        for (NSManagedObject *obj in self->dataArray) {
            
            ListItem *item = [ListItem new];
            
            [item setItemID:[obj valueForKeyPath:@"id"]];
            [item setItem:[obj valueForKeyPath:@"nombre"]];
            [item setItemDescription:[obj valueForKeyPath:@"descripcion"]];
            //if ([[obj valueForKeyPath:@"imagen"] length] > 0) {
            //[item setImage:[obj valueForKeyPath:@"imagen"]];
            //}
            //else {
            [item setImage:@"ic_dot"];
            //}
            
            [self.data addObject:item];
        }
        }
        [super reloadData];
        
    }
    else if (_typeID == TYPE_INFORMATION)
    {
        
        dataArray = [DBHandler getCategoriesInformacion];
        if (!dataArray || dataArray.count == 0) {
            
            [self showDialog:@"" withMessage:@"No existen datos disponibles"];
        }
        else {
            for (NSManagedObject *obj in self->dataArray) {
                
                ListItem *item = [ListItem new];
                
                [item setItemID:[obj valueForKeyPath:@"id"]];
                [item setItem:[obj valueForKeyPath:@"nombre"]];
                [item setItemDescription:[obj valueForKeyPath:@"descripcion"]];
                
                [item setImage:@"ic_dot"];
                
                [self.data addObject:item];
            }
        }
        [super reloadData];
        
    }
    else
    {
        for (int i = 1; i <= 5; i++)
        {
            ListItem *item = [ListItem new];
            
            [item setItemID:[NSNumber numberWithInt:i]];
            [item setItem:[NSString stringWithFormat:@"Item %d", i]];
            [item setImageURL:@"http://www.seguridadpublica.go.cr/PG010041_archivos/image007.gif"];
            
            [self.data addObject:item];
        }
    }
    
    [super reloadData];
}

- (void)showLogin {
    LoginViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self.navigationController pushViewController:viewController animated:NO];
}

@end
