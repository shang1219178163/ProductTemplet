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



@end


@interface UIViewController (Tmp)

//- (UIView *)createBarItem:(NSString *)obj isLeft:(BOOL)isLeft handler:(void(^)(UIButton *sender))handler;

@end


@interface UITabBarItem (TmpBadge)

/// badge ≤ 0 / @"0" / nil 时不显示角标
- (void)tmp_updateBadgeValue:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
