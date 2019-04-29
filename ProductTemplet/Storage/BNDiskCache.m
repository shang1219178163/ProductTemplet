//
//  BNDiskCache.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNDiskCache.h"

@implementation BNDiskCache{
    YYDiskCache * _diskCache;

}

-  (instancetype)initWithCache:(YYDiskCache *)publicCache{
    self = [super init];
    if (self) {
        _diskCache = publicCache;
    }
    return self;
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key{
    [_diskCache setObject:object forKey:key];
}

- (id)objectForKey:(NSString *)key{
    return [_diskCache objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key{
    [_diskCache removeObjectForKey:key];
}

- (void)clearCache{
    [_diskCache removeAllObjects];
}

@end
