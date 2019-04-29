//
//  BNCacheManager.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNCacheManager.h"

@implementation BNCacheManager{
    YYCache * _cache;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _cache = [YYCache cacheWithName:@"BNCache"];
        _diskCache = [[BNDiskCache alloc]initWithCache: _cache.diskCache];
        _memoryCache = [[BNMemoryCache alloc]initWithCache:_cache.memoryCache];
        
    }
    return self;
}

+ (instancetype)shared{
    static BNCacheManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BNCacheManager alloc]init];
        
    });
    return _instance;
}

#pragma mark - Save

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [_cache setObject:object forKey:key];
}

#pragma mark - Get

- (id)objectForKey:(NSString *)key{
    return [_cache objectForKey:key];
}

#pragma mark - Remove

- (void)removeObjectForKey:(NSString *)key{
    [_cache removeObjectForKey:key];
}

#pragma mark - Clear

- (void)clearCache{
    [_cache removeAllObjects];
}


@end
