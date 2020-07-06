
//
//  NSDictionary+Tmp.m
//  AccessControlSystem
//
//  Created by Bin Shang on 2019/8/21.
//  Copyright © 2019 irain. All rights reserved.
//

#import "NSDictionary+Tmp.h"

@interface NSDictionary ()<NSCopying, NSMutableCopying, NSSecureCoding, NSFastEnumeration>

@end

@implementation NSDictionary(Tmp)

//- (NSDictionary<id, id> *)map:(id (NS_NOESCAPE ^)(id key, id obj))block{
//    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
//    [self enumerateKeysAndObjectsUsingBlock:^(NSObject<NSCopying> * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
//        if (block && block(key, obj)) {
//            [mdic setObject:obj forKey:key];
//        }
//        NSObject *blockResult = block(key, obj) ? : obj;
//        [mdic setObject:blockResult forKey:key];
//    }];
//    return mdic.copy;
//}

- (NSDictionary *)filter:(BOOL (NS_NOESCAPE ^)(id key, id obj))block{
    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
     [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
         if (block && block(key, obj) == true) {
             [mdic setObject:obj forKey:key];
         }
     }];
    return mdic.copy;
}

//- (nullable NSDictionary<KeyType, ObjectType> *)filter:(BOOL(^)(KeyType key, ObjectType obj))handler{
////    assert([self.allKeys.firstObject isKindOfClass:NSString.class]);
//    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
//    [self enumerateKeysAndObjectsUsingBlock:^(NSObject<NSCopying> * _Nonnull key, NSObject * _Nonnull obj, BOOL * _Nonnull stop) {
//        if (handler && handler(key, obj) == true) {
//            [mdic setObject:obj forKey:key];
//        }
//    }];
//    return mdic.copy;
//}

//- (NSDictionary *)invert{
//    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
//    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        if (obj) {
//            [mdic setObject:key forKey:obj];
//        }
//    }];
//    return mdic.copy;
//}

//- (NSDictionary *)subDictionaryWithKeys:(NSArray *)keys{
//    __block NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
//    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
//        if (obj) {
//            [mdic setObject:key forKey:obj];
//        }
//    }];
//    return mdic.copy;
//}


@end
