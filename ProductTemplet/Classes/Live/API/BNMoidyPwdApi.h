//
//  BNMoidyPwdApi.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNBaseRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface BNMoidyPwdApi : NNBaseRequestApi

@property(nonatomic, strong) NSString * oldpassword;
@property(nonatomic, strong) NSString * newpassword;

@end

NS_ASSUME_NONNULL_END
