//
//  ZDWebserviceDataParse.m
//  Thumb
//
//  Created by peter on 14/11/11.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#import "ZDWebserviceDataParse.h"

@interface ZDWebserviceDataParse () <NSXMLParserDelegate>

@property (strong, nonatomic) NSString *parseString;
@property (strong, nonatomic) void(^completionHandler)(NSError *error, NSDictionary *resultDic);
@property (strong, nonatomic) NSString *xmlString;

@end

@implementation ZDWebserviceDataParse

- (id)initWithParseString:(NSString *)parseString
               completion:(void (^)(NSError *, NSDictionary *))handler
{
    self = [super init];
    if (self) {
        self.parseString = parseString;
        self.completionHandler = handler;
    }
    return self;
}

- (void)startParse
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[self.parseString dataUsingEncoding:NSUTF8StringEncoding]];
    parser.delegate = self;
    [parser parse];
}

#pragma mark - xmlParser

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.xmlString = [[NSString alloc] init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    self.xmlString = [self.xmlString stringByAppendingString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"return"]) {
        NSError *error = nil;
        NSData *receiveData = [self.xmlString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:receiveData options:NSJSONReadingMutableContainers error:&error];
        
        if ([responseDic[@"code"] isEqualToString:@"0000"]) {
            NSString *realResultString = responseDic[@"msg"];
            NSDictionary *realResultDic = [NSJSONSerialization JSONObjectWithData:[realResultString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
            if ([realResultDic[@"status"] isEqualToString:@"0"]) {
                self.completionHandler(nil,realResultDic);
            } else {
                self.completionHandler(nil,realResultDic);
            }
        } else if([responseDic[@"code"] isEqualToString:@"0101"]) {
            NSLog(@"系统JSON转换异常");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"0102"]) {
            NSLog(@"系统异常,请联系管理员");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"0103"]) {
            NSLog(@"请求参数不能为空");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"0104"]) {
            NSLog(@"请求参数长度超过最大允许长度");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"0105"]) {
            NSLog(@"日期格式不正确");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"0106"]) {
            NSLog(@"参数类型不正确");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"0107"]) {
            NSLog(@"校验码验证失败");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"0108"]) {
            NSLog(@"URL请求过期");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"0109"]) {
            NSLog(@"流水号已存在");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"1102"]) {
            NSLog(@"本次请求超时");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"1103"]) {
            NSLog(@"无法通过项目编号找到密钥");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"1104"]) {
            NSLog(@"新增设备失败,用户设备已存在");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"1105"]) {
            NSLog(@"注销设备失败,用户不存在");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"1106"]) {
            NSLog(@"注销设备失败,设备不存在");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"1107"]) {
            NSLog(@"项目编号不能为空");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else if([responseDic[@"code"] isEqualToString:@"1108"]) {
            NSLog(@"项目私有密钥没配置");
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        } else {
            NSError *error = [[NSError alloc] init];
            self.completionHandler(error,nil);
        }
    }
}

@end
