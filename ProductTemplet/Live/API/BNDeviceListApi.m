//
//  BNDeviceListApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNDeviceListApi.h"

@implementation BNDeviceListApi

/// URI
-(NSString *)requestURI{
    return kAPIRequestURLDeviceList;
}

/// 网络请求方式默认GET
- (BNRequestType)requestType{
    return BNRequestTypeGet;
}
/// 网络请求参数
- (NSDictionary *)requestParams{
    return @{
             @"limit": @(self.limit),
             @"online": @(self.online),
             };
}
/// 网络请求参数验证
- (BOOL)validateParams{
    return true;
}

@end
