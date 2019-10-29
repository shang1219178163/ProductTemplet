//
//  NNCacheManager.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNCacheManager.h"

@implementation NNCacheManager{
    YYCache * _cache;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _cache = [YYCache cacheWithName:@"DataCache"];
        _diskCache = [[NNDiskCache alloc]initWithCache: _cache.diskCache];
        _memoryCache = [[NNMemoryCache alloc]initWithCache:_cache.memoryCache];
        
    }
    return self;
}

+ (instancetype)shared{
    static NNCacheManager *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NNCacheManager alloc]init];
        
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
