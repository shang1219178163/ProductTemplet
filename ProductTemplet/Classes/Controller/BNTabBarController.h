//
//  BNTabBarController.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/8.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BNTabBarController : UIViewController

@property (nonatomic, copy) NSArray<__kindof UIViewController *> *viewControllers;
@property (nonatomic, strong) __kindof UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;



@end


