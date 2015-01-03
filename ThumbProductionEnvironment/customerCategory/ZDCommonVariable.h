//
//  ZDCommonVariable.h
//  Thumb
//
//  Created by ios on 14-12-8.
//  Copyright (c) 2014年 peter. All rights reserved.
//

#ifndef Thumb_ZDCommonVariable_h
#define Thumb_ZDCommonVariable_h

//支付（正式）
//#define URLPrama  @"http://cashier.ezendai.com:8082/zdpay_cashier/cashier/toPay"
//#define PayPrivateKey  @"3739343939333836"//支付私钥
//#define MerchantCode   @"820141205062"//商户号
//#define CheckoutVersion @"1.0";//收银台版本号

//支付(测试)
#define URLPrama  @"http://test-cashier.ezendai.com:8188/zdpay_cashier/cashier/toPay"
#define PayPrivateKey  @"KWOJT23434LT3JT"//支付私钥
#define MerchantCode   @"820141114001"//商户号
#define CheckoutVersion @"1.0";//收银台版本号

//网关
#define TranslateWebURL @"http://180.166.169.132:8089/message_webservice/services/DealProcessor?wsdl=DealProcessorService.wsdl"//公网测试,许峰转发

//#define TranslateWebURL @"http://message.ezendai.com:8877/message_webservice/services/DealProcessor?wsdl=DealProcessorService.wsdl"//公网正式
#define DefaultCRMPublishService  @"300001"//crm公共接口转发
#define DefaultProjectNo    @"D"//大拇指项目
#define secret @"bb369ff752074e2ba055f32da6bc3114"//公网测试
//#define secret @"efa59fc4876e4272979cc39b128866f7"//公网正式

#endif
