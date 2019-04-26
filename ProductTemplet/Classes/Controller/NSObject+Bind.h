//
//  NSObject+Bind.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Bind)

- (void)observeTarget:(id)target keyPath:(NSString *)keyPath onChange:(void(^)(NSString *keyPath, id obj))handlder;

@end

NS_ASSUME_NONNULL_END
