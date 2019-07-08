//
//  BNDiskCache.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYCache/YYCache.h>
#import "BNCacheProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNDiskCache : NSObject<BNCacheProtocol>

-  (instancetype)initWithCache:(YYDiskCache *)cache;

@end

NS_ASSUME_NONNULL_END
