//
//  UIBarButtonItem+Block.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/18.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Block)

- (void)addActionBlock:(void(^)(UIBarButtonItem *reco))actionBlock;

@end

NS_ASSUME_NONNULL_END
