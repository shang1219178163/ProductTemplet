//
//  RoutePageSearchHelper.h
//  ProductTemplet
//
//  Created by BIN on 2026/8/23.
//  Copyright © 2026 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 总览页路由控制器扫描工具
@interface RoutePageSearchHelper : NSObject

/// 扫描主工程全部控制器类名（排除 Pods/系统框架、基类、虚拟类），按类名忽略大小写排序
+ (NSArray<NSString *> *)scanControllerList;

@end

NS_ASSUME_NONNULL_END
