//
//  ZDWebService.m
//  Thumb
//
//  Created by peter on 14/11/10.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "ZDWebService.h"
#import "ZDNSURLSession.h"
#import "ZDWebService+URLString.h"
#import "ZDWebserviceDataParse.h"
#import "ZDCommonVariable.h"

@interface ZDWebService ()

@end

@implementation ZDWebService

//登陆
- (void)loginWithUserName:(NSString *)userName
                 password:(NSString *)password
               completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    password = [NSString md5:password];
    NSDictionary * oriDic = @{
                           @"userName": userName,
                           @"password": password
                           };
    NSString *urlString = [self URLStringForLogin];
    
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
    
}

//注册
- (void)registerWithValidateCode:(NSString *)validateCode
                          mobile:(NSString *)mobile
                        password:(NSString *)password
                      completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    password = [NSString md5:password];
    NSDictionary *oriDic = @{
                             @"validateCode":validateCode,
                             @"mobile":mobile,
                             @"password":password
                             };
    NSString *urlString = [self URLStringForRegister];
    
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取验证码,oprType:操作类型(”0”:注册, ”1”:重置密码)
- (void)getValidateCodeWithMobile:(NSString *)mobile
                          oprType:(NSString *)oprType
                       completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"mobile":mobile,
                             @"oprType":oprType
                             };
    NSString *urlString = [self URLStringForGetValidateCode];
    
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//身份证绑定
- (void)idCardBindWithMobile:(NSString *)mobile
                        name:(NSString *)name
                  idCardBind:(NSString *)idCardBind
                completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"mobile":mobile,
                             @"name":name,
                             @"idCardCode":idCardBind
                             };
    NSString *urlString = [self URLStringForIdCardBind];
    
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//忘记密码后重设密码
- (void)resetPasswordWithValidateCode:(NSString *)validateCode
                               mobile:(NSString *)mobile
                             password:(NSString *)password
                           completion:(void (^)(NSError *, NSDictionary *))handler
{
    password = [NSString md5:password];
    NSDictionary *oriDic = @{
                             @"validateCode":validateCode,
                             @"mobile":mobile,
                             @"password":password
                             };
    NSString *urlString = [self URLStringForForgetAndResetPassword];
    
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取网点
/*
    netSiteType:网点类型(“-1”所有网点，”0”理财网点，”1”贷款网点) 我们传0
    mapType:地图类型(“00”google，”01”baidu)
    pageNo:页码
    pageSize:每页显示数量
    longitude:当前经度
    latitude:当前纬度
 */
- (void)getNetSiteWithNetSiteType:(NSString *)netSiteType
                          mapType:(NSString *)mapType
                           pageNo:(NSString *)pageNo
                         pageSize:(NSString *)pageSize
                        longitude:(NSString *)longitude
                         latitude:(NSString *)latitude
                       completion:(void (^)(NSError *, NSDictionary *))handler
{
    NSDictionary *oriDic = @{
                             @"netSiteType":netSiteType,
                             @"mapType":mapType,
                             @"pageNo":pageNo,
                             @"pageSize":pageSize,
                             @"x":longitude,
                             @"y":latitude
                             };
    NSString *urlString = [self URLStringForGetNetSite];
    
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//修改密码
- (void)modifyPasswordWithMobile:(NSString *)mobile
                          oldpwd:(NSString *)oldpwd
                          newpwd:(NSString *)newpwd
                      completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    oldpwd = [NSString md5:oldpwd];
    newpwd = [NSString md5:newpwd];
    
    NSDictionary *oriDic = @{
                             @"mobile":mobile,
                             @"oldpwd":oldpwd,
                             @"newpwd":newpwd
                             };
    NSString *urlString = [self URLStringForUpdatePassword];
    
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//提交产品订单,feProduct:产品id，feAmount：订单金额，feRequestDate：订单创建时间，
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
                             completion:(void (^)(NSError *, NSDictionary *))handler
{
    NSDictionary *oriDic;
        if (managerId.length) {
            oriDic = @{
                       @"feProduct":feProduct,
                       @"feAmount":feAmount,
                       @"feRequestDate":feRequestDate,
                       @"customerId":customerid,
                       @"managerId":managerId,
                       @"feActivityId":feActivityId,
                       @"bankName":bankName,
                       @"bankCode":bankCode,
                       @"bankCardNo":bankCardNo,
                       @"bankSubName":bankSubName,
                       @"userName":userName

                       };
        } else {
            oriDic = @{
                       @"feProduct":feProduct,
                       @"feAmount":feAmount,
                       @"feRequestDate":feRequestDate,
                       @"customerId":customerid,
                       @"managerCode":managerCode,
                       @"feActivityId":feActivityId,
                       @"bankName":bankName,
                       @"bankCode":bankCode,
                       @"bankCardNo":bankCardNo,
                       @"bankSubName":bankSubName,
                       @"userName":userName
                       };
        }
    
    NSString *urlString = [self URLStringForSubmitProductOrder];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//线下理财申请  {"businessType":"证大年丰","city":"","mobile":"13873627712"}
- (void)applyBusinessWithBusinessType:(NSString *)businessType
                               mobile:(NSString *)mobile
                                 city:(NSString *)city
                           completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"businessType":businessType,
                             @"mobile":mobile,
                             @"city":city
                             };
    NSString *urlString = [self URLStringForApplyBusiness];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//意见反馈  username：有就传，没有传空，operDate：提交时间（yyyy-MM-ddHH:mm:ss），appType：iphoen or ipad，system：iOS or android，source：来源（1-crmApp、2-thumbsApp），feedbackType：意见类型（1-业务反馈、2-系统反馈）
- (void)commitFeedbackWithUserName:(NSString *)userName
                           context:(NSString *)context
                          operDate:(NSString *)operDate
                           appType:(NSString *)appType
                        appVersion:(NSString *)appVersion
                            system:(NSString *)system
                     systemVersion:(NSString *)systemVersion
                            source:(NSString *)source
                      feedbackType:(NSString *)feedbackType
                        completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"keyValue":userName,
                             @"context":context,
                             @"operDate":operDate,
                             @"appType":appType,
                             @"appVersion":appVersion,
                             @"system":system,
                             @"systemVersion":systemVersion,
                             @"source":source,
                             @"feedbackType":feedbackType
                             };
    NSString *urlString = [self URLStringForCommitFeedback];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取理财产品列表 proType:产品类别对应值 2 线下理财产品 3 线上理财产品,如需查询多种type，参数以“，”分隔符传输
- (void)getProductListsWtihProType:(NSString *)proType
                        completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"proType":proType
                             };
    NSString *urlString = [self URLStringForGetProductLists];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//查询单个理财产品信息   proId:产品id
- (void)getProductDetailWithProId:(NSString *)proId
                       completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"proId":proId
                             };
    NSString *urlString = [self URLStringForGetProductLists];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取客户经理信息 managerCode:客户经理邀请码
- (void)getManagerInfoWithManagerCode:(NSString *)managerCode
                           completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"managerCode":managerCode
                             };
    NSString *urlString = [self URLStringForGetManagerInfo];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取某个客户订单列表
- (void)getProductOrderListsWithCustomerId:(NSString *)customerId
                                completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"customerId":customerId
                             };
    NSString *urlString = [self URLStringForGetProductOrderListsOfCustomer];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取某个产品订单详细信息
- (void)getProductOrderDetailWithBusiId:(NSString *)busiId
                             completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"busiId":busiId
                             };
    NSString *urlString = [self URLStringForGetProductOrderListsOfCustomer];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取交易明细列表
- (void)getTransactionDetailWithCustomerId:(NSString *)customerId
                                completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"customerId":customerId
                             };
    NSString *urlString = [self URLStringForGetTransactoinDetailOfCustomer];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取债权列表    investId:投资编号
- (void)getLoanListWithInvestId:(NSString *)investId
                     completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"investId":investId
                             };
    NSString *urlString = [self URLStringForGetLoanList];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//删除产品订单
- (void)deleteProductOrderWithBusiId:(NSString *)busiId completion:(void (^)(NSError *, NSDictionary *))handler
{
    NSDictionary *oriDic = @{
                             @"Id":busiId
                             };
    NSString *urlString = [self URLStringForDeleteProductOrder];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//更新客户信息
- (void)updateCustomerInfoWtihCustomerId:(NSString *)customerId userName:(NSString *)userName idNum:(NSString *)idNum completion:(void (^)(NSError *, NSDictionary *))handler
{
    NSDictionary *oriDic = @{
                             @"customerId":customerId,
                             @"name":userName,
                             @"idnum":idNum
                             };
    NSString *urlString = [self URLStringForUpdateCustomerInfo];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取客户资产总值跟累计收益
- (void)updateCustomerTotalMoneyWithCustomerId:(NSString *)customerid
                                    completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"customerId":customerid,
                             };
    NSString *urlString = [self URLStringForUpdateCustomerTotalMoney];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取订单状态
- (void)getProductOrderStateWithCustomerId:(NSString *)customerid
                                 productId:(NSString *)productid
                                 payStatus:(NSString *)payStatus
                                completion:(void(^)(NSError *, NSDictionary *))handler
{
    NSDictionary *oriDic = @{
                             @"customerId":customerid,
                             @"productId":productid,
                             @"payStatus":payStatus
                             };
    NSString *urlString = [self URLStringForGetProductOrderState];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

//获取订单剩余可购买金额 1.a计划  2.b计划
- (void)getProductRestMoneyWithActivityId:(NSString *)activityId
                               completion:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSDictionary *oriDic = @{
                             @"activityId":activityId,
                             };
    NSString *urlString = [self URLStringForGetProductRestMoney];
    [self fetchByWebserviceURLString:urlString dictionary:oriDic handler:handler];
}

#pragma mark - 共用请求方法

// webservice的接口请求设置
- (void)fetchByWebserviceURLString:(NSString *)urlString dictionary:(NSDictionary *)dic handler:(void(^)(NSError *error,NSDictionary *resultDic))handler
{
    NSString *projectNo = DefaultProjectNo;
    NSString *reqUrl = urlString;
    NSString *reqParam = [self translateToJsonStringWithDictionaryUnnormal:dic];
    NSString *reqParam2 = [self translateToJsonStringWithDictionaryNormal:dic];//用于生成校验码
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *userAgent = [NSString stringWithFormat:@"%@ %@(iPhone;iOS %@;zh_CN)",appName,appVersion,[[UIDevice currentDevice] systemVersion]];
    NSDictionary *httpHeadDic = @{
                                  @"token":@"",
                                  @"User-Agent":userAgent,
                                  @"netmac":@"",
                                  @"version":[self currentAppVersion]
                                  };
    NSString *reqHeadParm = [self translateToJsonStringWithDictionaryUnnormal:httpHeadDic];
    
    long long time = (long long)([[NSDate date] timeIntervalSince1970] * 1000);
    NSString * reqTimestamp = [NSString stringWithFormat:@"%lld",time];
    
    NSString * dateString = [[NSString stringTranslatedFromDate:[NSDate date]] stringByReplacingOccurrencesOfString:@" " withString:@""];
    dateString = [dateString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    dateString = [dateString stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *randomString = [self getRandomStringWithCount:5];
    NSString * sn = [NSString stringWithFormat:@"%@-%@-%@",DefaultProjectNo,dateString,randomString];
    
    NSString * signOri = [NSString stringWithFormat:@"%@%@%@%@%@%@",projectNo,reqUrl,reqParam2,reqTimestamp,sn,secret];
    NSString * sign = [NSString md5StringFromString:signOri];
    
    NSDictionary *paramDic = @{@"projectNo":projectNo,
                           @"reqUrl":reqUrl,
                           @"reqParam":reqParam,
                           @"reqHeadParm":reqHeadParm,
                           @"reqTimestamp":reqTimestamp,
                           @"sn":sn,
                           @"sign":sign
                           };
    NSString * dataString = [self translateToJsonStringWithDictionaryNormal:paramDic];
    
    NSString *soapMsg = [NSString stringWithFormat:
                         @"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:web=\"http://websvc/\">"
                         "<soapenv:Header/>"
                         "<soapenv:Body>"
                         "<web:dispatchCommand>"
                         "<!--Optional:-->"
                         "<web:arg0>%@</web:arg0>"
                         "<!--Optional:-->"
                         "<web:arg1>%@</web:arg1>"
                         "</web:dispatchCommand>"
                         "</soapenv:Body>"
                         "</soapenv:Envelope>",DefaultCRMPublishService,dataString];
    
    NSURL *url = [NSURL URLWithString: TranslateWebURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
//    ZDNSURLSession *session = [[ZDNSURLSession alloc] initWithRequest:req completionHandler:handler];
//    [session startSession];
//    NSURLSession *session = [NSURLSession sharedSession];
    /*
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            handler(error,nil);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                ZDWebserviceDataParse *dataParse = [[ZDWebserviceDataParse alloc] initWithParseString:resultString completion:handler];
                [dataParse startParse];
            } else {
                NSError *error = [[NSError alloc] init];
                handler(error,nil);
            }
        }
    }] resume];
     */
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            handler(connectionError,nil);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                NSString *resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                ZDWebserviceDataParse *dataParse = [[ZDWebserviceDataParse alloc] initWithParseString:resultString completion:handler];
                [dataParse startParse];
            } else {
                NSError *error = [[NSError alloc] init];
                handler(error,nil);
            }
        }

    }];
    
}

- (NSString *)getRandomStringWithCount:(int)count
{
    NSString *string = [[NSString alloc] init];
    for (int i = 0; i < count; i ++) {
        int a = arc4random() % 10;
       string = [string stringByAppendingString:[NSString stringWithFormat:@"%d",a]];
    }
    return string;
}

#pragma mark - translateToJsonString

- (NSString *)translateToJsonStringWithDictionaryUnnormal:(NSDictionary *)dic
{
    NSArray *keys = [dic allKeys];
    NSArray *values = [dic allValues];
    NSString *jsonString = @"{";
    for (int i = 0; i < keys.count; i ++) {
        if (i != (keys.count - 1)) {
            jsonString = [jsonString stringByAppendingString:[NSString stringWithFormat:@"\\\"%@\\\":\\\"%@\\\",",keys[i],values[i]]];
        } else {
            jsonString = [jsonString stringByAppendingString:[NSString stringWithFormat:@"\\\"%@\\\":\\\"%@\\\"",keys[i],values[i]]];
        }
    }
    jsonString = [jsonString stringByAppendingString:@"}"];
    return jsonString;
}

- (NSString *)translateToJsonStringWithDictionaryNormal:(NSDictionary *)dic
{
    NSArray *keys = [dic allKeys];
    NSArray *values = [dic allValues];
    NSString *jsonString = @"{";
    for (int i = 0; i < keys.count; i ++) {
        if (i != (keys.count - 1)) {
            jsonString = [jsonString stringByAppendingString:[NSString stringWithFormat:@"\"%@\":\"%@\",",keys[i],values[i]]];
        } else {
            jsonString = [jsonString stringByAppendingString:[NSString stringWithFormat:@"\"%@\":\"%@\"",keys[i],values[i]]];
        }
    }
    jsonString = [jsonString stringByAppendingString:@"}"];
    return jsonString;
}

#pragma mark - about version

- (NSString *)currentAppVersion
{
    NSDictionary * info = [[NSBundle mainBundle] infoDictionary];
    return info[@"CFBundleShortVersionString"];
}

#pragma mark - sharedWebService

+ (ZDWebService *)sharedWebService
{
    static dispatch_once_t once;
    static ZDWebService *sharedWebService;
    dispatch_once(&once, ^{
        sharedWebService = [[self alloc] init];
    });
    return sharedWebService;
}

@end
