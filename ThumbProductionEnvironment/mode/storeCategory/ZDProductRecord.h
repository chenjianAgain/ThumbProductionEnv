//
//  ZDProductRecord.h
//  Thumb
//
//  Created by ios on 14-11-25.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDProductRecord : NSObject

@property (strong, nonatomic) NSString *ptProductName;//产品名称
@property (strong, nonatomic) NSString *busiId;//订单ID
@property (strong, nonatomic) NSString *feContractNo;//合同编号
@property (strong, nonatomic) NSString *feLendNo;//出借编号
@property (strong, nonatomic) NSString *feAmount;//订单金额
@property (strong, nonatomic) NSString *feRequestDate;//订单创建时间
@property (strong, nonatomic) NSString *startDate;//出借日期
@property (strong, nonatomic) NSString *endDate;//到期日期
@property (strong, nonatomic) NSString *billDate;//账单日
@property (strong, nonatomic) NSString *loanValue;//债权价值
@property (strong, nonatomic) NSString *managementFeeDiscount;//管理费折扣
@property (strong, nonatomic) NSString *managementFeeRate;//管理费率
@property (strong, nonatomic) NSString *feState;//审核状态
@property (strong, nonatomic) NSString *fePayStatus;//付款状态
@property (strong, nonatomic) NSString *feReconciliationDate;//对账日期
@property (strong, nonatomic) NSString *baAccount;//银行卡号码
@property (strong, nonatomic) NSString *ptProductType;//产品类型2线下产品 3 线上产品
@property (strong, nonatomic) NSString *feDataOrigin;//订单来源  0.线下订单 1.线上订单
@property (strong, nonatomic) NSString *investId;//投资编号
@property (strong, nonatomic) NSString *feCrmState;//crm系统状态
@property (strong, nonatomic) NSString *ptProductId;//产品id
@property (strong, nonatomic) NSString *ptMinTerm;//订单产品封闭期

@end
