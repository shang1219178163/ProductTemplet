//
//   NNCheckVersApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNCheckVersApi.h"

@implementation  NNCheckVersApi

- (NSString *)requestURI{
    return @"http://itunes.apple.com/cn/lookup?";
}

-(NNRequestType)requestType{
    return NNRequestTypeGet;
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
    [NNCacheManager.shared setObject:json forKey:kCacheAppInfo];
    return true;
}

- (NSDictionary *)jsonFromCache{
    NSDictionary *dic = [NNCacheManager.shared objectForKey:kCacheAppInfo];
    return dic;
}

@end
