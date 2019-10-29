//
//  BNRestartApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNRestartApi.h"

@implementation BNRestartApi
/// URI
-(NSString *)requestURI{
    return kAPIRequestURLRestart;
}

/// 网络请求方式默认GET
- (NNRequestType)requestType{
    return NNRequestTypeGet;
}
/// 网络请求参数
- (NSDictionary *)requestParams{
    return @{
             //             @"oldpassword": self.oldpassword,
             //             @"newpassword": self.newpassword,
             };
}
/// 网络请求参数验证
- (BOOL)validateParams{
    return true;
}

@end
