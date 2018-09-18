//
//  InformationViewController.h
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "BaseViewController.h"
#import "ListItem.h"

@interface InformationViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *lblInformation;

@property (weak, nonatomic) ListItem *item;

- (void) setDescription:(NSString*)desc;
- (void) setItemAndGetInfo:(ListItem*)item;
- (void) setItemAndGetRequest:(ListItem*)item;

@end
