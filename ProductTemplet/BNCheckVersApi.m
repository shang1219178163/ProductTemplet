//
//  BNCheckVersApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNCheckVersApi.h"

@implementation BNCheckVersApi

- (NSString *)requestURI{
    return @"http://itunes.apple.com/cn/lookup?";
}

-(BNRequestType)requestType{
    return BNRequestTypeGet;
}

-(NSDictionary *)requestParams{
    return @{
             @"id": kAppStoreID,
             };
}

- (BOOL)saveJsonOfCache:(NSDictionary *)json{
    if (!json) {
        return false;
    }
    [BNCacheManager.shared setObject:json forKey:kCacheAppInfo];
    return true;
}

- (NSDictionary *)jsonFromCache{
    NSDictionary *dic = [BNCacheManager.shared objectForKey:kCacheAppInfo];
    return dic;
}

@end
