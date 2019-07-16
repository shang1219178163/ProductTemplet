//
//  BNUserLoginApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNUserLoginApi.h"

@implementation BNUserLoginApi

/// URI
-(NSString *)requestURI{
    return kAPIRequestURLLogin;
}

/// 网络请求方式默认GET
- (BNRequestType)requestType{
    return BNRequestTypeGet;
}
/// 网络请求参数
- (NSDictionary *)requestParams{
    return @{
              @"username": self.name,
              @"password": self.password.md5Encode,
             };
}
/// 网络请求参数验证
- (BOOL)validateParams{
    return true;
}

@end
