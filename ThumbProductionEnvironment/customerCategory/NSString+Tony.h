//
//  NSString+Tony.h
//  WX189study
//
//  Created by Tony zhou on 13-5-10.
//  Copyright (c) 2013年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zlib.h"

@interface NSString (Tony) <NSXMLParserDelegate> 

+ (NSString *)md5StringFromString:(NSString *)s;
+ (NSString *)md5:(NSString *)value;
+ (NSString *)stringOfAddPercentEscapesWithString:(NSString *)s;

+ (NSString *)base64StringFromData:(NSData *)data;
//+ (NSData *) base64DataFromString:(NSString *)string;


+ (NSString *)timeStringForTime:(NSUInteger)time;//整形时间转化为00:00字符串
+ (NSString *)stringTranslatedFromDate:(NSDate *)date;//NSDate转化为标准格式时间字符串
+(NSDate *) convertDateFromString:(NSString*)uiDate;//nsstring转化为nsdate

+(NSString *)formatStringToSaveWithString:(NSString *)string digit:(NSInteger)digit decimalStyle:(BOOL)flag;//将一个数字字符串保留指定的位数,string为字符串，digit为保留的位数
+(NSString *)formatStringForPercentageWithString:(NSString *)string;//将一个数字字符串转换为百分号显示,保留2位

//得到两位随机数
+ (NSString *)twoCharRandom;

//月转换成天
+ (NSString *)monthToDay:(NSString *)dayString;
@end
