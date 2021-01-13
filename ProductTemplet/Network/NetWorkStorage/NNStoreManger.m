//
//  NNStoreManger.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNStoreManger.h"

@implementation NNStoreManger

+ (id)userModel{
    return [NNCacheManager.shared objectForKey:kCacheKeyUserModel];
}

+ (void)setUserModel:(id)model{
    [NNCacheManager.shared setObject:model forKey:kCacheKeyUserModel];
}

@end
