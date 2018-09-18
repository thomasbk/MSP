//
//  ListItem.h
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListItem : NSObject

- (void)setItemID:(NSNumber *)itemID;
- (NSNumber *)getItemID;
- (void)setImageURL:(NSString *)imageURL;
- (NSString *)getImageURL;
- (void)setImage:(NSString *)image;
- (NSString *)getImage;
- (void)setItem:(NSString *)itemName;
- (NSString *)getItemName;
- (void)setItemDescription:(NSString *)itemDescription;
- (NSString *)getItemDescription;

@end
