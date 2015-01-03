//
//  ZDWebService.h
//  Thumb
//
//  Created by peter on 14/11/10.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AllCustomerCategoryHeaders.h"

@interface ZDWebService : NSObject<NSXMLParserDelegate>

//登录
- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
               completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//注册 
- (void)registerWithValidateCode:(NSString *)validateCode
                          mobile:(NSString *)mobile
                        password:(NSString *)password
                      completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取验证码,oprType:操作类型(”0”:注册, ”1”:重置密码)
- (void)getValidateCodeWithMobile:(NSString *)mobile
                          oprType:(NSString *)oprType
                       completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//身份证绑定
- (void)idCardBindWithMobile:(NSString *)mobile
                        name:(NSString *)name
                  idCardBind:(NSString *)idCardBind
                  completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//忘记密码后重设密码
- (void)resetPasswordWithValidateCode:(NSString *)validateCode
                               mobile:(NSString *)mobile
                             password:(NSString *)password
                           completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取网点
- (void)getNetSiteWithNetSiteType:(NSString *)netSiteType
                          mapType:(NSString *)mapType
                           pageNo:(NSString *)pageNo
                         pageSize:(NSString *)pageSize
                        longitude:(NSString *)longitude
                         latitude:(NSString *)latitude
                       completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//修改密码
- (void)modifyPasswordWithMobile:(NSString *)mobile
                          oldpwd:(NSString *)oldpwd
                          newpwd:(NSString *)newpwd
                      completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

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
                            completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//线下理财申请
- (void)applyBusinessWithBusinessType:(NSString *)businessType
                               mobile:(NSString *)mobile
                                 city:(NSString *)city
                           completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//意见反馈
- (void)commitFeedbackWithUserName:(NSString *)userName
                           context:(NSString *)context
                          operDate:(NSString *)operDate
                           appType:(NSString *)appType
                        appVersion:(NSString *)appVersion
                            system:(NSString *)system
                     systemVersion:(NSString *)systemVersion
                            source:(NSString *)source
                      feedbackType:(NSString *)feedbackType
                        completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取理财产品列表
- (void)getProductListsWtihProType:(NSString *)proType
                        completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//查询单个理财产品信息
- (void)getProductDetailWithProId:(NSString *)proId
                       completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取客户经理信息
- (void)getManagerInfoWithManagerCode:(NSString *)managerCode
                           completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取某个客户订单列表
- (void)getProductOrderListsWithCustomerId:(NSString *)customerId
                                completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取某个产品订单详细信息
- (void)getProductOrderDetailWithBusiId:(NSString *)busiId
                             completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取交易明细列表
- (void)getTransactionDetailWithCustomerId:(NSString *)customerId
                                completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取债权列表
- (void)getLoanListWithInvestId:(NSString *)investId
                     completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//取消订单
-(void)deleteProductOrderWithBusiId:(NSString *)busiId
                         completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//更新客户信息
- (void)updateCustomerInfoWtihCustomerId:(NSString *)customerId
                                userName:(NSString *)userName
                                   idNum:(NSString *)idNum
                              completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取客户资产总值跟累计收益
- (void)updateCustomerTotalMoneyWithCustomerId:(NSString *)customerid
                                    completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取订单状态
- (void)getProductOrderStateWithCustomerId:(NSString *)customerid
                                 productId:(NSString *)productid
                                 payStatus:(NSString *)payStatus
                                completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

//获取订单剩余可购买金额
- (void)getProductRestMoneyWithActivityId:(NSString *)activityId
                               completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;

+(ZDWebService *)sharedWebService;
@end
