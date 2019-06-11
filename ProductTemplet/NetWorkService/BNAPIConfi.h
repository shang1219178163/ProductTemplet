//
//  BNAPIConfi.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BNAPIConfi : NSObject
/// 接口列表
@property (class, nonatomic, strong, readonly) NSArray * serviceUrlList;

/// 测试接口(必须在serviceUrlList中)
@property (class, nonatomic, strong) NSString * testUrl;

/**
 web服务器请求地址
 */
@property (class, nonatomic, strong, readonly) NSString * serviceUrl;

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


