//
//  BNLog.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNLog.h"

@implementation BNLog

+ (void)logRequestURI:(NSString *)uri{
    DDLog(@"URI: >> %@",uri);
}

+ (void)logParams:(NSDictionary *)params{
    NSString * queryStr = [params jsonString];
    DDLog(@"%@",queryStr);
}

+ (void)logResponseJSON:(NSDictionary *)params{
    NSString * queryStr = [params jsonString];
    DDLog(@"%@",queryStr);
}

+ (void)logRequestInfoWithURI:(NSString *)uri params:(NSDictionary *)params{
    DDLog(@"------------ Request Info --------------");
    [self logRequestURI:uri];
    [self logParams:params];
}

+ (void)logResponseInfoWithURI:(NSString *)uri responseJSON:(NSDictionary *)json{
    DDLog(@"------------- Response Info ----------------");
    [self logRequestURI:uri];
    [self logResponseJSON:json];
}

@end
