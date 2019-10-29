//
//  NNBaseRequestApi.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNBaseRequestApi.h"

@implementation NNBaseRequestApi

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

- (NNRequestType)requestType{
    return NNRequestTypeGet;
}

- (NSDictionary *)requestParams{
    return @{};
}

- (BOOL)validateParams{
    return true;
}

@end
