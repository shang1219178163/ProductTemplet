//
//  BNAPIConfiguration.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNAPIConfiguration.h"
#import "UIApplication+Helper.h"

//#define APIServiceUrl_debug @"http://116.62.132.145"
#define kAPIServiceUrl @"http://iop.parkingwang.com:9397"

@implementation BNAPIConfiguration

static NSArray * _urlTestList = nil;
static NSString * _urlTest = nil;

/**
 web服务器请求地址
 */
+ (NSString *)serviceURLString{
    NSString * apiUrl = @"";
#if defined DEBUG
    apiUrl = BNAPIConfiguration.urlTest;
#else
    apiUrl = kAPIServiceUrl;//正式接口
#endif
    //    apiUrl = APIServiceOfWeb;//test
    DDLog(@"APIServiceOfWeb_%@",apiUrl);
    return apiUrl;
}

/**
 API请求头中的UserAgent
 */
+ (NSString *)headerUserAgent{
    NSString *systemVersion = UIApplication.phoneSystemVer;
    NSString *iphoneType = UIApplication.phoneType;
    return [NSString stringWithFormat:@"IOP/iOS%@/%@",systemVersion,iphoneType];
}

/**
 API请求头中的请求Version
 */
+ (NSString *)headerAcceptVersion{
    return @"1.3";
}

+ (NSInteger)timeOut{
    return 10;
}

#pragma mak - -lazy
+ (NSArray *)urlTestList{
    if (!_urlTestList) {
        _urlTestList = @[
                         @"测试接口一",
                         @"测试接口二",
                         @"测试接口三",
                         ];
    }
    return _urlTestList;
}

+ (void)setUrlTest:(NSString *)urlTest{
    assert([BNAPIConfiguration.urlTestList containsObject:urlTest]);
    _urlTest = urlTest;
}

+ (NSString *)urlTest{
    if (!_urlTest) {
        _urlTest = BNAPIConfiguration.urlTestList.firstObject;
    }
    return _urlTest;
}


@end
