

//
//  BNUserLogoutApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNUserLogoutApi.h"

@implementation BNUserLogoutApi
/// URI
-(NSString *)requestURI{
    return kAPIRequestURLLogout;
}

/// 网络请求方式默认GET
- (BNRequestType)requestType{
    return BNRequestTypeGet;
}
/// 网络请求参数
- (NSDictionary *)requestParams{
    return @{
//             @"username": self.name,
//             @"password": self.password,
             };
}
/// 网络请求参数验证
- (BOOL)validateParams{
    return true;
}

@end
