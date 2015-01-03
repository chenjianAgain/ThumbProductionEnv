//
//  ZDWebserviceDataParse.h
//  Thumb
//
//  Created by peter on 14/11/11.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDWebserviceDataParse : NSObject

- (id)initWithParseString:(NSString *)parseString
               completion:(void(^)(NSError *error,NSDictionary *resultDic))handler;
- (void)startParse;
@end
