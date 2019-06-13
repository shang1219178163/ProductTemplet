//
//  BNBaseRequestApi.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNRequstManager.h"
#import "BNStoreManger.h"
#import "BNCacheManager.h"
#import "BNCacheKey.h"
#import "NSError+Helper.h"
#import "APIRequestURL.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNBaseRequestApi : BNRequstManager<BNRequestManagerProtocol>


@end

NS_ASSUME_NONNULL_END
