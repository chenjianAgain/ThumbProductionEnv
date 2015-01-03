//
//  ZDNetSite.h
//  Thumb
//
//  Created by ios on 14-11-19.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDNetSite : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *netSiteType;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *tel;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *distance;

@end
