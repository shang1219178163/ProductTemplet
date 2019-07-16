//
//  BNUserLoginApi.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNBaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNUserLoginApi : BNBaseRequestApi

@property(nonatomic, strong) NSString * name;
@property(nonatomic, strong) NSString * password;

@end

NS_ASSUME_NONNULL_END
