//
//  RoutePageSearchHelper.m
//  ProductTemplet
//
//  Created by BIN on 2026/8/23.
//  Copyright © 2026 BN. All rights reserved.
//

#import "RoutePageSearchHelper.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation RoutePageSearchHelper

/// 用运行时 C 函数判断 cls 是否为 target 的子类（避免对非 NSObject 继承链类发消息崩溃）
static BOOL RoutePageIsSubclassOf(Class cls, Class target){
    for (Class c = class_getSuperclass(cls); c != Nil; c = class_getSuperclass(c)) {
        if (c == target) return YES;
    }
    return NO;
}

+ (NSArray<NSString *> *)scanControllerList{
    int count = objc_getClassList(NULL, 0);
    Class *buffer = (Class *)malloc(sizeof(Class) * count);
    objc_getClassList(buffer, count);

    NSMutableArray<Class> *controllers = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Class cls = buffer[i];
        if (class_isMetaClass(cls)) continue;
        if (!RoutePageIsSubclassOf(cls, UIViewController.class)) continue;
        // 仅保留主工程类，排除 Pods 动态 framework 与系统框架类
        if ([NSBundle bundleForClass:cls] != NSBundle.mainBundle) continue;
        [controllers addObject:cls];
    }
    free(buffer);

    // 基类排除：被主工程其他控制器继承的类移除
    NSMutableArray<Class> *tmp = controllers.mutableCopy;
    for (Class cls in controllers) {
        Class sup = class_getSuperclass(cls);
        if (sup == NULL) continue;
        for (NSInteger i = tmp.count - 1; i >= 0; i--) {
            if (tmp[i] == sup) {
                [tmp removeObjectAtIndex:i];
            }
        }
    }
    controllers = tmp;

    // 名称排除：含 tmp/super/base/abstract 的虚拟类移除，AnimationController 前缀由 AnimationHomeController 统一承载
    NSArray<NSString *> *blackwords = @[@"tmp", @"super", @"base", @"abstract"];
    NSMutableArray<NSString *> *names = [NSMutableArray arrayWithCapacity:controllers.count];
    for (Class cls in controllers) {
        NSString *name = NSStringFromClass(cls);
        if ([name hasPrefix:@"AnimationController"]) continue;
        NSString *lower = name.lowercaseString;
        BOOL keep = YES;
        for (NSString *word in blackwords) {
            if ([lower containsString:word]) {
                keep = NO;
                break;
            }
        }
        if (keep) {
            [names addObject:name];
        }
    }

    return [names sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

@end
