//
//  BNCacheManager.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>
#import "BNCacheProtocol.h"
#import "BNMemoryCache.h"
#import "BNDiskCache.h"
#import "BNCacheKey.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNCacheManager : NSObject<BNCacheProtocol>

@property (strong, nonatomic, readonly) BNDiskCache *diskCache;
@property (strong, nonatomic, readonly) BNMemoryCache *memoryCache;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
