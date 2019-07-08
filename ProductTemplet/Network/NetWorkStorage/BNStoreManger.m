//
//  BNStoreManger.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNStoreManger.h"

@implementation BNStoreManger

+ (id)userModel{
    return [BNCacheManager.shared objectForKey:kCacheKeyUserModel];
}

+ (void)setUserModel:(id)model{
    [BNCacheManager.shared setObject:model forKey:kCacheKeyUserModel];
}

@end
