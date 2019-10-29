//
//  BNAPIConfi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNAPIConfi.h"
#import "UIApplication+Helper.h"

/// 正式接口
static NSString * const kAPIServiceUrl = @"http://114.116.1.186:10810";

@implementation BNAPIConfi

static NSString * _testUrl = nil;

+(NSArray *)serviceUrlList{
    return @[
             kAPIServiceUrl,
             @"测试接口二",
             @"测试接口三",
             ];
}

+(NSString *)serviceUrl{
    NSString * apiUrl = @"";
#ifdef DEBUG
    apiUrl = self.testUrl;
#else
    apiUrl = kAPIServiceUrl;//正式接口
#endif
    //    DDLog(@"APIServiceOfWeb_%@",apiUrl);
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

#pragma mark -set get

+ (NSString *)testUrl{
    if (!_testUrl) {
        _testUrl = self.serviceUrlList.firstObject;
    }
    return _testUrl;
}

+ (void)setTestUrl:(NSString *)testUrl{
    assert([BNAPIConfi.serviceUrlList containsObject:testUrl]);
    _testUrl = testUrl;
}

#pragma mak - -lazy




@end
