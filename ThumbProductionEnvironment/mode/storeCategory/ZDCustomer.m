//
//  ZDCustomer.m
//  Thumb
//
//  Created by ios on 14-11-20.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "ZDCustomer.h"
#import "ZDPathUtil.h"

@implementation ZDCustomer

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.idnum = [aDecoder decodeObjectForKey:@"idnum"];
        self.customerType = [aDecoder decodeObjectForKey:@"customerType"];
        self.managerCode = [aDecoder decodeObjectForKey:@"managerCode"];
        self.managerId = [aDecoder decodeObjectForKey:@"managerId"];
        self.customerId = [aDecoder decodeObjectForKey:@"customerId"];
        self.managerMobile = [aDecoder decodeObjectForKey:@"managerMobile"];
        self.customerNumber = [aDecoder decodeObjectForKey:@"customerNumber"];
        self.depName = [aDecoder decodeObjectForKey:@"depName"];
        self.managerName = [aDecoder decodeObjectForKey:@"managerName"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.mrIdnum = [aDecoder decodeObjectForKey:@"mrIdnum"];
        self.mrName = [aDecoder decodeObjectForKey:@"mrName"];
        self.mrMemberState = [aDecoder decodeObjectForKey:@"mrMemberState"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.idnum forKey:@"idnum"];
    [aCoder encodeObject:self.customerType forKey:@"customerType"];
    [aCoder encodeObject:self.managerCode forKey:@"managerCode"];
    [aCoder encodeObject:self.managerId forKey:@"managerId"];
    [aCoder encodeObject:self.customerId forKey:@"customerId"];
    [aCoder encodeObject:self.managerMobile forKey:@"managerMobile"];
    [aCoder encodeObject:self.customerNumber forKey:@"customerNumber"];
    [aCoder encodeObject:self.depName forKey:@"depName"];
    [aCoder encodeObject:self.managerName forKey:@"managerName"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.mrIdnum forKey:@"mrIdnum"];
    [aCoder encodeObject:self.mrName forKey:@"mrName"];
    [aCoder encodeObject:self.mrMemberState forKey:@"mrMemberState"];
}

+ (NSString *)archivedPathForMobile:(NSString *)mobile
{
    return [ZDPathUtil pathForCustomerWithMobile:mobile];
}

@end
