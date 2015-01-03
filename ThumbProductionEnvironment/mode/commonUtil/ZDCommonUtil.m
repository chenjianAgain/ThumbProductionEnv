//
//  ZDCommonUtil.m
//  Thumb
//
//  Created by ios on 14-11-20.
//  Copyright (c) 2014年 peter. All rights reserved.
//



/*
 statusString
 {
 0，代表成功
 1,代表网络异常
 2，代表网络正常，但数据抓取失败
 }
 */

#import "ZDCommonUtil.h"
//#import "ZDLoginViewController.h"

@interface ZDCommonUtil ()
@property (strong, nonatomic) ZDCustomer *currentZDCustomer;
@end

@implementation ZDCommonUtil

//正常登录,statusString{0，代表成功1,代表网络异常2，代表网络正常，但数据抓取失败}
 
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password completion:(void (^)(NSString *statusString))handler
{
    [[ZDWebService sharedWebService] loginWithUserName:userName password:password completion:^(NSError *error, NSDictionary *resultDic) {
        if (!error) {
            if ([resultDic[@"status"] isEqualToString:@"0"]) {
                
                [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"DefaultUserNameKey"];
                [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"DefaultUserPasswordKey"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                //成功抓取数据后，做保存操作
                [self customerFromInfoDictionary:resultDic];
                NSString *path = [ZDCustomer archivedPathForMobile:self.currentZDCustomer.mobile];
                [NSKeyedArchiver archiveRootObject:self.currentZDCustomer toFile:path];
               
                handler(@"0");
            } else {
                self.currentZDCustomer = nil;
                handler(@"2");
            }
        } else {
            self.currentZDCustomer = nil;
            handler(@"1");
        }
    }];
}

//快速登录
- (void)quickLoginWithUserName:(NSString *)userName password:(NSString *)password completion:(void (^)(NSError *error))handler
{
    NSString *path = [ZDCustomer archivedPathForMobile:userName];
    if (path.length) {
        self.currentZDCustomer = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    if (self.currentZDCustomer.customerId.length) {
        handler(nil);
    } else {
        [self loginOut];
        NSError *error = [[NSError alloc] init];
        handler(error);
    }
    
}

//退出账户
- (BOOL)loginOut
{
    self.currentZDCustomer = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"DefaultUserNameKey"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"DefaultUserPasswordKey"];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

//身份证绑定,statusString{0，代表成功1,代表网络异常 2.表示已绑定 3.绑定失败异常}
- (void)idCardBindWithMobile:(NSString *)mobile name:(NSString *)name idCardBind:(NSString *)idCardBind completion:(void (^)(NSString *))handler
{
    [[ZDWebService sharedWebService] idCardBindWithMobile:mobile name:name idCardBind:idCardBind completion:^(NSError *error, NSDictionary *resultDic) {
        if (!error) {
            if ([resultDic[@"status"] isEqualToString:@"0"]) {
                if ([resultDic[@"busiStatus"] isEqualToString:@"0"]) {
                    [self currentCustomerFromIdCardBinInfo:resultDic];
                    NSString *path = [ZDCustomer archivedPathForMobile:self.currentZDCustomer.mobile];
                    [NSKeyedArchiver archiveRootObject:self.currentZDCustomer toFile:path];
                    handler(@"0");
                } else if ([resultDic[@"busiStatus"] isEqualToString:@"1"]) {
                    handler(@"2");
                } else {
                    handler(@"3");
                }
            } else {
                handler(@"3");
            }
        } else {
            handler(@"1");
        }
    }];
}

- (void)currentCustomerFromIdCardBinInfo:(NSDictionary *)dictionary
{
    if (!self.currentZDCustomer) {
        self.currentZDCustomer = [[ZDCustomer alloc] init];
    }
    NSDictionary *dic = dictionary[@"infos"];
    self.currentZDCustomer.customerId = dic[@"customerId"];
    self.currentZDCustomer.customerNumber = dic[@"customerNumber"];
    self.currentZDCustomer.mrName = dic[@"name"];
    self.currentZDCustomer.idnum = dic[@"idnum"];
    self.currentZDCustomer.mrIdnum = dic[@"idnum"];
    self.currentZDCustomer.managerId = dic[@"customerManagerId"];
    self.currentZDCustomer.managerName = dic[@"customerManager"];
    self.currentZDCustomer.managerMobile = dic[@"managerMobile"];
    self.currentZDCustomer.managerCode = dic[@"managerCode"];
    self.currentZDCustomer.depName = dic[@"depName"];
}

- (void )customerFromInfoDictionary:(NSDictionary *)dic
{
    if (!self.currentZDCustomer) {
        self.currentZDCustomer = [[ZDCustomer alloc] init];
    }
    
    NSDictionary *infos = dic[@"infos"];
    self.currentZDCustomer.mobile = infos[@"mobile"];
    self.currentZDCustomer.mrIdnum = infos[@"mrIdnum"];
    self.currentZDCustomer.mrMemberState = infos[@"mrMemberState"];
    self.currentZDCustomer.mrName = infos[@"mrName"];
    
    NSDictionary *customer = infos[@"customer"];
    self.currentZDCustomer.idnum = customer[@"idnum"];
    self.currentZDCustomer.customerType = customer[@"customerType"];
    self.currentZDCustomer.managerCode = customer[@"managerCode"];
    self.currentZDCustomer.managerId = customer[@"managerId"];
    self.currentZDCustomer.customerId = customer[@"customerId"];
    self.currentZDCustomer.managerMobile = customer[@"managerMobile"];
    self.currentZDCustomer.customerNumber = customer[@"customerNumber"];
    self.currentZDCustomer.depName = customer[@"depName"];
    self.currentZDCustomer.managerName = customer[@"managerName"];
}

//获取理财产品列表
- (void)fetchProductListsWithCompletion:(void (^)(NSString *, NSArray *))handler
{
    [[ZDWebService sharedWebService] getProductListsWtihProType:@"3" completion:^(NSError *error, NSDictionary *resultDic) {
        if (!error) {
            if ([resultDic[@"status"] isEqualToString:@"0"]) {
                NSArray *productLists = [self productListsFromInfoDictionary:resultDic];
                handler(@"0",productLists);
            } else {
                //网络正常，但获取数据失败
                handler(@"2",nil);
            }
        } else {
            //网络异常
            handler(@"1",nil);
        }
    }];
}

- (NSMutableArray *)productListsFromInfoDictionary:(NSDictionary *)dictionary
{
    NSArray *arr = dictionary[@"financing"];
    if (!arr.count) {
        return nil;
    } else {
        NSMutableArray *productLists = [[NSMutableArray alloc] init];
        for(int i = 0;i < arr.count;i++) {
            NSDictionary *dic = arr[i];
            if ([dic[@"ptProductCode"] isEqualToString:@"zdcd"] || [dic[@"ptProductCode"] isEqualToString:@"zddt"] || [dic[@"ptProductCode"] isEqualToString:@"ywy"] || [dic[@"ptProductCode"] isEqualToString:@"zdesy"]) continue;
            
            ZDProduct *product = [[ZDProduct alloc] init];
            product.productName = dic[@"ptProductName"];
            product.ptMinAmount = [dic[@"ptMinAmount"] longValue];
            product.ptMinTerm = [dic[@"ptMinTerm"] longValue];
            product.ptMinYield = [dic[@"ptMinYield"] longValue];
            product.ptMaxYield = [dic[@"ptMaxYield"] longValue];
            product.ptProductType = dic[@"ptProductType"];
            product.productId = [dic[@"id"] intValue];
            product.ptMemo1 = dic[@"ptMemo1"];
            product.ptMemo2 = dic[@"ptMemo2"];
            product.ptBuyFlag = dic[@"ptBuyFlag"];
            [productLists addObject:product];
        }
        return productLists;
    }
}

//获取所有理财记录
- (void)fetchAllProductRecordsWithCompletion:(void (^)(NSString *, NSArray *))handler
{
    [[ZDWebService sharedWebService] getProductOrderListsWithCustomerId:self.currentCustomer.customerId completion:^(NSError *error, NSDictionary *resultDic) {
        if (!error) {
            if ([resultDic[@"status"] isEqualToString:@"0"]) {
                NSArray *infoArr = resultDic[@"infos"];
                NSArray *productRecords = [self productRecordsFromInfosArr:infoArr];
                NSLog(@"%d", 0);

                handler(@"0",productRecords);
            } else {
                handler(@"2",nil);
                NSLog(@"%d", 2);

            }
        } else {
            //网络异常
            handler(@"1",nil);
            NSLog(@"%d", 1);

        }
    }];
}

- (NSMutableArray *)productRecordsFromInfosArr:(NSArray *)infoArr
{
    if (!infoArr.count) {
        return nil;
    } else {
        NSMutableArray *productRecords = [[NSMutableArray alloc] init];
        for (int i = 0; i <infoArr.count; i++) {
            NSDictionary *dic = infoArr[i];
            ZDProductRecord *productRecord = [[ZDProductRecord alloc] init];
            productRecord.fePayStatus = dic[@"fePayStatus"];
            productRecord.managementFeeDiscount = dic[@"managementFeeDiscount"];
            productRecord.ptProductType = dic[@"ptProductType"];
            productRecord.billDate = dic[@"billDate"];
            productRecord.startDate = dic[@"startDate"];
            productRecord.loanValue = dic[@"loanValue"];
            productRecord.baAccount = dic[@"baAccount"];
            productRecord.busiId = dic[@"busiId"];
            productRecord.feAmount = dic[@"feAmount"];
            productRecord.feDataOrigin = dic[@"feDataOrigin"];
            productRecord.feContractNo = dic[@"feContractNo"];
            productRecord.feLendNo = dic[@"feLendNo"];
            productRecord.feRequestDate = dic[@"feRequestDate"];
            productRecord.investId = dic[@"investId"];
            productRecord.feReconciliationDate = dic[@"feReconciliationDate"];
            productRecord.endDate = dic[@"endDate"];
            productRecord.managementFeeRate = dic[@"managementFeeRate"];
            productRecord.ptProductName = dic[@"ptProductName"];
            productRecord.feState = dic[@"feState"];
            productRecord.feCrmState = dic[@"feCrmState"];
            productRecord.ptProductId = dic[@"ptProductId"];
            productRecord.ptMinTerm = dic[@"ptMinTerm"];
            [productRecords addObject:productRecord];
        }
        return productRecords;
    }
}

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
                             completion:(void (^)(NSString *, ZDProductOrder *))handler
{
    [[ZDWebService sharedWebService] submitProductOrderWithFeProduct:feProduct
                                                            feAmount:feAmount
                                                       feRequestDate:feRequestDate
                                                          customerid:customerid
                                                           managerId:managerId
                                                         managerCode:managerCode
                                                        feActivityId:feActivityId
                                                            bankName:bankName
                                                            bankCode:bankCode
                                                          bankCardNo:bankCardNo
                                                         bankSubName:bankSubName
                                                            userName:userName
                                                          completion:^(NSError *error, NSDictionary *resultDic) {
        if (!error) {
            if ([resultDic[@"status"] isEqualToString:@"0"]) {
                NSDictionary *infoDic = resultDic[@"infos"];
                ZDProductOrder *productOrder = [self productOrdersFromInfoArr:infoDic];
                
                NSDictionary *customerDic = infoDic[@"customer"];
                if ((NSNull *)customerDic != [NSNull null]) {
                    //使用managerCode提交，需绑定manager
                    self.currentZDCustomer.managerId = customerDic[@"managerId"];
                    self.currentZDCustomer.managerName = customerDic[@"managerName"];
                    self.currentZDCustomer.managerMobile = customerDic[@"managerMobile"];
                    self.currentZDCustomer.managerCode = customerDic[@"managerCode"];
                    self.currentZDCustomer.depName = customerDic[@"depName"];
                    NSString *path = [ZDCustomer archivedPathForMobile:self.currentZDCustomer.mobile];
                    [NSKeyedArchiver archiveRootObject:self.currentZDCustomer toFile:path];
                }
                handler(@"0",productOrder);
            } else {
                handler(@"2",nil);
            }
        } else {
            //网络异常
            handler(@"1",nil);
        }
    }];
}

- (ZDProductOrder *)productOrdersFromInfoArr:(NSDictionary *)infoDic
{
    ZDProductOrder *productOrder = [[ZDProductOrder alloc] init];
    productOrder.feReconciliationDate = infoDic[@"feReconciliationDate"];
    productOrder.fePayStatus = infoDic[@"fePayStatus"];
    productOrder.feLendNo = infoDic[@"feLendNo"];
    productOrder.feAppMemo = infoDic[@"feAppMemo"];
    productOrder.feContractNo = infoDic[@"feContractNo"];
    productOrder.feState = infoDic[@"feState"];
    productOrder.feId = infoDic[@"feId"];
    return productOrder;
}

//更新客户信息
- (void)updateCustomerInfoWtihCustomerId:(NSString *)customerId userName:(NSString *)userName idNum:(NSString *)idNum completion:(void (^)(NSString *))handler
{
    [[ZDWebService sharedWebService] updateCustomerInfoWtihCustomerId:customerId userName:userName idNum:idNum completion:^(NSError *error, NSDictionary *resultDic) {
        if (!error) {
            if ([resultDic[@"status"] isEqualToString:@"0"]) {
                
                if ([resultDic[@"busiStatus"] isEqualToString:@"0"]) {
                    self.currentZDCustomer.mrName = userName;
                    self.currentZDCustomer.idnum = idNum;
                    self.currentZDCustomer.mrIdnum = idNum;
                    
                    NSString *path = [ZDCustomer archivedPathForMobile:self.currentZDCustomer.mobile];
                    [NSKeyedArchiver archiveRootObject:self.currentZDCustomer toFile:path];
                    
                    handler(@"0");
                } else if ([resultDic[@"busiStatus"] isEqualToString:@"1"]) {
                    handler(@"3");//省份证已绑定
                } else if ([resultDic[@"busiStatus"] isEqualToString:@"2"]) {
                    handler(@"4");//已是正式客户，无法更新信息
                }
            } else if ([resultDic[@"status"] isEqualToString:@"-4"]) {
                handler(@"3");//省份证已绑定
            }
            else {
                handler(@"2");//数据获取失败
            }
        } else {
            //网络异常
            handler(@"1");
        }
    }];
}

- (ZDCustomer *)currentCustomer
{
    return self.currentZDCustomer;
}

+ (ZDCommonUtil *)sharedCommonUtil
{
    static dispatch_once_t once;
    static ZDCommonUtil *commonUtil;
    dispatch_once(&once, ^{
        commonUtil = [[self alloc] init];
    });
    return commonUtil;
}

//金额千分位显示
- (NSString *)amountFormat:(NSString *)amountText{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *amount = [formatter stringFromNumber:[NSNumber numberWithDouble:amountText.doubleValue]];
    NSInteger point = [amount rangeOfString:@"."].location;
    if (point == NSNotFound) {
        amount = [amount stringByAppendingString:@".00"];
    }
    if (point != NSNotFound) {
        NSString *afterPoint = [amount substringFromIndex:point];
        if (afterPoint.length == 2) {
            amount = [amount stringByAppendingString:@"0"];
        }
    }
    return amount;
}


#pragma mark - 处理投资状态

- (NSString *)statusStringFromProductRecord:(ZDProductRecord *)productRecord
{
//    if ([productRecord.ptProductType isEqualToString:@"2"]) {
        //线下
        if (productRecord.feState.length) {
            //先看fortune状态
            if ([productRecord.feState isEqualToString:@"02000002"] || [productRecord.feState isEqualToString:@"02000005"] || [productRecord.feState isEqualToString:@"02000006"] || [productRecord.feState isEqualToString:@"02000007"]) {
                return @"申请已受理";
            } else if ([productRecord.feState isEqualToString:@"02000008"] || [productRecord.feState isEqualToString:@"02000009"] || [productRecord.feState isEqualToString:@"02000010"] || [productRecord.feState isEqualToString:@"02000014"] || [productRecord.feState isEqualToString:@"02000013"]) {
                return @"投资生效";
            } else if ([productRecord.feState isEqualToString:@"02000011"] || [productRecord.feState isEqualToString:@"02000012"]) {
                return @"投资结束";
            } else return @"";
        } else {
            //若fortune无状态，看crm状态
            if ([productRecord.feCrmState isEqualToString:@"1"] || [productRecord.feCrmState isEqualToString:@"2"] || [productRecord.feCrmState isEqualToString:@"3"]) {
                return @"已申请";
            } else if ([productRecord.feCrmState isEqualToString:@"5"] || [productRecord.feCrmState isEqualToString:@"6"]) {
                return @"已失效";
            } else return @"";
        }
//    } else if ([productRecord.ptProductType isEqualToString:@"3"]) {
//        //线上
//        if ([productRecord.fePayStatus isEqualToString:@"1"]) {
//            //未付款
//            return @"等待付款";
//        } else if ([productRecord.fePayStatus isEqualToString:@"3"]){
//            //已付款
//            if ([productRecord.feState isEqualToString:@"02000008"] || [productRecord.feState isEqualToString:@"02000009"] || [productRecord.feState isEqualToString:@"02000010"] || [productRecord.feState isEqualToString:@"02000014"] || [productRecord.feState isEqualToString:@"02000013"]) {
//                return @"投资生效";
//            } else if ([productRecord.feState isEqualToString:@"02000011"] || [productRecord.feState isEqualToString:@"02000012"]) {
//                return @"投资结束";
//            } else if ([productRecord.feState isEqualToString:@"02000002"] || [productRecord.feState isEqualToString:@"02000005"] || [productRecord.feState isEqualToString:@"02000006"] || [productRecord.feState isEqualToString:@"02000007"]) {
//                return @"已付款";
//            } else return @"已付款";
//        } else return @"";
//        
//    } else return @"";
}


@end
