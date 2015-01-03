//
//  ZDCommonUtil.h
//  Thumb
//
//  Created by ios on 14-11-20.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZDWebService.h"
#import "ZDCustomer.h"
#import "ZDProduct.h"
#import "ZDProductRecord.h"
#import "ZDProductOrder.h"

@interface ZDCommonUtil : NSObject

//正常登录
- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
               completion:(void(^)(NSString *statusString))handler;

//快速登录（彻底关掉app后，启动依然可以进入账户）
- (void)quickLoginWithUserName:(NSString *)userName
                      password:(NSString *)password
                    completion:(void(^)(NSError *error))handler;
//退出账户
- (BOOL)loginOut;

//身份证绑定
- (void)idCardBindWithMobile:(NSString *)mobile
                        name:(NSString *)name
                  idCardBind:(NSString *)idCardBind
                  completion:(void(^)(NSString *statusString))handler;

//获取理财产品列表
- (void)fetchProductListsWithCompletion:(void(^)(NSString *statusString, NSArray *productLists))handler;

//获取所有理财记录
- (void)fetchAllProductRecordsWithCompletion:(void(^)(NSString *statusString, NSArray *productRecords))handler;

//提交产品订单
- (void)submitProductOrderWithFeProduct:(NSString *)feProduct
                               feAmount:(NSString *)feAmount
                          feRequestDate:(NSString *)feRequestDate
                             customerid:(NSString *)customerid
                              managerId:(NSString *)managerId
                            managerCode:(NSString *)managerCode
                             feActivityId:(NSString *)feActivityId
                               bankName:(NSString *)bankName
                               bankCode:(NSString *)bankCode
                             bankCardNo:(NSString *)bankCardNo
                            bankSubName:(NSString *)bankSubName
                               userName:(NSString *)userName
                             completion:(void(^)(NSString *statusString, ZDProductOrder *productOrder))handler;

//更新customer信息
- (void)updateCustomerInfoWtihCustomerId:(NSString *)customerId
                                userName:(NSString *)userName
                                   idNum:(NSString *)idNum
                              completion:(void(^)(NSString *statusString))handler;

- (ZDCustomer *)currentCustomer;//当前登录的用户

+ (ZDCommonUtil *)sharedCommonUtil;

//金额千分位显示
- (NSString *)amountFormat:(NSString *)amountText;

//处理投资状态
- (NSString *)statusStringFromProductRecord:(ZDProductRecord *)productRecord;


@end
