//
//  ZDProduct.h
//  Thumb
//
//  Created by ios on 14-11-24.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDProduct : NSObject
@property (strong, nonatomic) NSString *productName;
@property (nonatomic) long ptMinAmount;//起投金额
@property (nonatomic) long ptMinTerm;//封闭期，最小期数，月为单位
@property (nonatomic) long ptMinYield;//预计年华收益下限
@property (nonatomic) long ptMaxYield;//预计年华收益上限
@property (strong,nonatomic) NSString *ptProductType;//产品类型2线下产品 3 线上产品
@property (nonatomic) int productId;
@property (strong, nonatomic) NSString *ptMemo1;//备注：目标客户
@property (strong, nonatomic) NSString *ptMemo2;//备注：收益说明
@property (strong, nonatomic) NSString *ptBuyFlag;//1.可购买 2.不可购买

@end
