//
//  NSDictionary+Tmp.h
//  AccessControlSystem
//
//  Created by Bin Shang on 2019/8/21.
//  Copyright © 2019 irain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSEnumerator.h>

@class NSArray<ObjectType>, NSSet<ObjectType>, NSString, NSURL;

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary<KeyType, ObjectType>(Tmp)

- (NSDictionary<NSObject<NSCopying> *, NSObject *> *)map:(NSObject *(^)(NSObject<NSCopying> *key, NSObject *obj))handler;

//- (nullable NSDictionary<KeyType, ObjectType> *)filter:(BOOL(^)(KeyType key, ObjectType obj))handler;
- (nullable NSDictionary<NSObject<NSCopying> *, NSObject *> *)filter:(BOOL(^)(NSObject<NSCopying> *key, NSObject *obj))handler;

//- (NSDictionary *)invert;

@end

NS_ASSUME_NONNULL_END
