//
//  BNChannelstreamApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNChannelstreamApi.h"

@implementation BNChannelstreamApi

/// URI
-(NSString *)requestURI{
    return APIRequestURLChannelstream(self.ID);
}

/// 网络请求方式默认GET
- (NNRequestType)requestType{
    return NNRequestTypeGet;
}
/// 网络请求参数
- (NSDictionary *)requestParams{
    return @{
             @"protocol": self.protocol,
             @"channel": @(self.channel),
             };
}
/// 网络请求参数验证
- (BOOL)validateParams{
    return true;
}

@end
