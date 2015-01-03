//
//  ZDNSURLSession.h
//  BackgroundDemo
//
//  Created by peter on 14/10/28.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZDNSURLSession : NSObject
{
    NSMutableData * receiveData;
}

- (id)initWithRequest:(NSURLRequest *)request
                  completionHandler:(void(^)(NSError *error, NSDictionary *resultDic))handler;
- (void)startSession;

@end
