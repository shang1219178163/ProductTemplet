//
//  UIViewController+ZYSliderViewController.m
//  ZYSliderViewController
//
//  Created by zY on 16/11/14.
//  Copyright © 2016年 zY. All rights reserved.
//

#import "UIViewController+ZYSliderViewController.h"
#import "ZYSliderViewController.h"

@implementation UIViewController (ZYSliderViewController)

- (ZYSliderViewController *)sliderViewController{
    UIViewController *viewcontroller = self;
    while (viewcontroller) {
        if ([viewcontroller isKindOfClass:[ZYSliderViewController class]]) {
            return (ZYSliderViewController *)viewcontroller;
        }
        UIViewController *parent = viewcontroller.parentViewController;
        if (parent && parent != viewcontroller) {
            viewcontroller = parent;
            continue;
        }
        // Fallback: root may be the slider when not yet attached as child.
        UIViewController *root = UIApplication.sharedApplication.delegate.window.rootViewController;
        if ([root isKindOfClass:[ZYSliderViewController class]]) {
            return (ZYSliderViewController *)root;
        }
        return nil;
    }
    return nil;
}

@end
