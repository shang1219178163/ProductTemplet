//
//  BNDeviceListApi.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNBaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNDeviceListApi : NNBaseRequestApi

@property(nonatomic, assign) NSInteger limit;
@property(nonatomic, assign) BOOL online;

@end

NS_ASSUME_NONNULL_END
