//
//  ZDCustomer.h
//  Thumb
//
//  Created by ios on 14-11-20.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDCustomer : NSObject<NSCoding>

@property (strong, nonatomic) NSString *idnum;//客户身份证
@property (strong, nonatomic) NSString *customerType;//客户类型：1储备客户 未做业务2. 客户  新客户，有一笔正在做的业务3. 老客户 有一笔及以上投资结束的业务4. 合作伙伴5. 竞争对手6. 黑名单
@property (strong, nonatomic) NSString *managerCode;//客户经理邀请码
@property (strong, nonatomic) NSString *managerId;
@property (strong, nonatomic) NSString *customerId;
@property (strong, nonatomic) NSString *managerMobile;
@property (strong, nonatomic) NSString *customerNumber;//客户编号
@property (strong, nonatomic) NSString *depName;//客户经理部门名称
@property (strong, nonatomic) NSString *managerName;//客户经理名称
@property (strong, nonatomic) NSString *mobile;//用户手机，也是用户账户名
@property (strong, nonatomic) NSString *mrIdnum;//客户身份证号
@property (strong, nonatomic) NSString *mrName;//用户名字
@property (strong, nonatomic) NSString *mrMemberState;//是否绑定理财账户的状态,2是已绑定

+ (NSString *)archivedPathForMobile:(NSString *)mobile;
@end
