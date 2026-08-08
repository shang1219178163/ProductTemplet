//
//  NSObject+Tmp.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/25.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NSObject+Tmp.h"
#import <objc/runtime.h>

@implementation NSObject (Tmp)



@end



@implementation UIViewController (Tmp)

/**
 可隐藏的导航栏按钮
 */
//- (UIView *)createBarItem:(NSString *)obj isLeft:(BOOL)isLeft handler:(void(^)(UIButton *sender))handler{
//    UIButton *sender = [UIButton buttonWithType:UIButtonTypeSystem];
//    if ([UIImage imageNamed:obj]) {
//        [sender setImage:[UIImage imageNamed:obj] forState:UIControlStateNormal];
//    } else {
//        [sender setTitle:obj forState:UIControlStateNormal];
//    }
//    [sender addActionHandler:handler forControlEvents:UIControlEventTouchUpInside];
//   
//    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:sender];
//    if (isLeft) {
//        self.navigationItem.leftBarButtonItem = barItem;
//    } else {
//        self.navigationItem.rightBarButtonItem = barItem;
//    }
//    return sender;
//}

@end


@implementation UITabBarItem (TmpBadge)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method original = class_getInstanceMethod(self, @selector(updateBadgeValue:));
        Method replacement = class_getInstanceMethod(self, @selector(tmp_updateBadgeValue:));
        if (original && replacement) {
            method_exchangeImplementations(original, replacement);
        }
    });
}

- (void)tmp_updateBadgeValue:(NSString *)value {
    NSInteger count = value.integerValue;
    if (count > 0) {
        self.badgeValue = value;
        self.badgeColor = UIColor.redColor;
    } else {
        self.badgeValue = nil;
    }
}

@end
