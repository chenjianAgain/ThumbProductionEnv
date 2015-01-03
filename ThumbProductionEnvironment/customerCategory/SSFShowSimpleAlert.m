//
//  SSFShowSimpleAlert.m
//  Thumb
//
//  Created by peter on 14/11/13.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "SSFShowSimpleAlert.h"

@implementation SSFShowSimpleAlert

+ (void)showSimpleAlertWithTitle:(NSString *)title
                         message:(NSString *)message
{
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
}

@end
