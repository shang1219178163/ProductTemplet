//
//  NNBaseRequestApi.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNRequstManager.h"
#import "NNStoreManger.h"
#import "NNCacheManager.h"
#import "NNCacheKey.h"
#import "NSError+Helper.h"
#import "APIRequestURL.h"

NS_ASSUME_NONNULL_BEGIN

@interface NNBaseRequestApi : NNRequstManager<NNRequestManagerProtocol>


@end

NS_ASSUME_NONNULL_END
