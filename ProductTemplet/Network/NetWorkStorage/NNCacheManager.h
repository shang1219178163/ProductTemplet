//
//  NNCacheManager.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>
#import "NNCacheProtocol.h"
#import "NNMemoryCache.h"
#import "NNDiskCache.h"
#import "NNCacheKey.h"

NS_ASSUME_NONNULL_BEGIN

@interface NNCacheManager : NSObject<NNCacheProtocol>

@property (strong, nonatomic, readonly) NNDiskCache *diskCache;
@property (strong, nonatomic, readonly) NNMemoryCache *memoryCache;

+ (instancetype)shared;

@end

NS_ASSUME_NONNULL_END
