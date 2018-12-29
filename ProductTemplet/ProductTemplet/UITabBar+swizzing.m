//
//  UITabBar+swizzing.m
//  ProductTemplet
//
//  Created by Bin Shang on 2018/12/29.
//  Copyright © 2018 BN. All rights reserved.
//

#import "UITabBar+swizzing.h"

#import "NSObject+swizzling.h"

@implementation UITabBar (swizzing)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            
//            SwizzleMethodInstance(@"UITabBar", @selector(setBarTintColor:), @selector(swz_setBarTintColor:));
//            SwizzleMethodInstance(@"UIImageView", NSSelectorFromString(@"setTintColor:"), NSSelectorFromString(@"swz_setTintColor:"));
            
        });
    }
}


- (void)swz_setBarTintColor:(UIColor *)color {
    [self swz_setBarTintColor:color];
    
    self.selectedItem.image = [self.selectedItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

//    if (self.selectedItem.image.renderingMode != UIImageRenderingModeAlwaysTemplate) {
//        self.selectedItem.image = [self.selectedItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    }
    
}


@end
