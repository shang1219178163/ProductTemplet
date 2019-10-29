//
//  NNCacheProtocol.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/29.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NNCacheProtocol <NSObject>

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

- (void)clearCache;

@end

NS_ASSUME_NONNULL_END
