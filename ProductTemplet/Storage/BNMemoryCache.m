//
//  BNMemoryCache.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNMemoryCache.h"

@implementation BNMemoryCache{
    YYMemoryCache * _memoryCache;
    
}

-  (instancetype)initWithCache:(YYMemoryCache *)publicCache{
    self = [super init];
    if (self) {
        _memoryCache = publicCache;
    }
    return self;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key{
    [_memoryCache setObject:object forKey:key];
}

- (id)objectForKey:(NSString *)key{
    return [_memoryCache objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key{
    [_memoryCache removeObjectForKey:key];
}

- (void)clearCache{
    [_memoryCache removeAllObjects];
}

@end
