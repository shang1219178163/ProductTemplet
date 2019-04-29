//
//  BNStoreManger.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNCacheManager.h"

NS_ASSUME_NONNULL_BEGIN

/// 封装缓存key
@interface BNStoreManger : NSObject

+ (id)userModel;

+ (void)setUserModel:(id)model;
    
@end

NS_ASSUME_NONNULL_END
