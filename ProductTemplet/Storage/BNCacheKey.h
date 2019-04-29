//
//  BNCacheKey.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNCacheKey : NSObject

FOUNDATION_EXPORT NSString * const kCacheKeyToken ;
FOUNDATION_EXPORT NSString * const kCacheKeyUserModel ;
FOUNDATION_EXPORT NSString * const kCacheKeyAccount ;
FOUNDATION_EXPORT NSString * const kCacheKeyPwd ;
FOUNDATION_EXPORT NSString * const kCacheAppInfo ;

@end

NS_ASSUME_NONNULL_END
