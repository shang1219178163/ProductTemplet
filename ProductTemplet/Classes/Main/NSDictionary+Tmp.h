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

//- (NSDictionary<KeyType, ObjectType> *)map:(id (NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;

- (NSDictionary<KeyType, ObjectType> *)filter:(BOOL(NS_NOESCAPE ^)(KeyType key, ObjectType obj))block;

//- (NSDictionary *)invert;

@end

NS_ASSUME_NONNULL_END
