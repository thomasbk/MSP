//
//  ListItem.m
//  MSP
//
//  Created by Novacomp on 5/7/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "ListItem.h"

@interface ListItem ()

@property (strong, nonatomic) NSNumber *itemID;
@property (strong, nonatomic) NSString *imageURL;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *itemName;
@property (strong, nonatomic) NSString *itemDescription;

@end

@implementation ListItem

- (void)setItemID:(NSNumber *)itemID {
    _itemID = itemID;
}

- (NSNumber *)getItemID {
    return _itemID;
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
}

- (NSString *)getImageURL {
    return _imageURL;
}

- (void)setImage:(NSString *)image {
    _image = image;
}

- (NSString *)getImage {
    return _image;
}

- (void)setItem:(NSString *)itemName {
    _itemName = itemName;
}

- (NSString *)getItemName {
    return _itemName;
}

- (void)setItemDescription:(NSString *)itemDescription {
    _itemDescription = itemDescription;
}

- (NSString *)getItemDescription {
    return _itemDescription;
}

@end
