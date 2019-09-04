//
//  NNTabBarController.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/8.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

///嵌套TabBar,实现类UITabBarController功能
@interface NNTabBarController : UIViewController

@property (nonatomic, copy) NSArray<__kindof UIViewController *> *viewControllers;
@property (nonatomic, strong) __kindof UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;


@end


