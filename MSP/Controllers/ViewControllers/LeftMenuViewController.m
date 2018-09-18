//
//  LeftMenuViewController.m
//  MSP
//
//  Created by Novacomp on 5/21/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "LeftMenuViewController.h"

#import "UIViewController+LGSideMenuController.h"
#import "DelegationsMapViewController.h"

#import "SideMenuTableViewCell.h"
#import "TypeSelectionViewController.h"
#import "ChangePasswordViewController.h"

#import "NetworkHandler.h"
#import "DBHandler.h"
#import "User.h"
#import "Functions.h"

#import "ReportSender.h"

@interface LeftMenuViewController () {
    NSMutableArray *estadoConsulta;
    
    User *user;
    
    bool showingLoading;
    
}

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    user = [User sharedUser];
    showingLoading = NO;
    
    [self.tableView setTableFooterView:[UIView new]];
    
    [self getDates];
    
    ReportSender *sender = [[ReportSender alloc] init];
    [sender sendSavedReports];
    
    //[self loadData];
    estadoConsulta = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveLoginNotification:)
                                                 name:@"LogInNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveLoginNotification:)
                                                 name:@"LogOutNotification"
                                               object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) receiveLoginNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"LogInNotification"]) {
        
        [self.tableView reloadData];
    }
    else if ([[notification name] isEqualToString:@"LogOutNotification"]) {
        
        [self.tableView reloadData];
    }
}



- (void)getDates {
    
    [NetworkHandler getDates:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            for(NSDictionary *dict in json[@"FECHAS"]) {
                
                bool loadedInfo = NO;
                
                NSString *incidenteDate = [DBHandler getFechaForID:dict[@"ID"]];
                if([incidenteDate isEqualToString:@""] || ![incidenteDate isEqualToString: dict[@"DES"]]) {
                    
                    if([dict[@"ID"] intValue] == 62) {
                        //get incidentes
                        [self getInformacion];
                        [self->estadoConsulta replaceObjectAtIndex:0 withObject:@"1"];
                        loadedInfo = YES;
                    }
                    else if([dict[@"ID"] intValue] == 63) {
                        //get solicitudes
                        [self getSolicitudes];
                        [self->estadoConsulta replaceObjectAtIndex:1 withObject:@"1"];
                        
                        if (!loadedInfo) {
                            [self getInformacion];
                            [self->estadoConsulta replaceObjectAtIndex:0 withObject:@"1"];
                            loadedInfo = YES;
                        }
                    }
                    else if([dict[@"ID"] intValue] == 64) {
                        //get quejas
                        
                        if (!loadedInfo) {
                            [self getInformacion];
                            [self->estadoConsulta replaceObjectAtIndex:0 withObject:@"1"];
                            loadedInfo = YES;
                        }
                    }
                    else if([dict[@"ID"] intValue] == 65) {
                        //get consejos
                        [self getConsejos];
                        [self->estadoConsulta replaceObjectAtIndex:2 withObject:@"1"];
                        
                        if (!loadedInfo) {
                            [self getInformacion];
                            [self->estadoConsulta replaceObjectAtIndex:0 withObject:@"1"];
                            loadedInfo = YES;
                        }
                    }
                    else if([dict[@"ID"] intValue] == 66) {
                        //get informacion
                        if (!loadedInfo) {
                            [self getInformacion];
                            [self->estadoConsulta replaceObjectAtIndex:0 withObject:@"1"];
                            loadedInfo = YES;
                        }
                    }
                    else if([dict[@"ID"] intValue] == 67) {
                        //get delegaciones
                        [self getDelegaciones];
                        [self->estadoConsulta replaceObjectAtIndex:3 withObject:@"1"];
                    }
                    else if([dict[@"ID"] intValue] == 72) {
                        //get informacion
                        if (!loadedInfo) {
                            [self getInformacion];
                            [self->estadoConsulta replaceObjectAtIndex:0 withObject:@"1"];
                            loadedInfo = YES;
                        }
                    }
                    else if([dict[@"ID"] intValue] == 73) {
                        //get informacion
                        if (!loadedInfo) {
                            [self getInformacion];
                            [self->estadoConsulta replaceObjectAtIndex:0 withObject:@"1"];
                            loadedInfo = YES;
                        }
                    }
                }
            }
            
            
            [DBHandler saveDates:json];
        }
    }];
}

- (void)getSolicitudes {
    
    if (!showingLoading) {
        UIAlertController *alert = [Functions getLoading:@"Obteniendo información"];
        showingLoading = YES;
        [self presentViewController:alert animated:YES completion:nil];
    }
    
        
    [NetworkHandler getRequests:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            [DBHandler saveSolicitudes:json];
        }
        [self->estadoConsulta replaceObjectAtIndex:1 withObject:@"2"];
        if([self allFinished]) {
            // hide loading
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
        
    
}

- (void)getConsejos {
    
    if (!showingLoading) {
        UIAlertController *alert = [Functions getLoading:@"Obteniendo información"];
        showingLoading = YES;
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    [NetworkHandler getAdvice:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            [DBHandler saveConsejos:json];
        }
        [self->estadoConsulta replaceObjectAtIndex:2 withObject:@"2"];
        if([self allFinished]) {
            // hide loading
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}


- (void)getInformacion {
    
    if (!showingLoading) {
        UIAlertController *alert = [Functions getLoading:@"Obteniendo información"];
        showingLoading = YES;
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    [NetworkHandler getParameters:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            [DBHandler saveInfo:json];
        }
        [self->estadoConsulta replaceObjectAtIndex:0 withObject:@"2"];
        if([self allFinished]) {
            // hide loading
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)getDelegaciones {
    if (!showingLoading) {
        UIAlertController *alert = [Functions getLoading:@"Obteniendo información"];
        showingLoading = YES;
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    [NetworkHandler getDelegations:^(NSDictionary *json, BOOL success) {
        if (success)
        {
            [DBHandler saveDelegaciones:json];
        }
        [self->estadoConsulta replaceObjectAtIndex:3 withObject:@"2"];
        if([self allFinished]) {
            // hide loading
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}



- (bool) allFinished {
    bool result = true;
    
    for(NSString *state in estadoConsulta) {
        if([state isEqualToString:@"1"]) {
            result = false;
            break;
        }
    }
    
    return result;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    int result = 5;
    if(user.loggedin) {
        result = 6;
    }
    return result;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SideMenuCell" forIndexPath:indexPath];
    
    switch (indexPath.section)
    {
        case 0:
        {
            [cell.imgItem setImage:[UIImage imageNamed:@"ic_report"]];
            [cell.lblItem setText:@"Reportar"];
            
            break;
        }
        case 1:
        {
            [cell.imgItem setImage:[UIImage imageNamed:@"ic_requests"]];
            [cell.lblItem setText:@"Solicitudes"];
            
            break;
        }
        case 2:
        {
            [cell.imgItem setImage:[UIImage imageNamed:@"ic_complaints"]];
            [cell.lblItem setText:@"Quejas"];
            
            break;
        }
        case 3:
        {
            [cell.imgItem setImage:[UIImage imageNamed:@"ic_advices"]];
            [cell.lblItem setText:@"Consejos"];
            
            break;
        }
        case 4:
        {
            [cell.imgItem setImage:[UIImage imageNamed:@"ic_delegations"]];
            [cell.lblItem setText:@"Delegaciones"];
            
            break;
        }
        case 5:
        {
            [cell.imgItem setImage:[UIImage imageNamed:@"ajustes_icon"]];
            [cell.lblItem setText:@"Ajustes"];
            
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LGSideMenuController *mainViewController = (LGSideMenuController *)self.sideMenuController;
    
    UINavigationController *navigationController = (UINavigationController *)mainViewController.rootViewController;
    
    if (indexPath.section == 4)
    {
        DelegationsMapViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DelegationsMapViewController"];
        
        [navigationController pushViewController:viewController animated:YES];
    }
    else if (indexPath.section == 5) {
        ChangePasswordViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
        
        viewController.canLogout = YES;
        
        [navigationController pushViewController:viewController animated:YES];
    }
    else
    {
        TypeSelectionViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TypeSelectionViewController"];
        
        SideMenuTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [viewController setTitle:cell.lblItem.text];
        [viewController setTypeID:self.tableView.indexPathForSelectedRow.section + 1];
        
        [navigationController pushViewController:viewController animated:YES];
    }
    
    mainViewController.leftViewSwipeGestureEnabled = NO;

    [mainViewController hideLeftViewAnimated];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, section > 0 ? 1 : 0)];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, headerView.frame.size.width - 20, headerView.frame.size.height)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    [headerView addSubview:view];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0)
    {
        return 1;
    }
    else
    {
        return 0;
    }
}

@end
