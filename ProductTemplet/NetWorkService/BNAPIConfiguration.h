//
//  BNAPIConfiguration.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BNAPIConfiguration : NSObject

@property (class, nonatomic, strong, readonly) NSArray * urlTestList;
// urlDebug必须在urlDebugList中包含
@property (class, nonatomic, strong) NSString * urlTest;

/**
 web服务器请求地址
 */
+ (NSString *)serviceURLString;

/**
 API请求头中的UserAgent
 */
+ (NSString *)headerUserAgent;

/**
 API请求头中的请求Version
 */
+ (NSString *)headerAcceptVersion;

/**
 超时时间
 */
+ (NSInteger)timeOut;

@end


