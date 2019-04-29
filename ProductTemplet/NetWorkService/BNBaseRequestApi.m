//
//  BNBaseRequestApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNBaseRequestApi.h"

@implementation BNBaseRequestApi

- (instancetype)init{
    self = [super init];
    if (self) {
        self.child = self;
        
    }
    return self;
}

-(NSString *)requestURI{
    NSException *exception = [NSException exceptionWithName:@"RequestURI is need overwrite" reason:@"RequestURI is need overwrite" userInfo:nil];
    @throw exception;
    return nil;
}

- (BNRequestType)requestType{
    return BNRequestTypeGet;
}

- (NSDictionary *)requestParams{
    return @{};
}

- (BOOL)validateParams{
    return true;
}

@end
