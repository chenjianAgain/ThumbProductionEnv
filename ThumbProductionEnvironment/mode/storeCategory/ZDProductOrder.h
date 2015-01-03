//
//  ZDProductOrder.h
//  Thumb
//
//  Created by ios on 14-11-21.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>
//购买理财产品时的类
@interface ZDProductOrder : NSObject

@property (strong, nonatomic) NSString *feContractNo;//合同编号
@property (strong, nonatomic) NSString *feState;//审核状态
@property (strong, nonatomic) NSString *feLendNo;//出借编号
@property (strong, nonatomic) NSString *fePayStatus;//订单状态
@property (strong, nonatomic) NSString *feReconciliationDate;//对账日期
@property (strong, nonatomic) NSString *feAppMemo;//备注信息
@property (strong, nonatomic) NSString* feId;

@end
