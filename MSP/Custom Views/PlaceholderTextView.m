//
//  PlaceholderTextView.m
//  MSP
//
//  Created by Novacomp on 5/8/18.
//  Copyright © 2018 Novacomp. All rights reserved.
//

#import "PlaceholderTextView.h"

@interface PlaceholderTextView ()

@property (strong, nonatomic) NSString *placeholder;

@end

@implementation PlaceholderTextView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setDelegate:self];
    
    _placeholder = self.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:_placeholder])
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@""])
    {
        textView.text = _placeholder;
        textView.textColor = [UIColor lightGrayColor];
    }
    
    [textView resignFirstResponder];
}


@end
