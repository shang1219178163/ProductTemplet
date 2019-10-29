//
//  NSObject+Tmp.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/25.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Tmp)

/// 模型转字典
- (NSDictionary *)dictionaryFromModel;

/// 带model的数组或字典转字典
- (id)idFromObject:(id)object;


@end

NS_ASSUME_NONNULL_END
