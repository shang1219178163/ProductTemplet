//
//  BNMoidyPwdApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNMoidyPwdApi.h"

@implementation BNMoidyPwdApi

/// URI
-(NSString *)requestURI{
    return kAPIRequestURLModifyPwd;
}

/// 网络请求方式默认GET
- (BNRequestType)requestType{
    return BNRequestTypeGet;
}
/// 网络请求参数
- (NSDictionary *)requestParams{
    return @{
              @"oldpassword": self.oldpassword.md5Encode,
              @"newpassword": self.newpassword.md5Encode,
             };
}
/// 网络请求参数验证
- (BOOL)validateParams{
    return true;
}

@end
