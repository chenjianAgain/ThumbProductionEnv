//
//  ZDPathUtil.m
//  Thumb
//
//  Created by peter on 14/11/15.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "ZDPathUtil.h"

@implementation ZDPathUtil

+ (NSString *)pathForUserGesturepassword
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"gesture.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
}

+ (NSString *)pathForCustomerWithMobile:(NSString *)mobile
{
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"customer_%@.archive",mobile]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    return path;
}

@end
