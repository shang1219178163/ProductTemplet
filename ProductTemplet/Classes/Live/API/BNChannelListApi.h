//
//  BNChannelListApi.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNBaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNChannelListApi : NNBaseRequestApi

@property(nonatomic, strong) NSString * ID;
@property(nonatomic, assign) NSInteger limit;
@property(nonatomic, assign) NSInteger start;

@end

NS_ASSUME_NONNULL_END
