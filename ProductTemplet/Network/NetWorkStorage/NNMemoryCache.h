//
//  NNMemoryCache.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>
#import "NNCacheProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NNMemoryCache : NSObject<NNCacheProtocol>

- (instancetype)initWithCache:(YYMemoryCache *)cache;

@end

NS_ASSUME_NONNULL_END
