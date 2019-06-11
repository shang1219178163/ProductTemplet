//
//  BNLog.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/28.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNLog : NSObject

+ (void)logRequestURI:(NSString *)uri;

+ (void)logParams:(NSDictionary *)params;

+ (void)logResponseJSON:(NSDictionary *)params;

+ (void)logRequestInfoWithURI:(NSString *)uri params:(NSDictionary *)params;

+ (void)logResponseInfoWithURI:(NSString *)uri responseJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
