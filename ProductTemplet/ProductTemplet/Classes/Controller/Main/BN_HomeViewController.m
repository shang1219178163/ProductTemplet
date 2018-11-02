//
//  BN_HomeViewController.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_HomeViewController.h"


NSString *const CYLTabBarItemController = @"CYLTabBarItemController";

@interface BN_HomeViewController ()<UITabBarControllerDelegate>

@end

@implementation BN_HomeViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupTabBarController];
        
//        self.tabBar.unselectedItemTintColor = UIColor.blackColor;
//        self.tabBar.tintColor = UIColor.redColor;
        if (iOSVersion(10)) {
            self.tabBar.unselectedItemTintColor = UIColor.grayColor;

        }
        self.tabBar.tintColor = UIColor.themeColor;
        //显示未读
//        UINavigationController *firstNav = (UINavigationController *)[self.viewControllers firstObject];
//        UITabBarItem *itemFirst = firstNav.tabBarItem;
//        itemFirst.badgeValue = @"2";
        
        self.selectedViewController = self.viewControllers[2];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}

- (void)setupTabBarController {
    /// 设置TabBar属性数组
    self.tabBarItemsAttributes = [self itemsAttributesForController];
    
    /// 设置控制器数组
    self.viewControllers = [self mpViewControllers];
    
    self.delegate = self;
    self.moreNavigationController.navigationBarHidden = YES;
    
}

//控制器设置
- (NSArray *)mpViewControllers {
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary * dict in self.tabBarItemsAttributes) {
        UIViewController * controller = [NSClassFromString(dict[CYLTabBarItemController]) new];
        controller.title = dict[CYLTabBarItemTitle];
//        controller.hidesBottomBarWhenPushed = YES;//必须屏蔽
        UINavigationController *navController = [[UINavigationController alloc]
                                                 initWithRootViewController:controller];
        [marr addObject:navController];
    }
    return marr.copy;
}

//TabBar文字跟图标设置
- (NSArray *)itemsAttributesForController {
    NSDictionary *firstAttDict = @{
                                   CYLTabBarItemTitle          :   @"首页",
                                   CYLTabBarItemImage          :   @"Item_first_N",
                                   CYLTabBarItemSelectedImage  :   @"Item_first_H",
                                   CYLTabBarItemController     :   @"BN_FirstViewController"
                                   
                                   };
    
    NSDictionary *secondAttDict = @{
                                    CYLTabBarItemTitle          :   @"圈子",
                                    CYLTabBarItemImage          :   @"Item_second_N",
                                    CYLTabBarItemSelectedImage  :   @"Item_second_H",
                                    CYLTabBarItemController     :   @"BN_SecondViewController"
                                    
                                    };
    
    NSDictionary *thirdAttDict = @{
                                   CYLTabBarItemTitle           :   @"消息",
                                   CYLTabBarItemImage           :   @"Item_third_N",
                                   CYLTabBarItemSelectedImage   :   @"Item_third_H",
                                   CYLTabBarItemController      :   @"BN_ThirdViewController"
                                   
                                   };
    
    NSDictionary *fourthAttDict = @{
                                    CYLTabBarItemTitle          :   @"我的",
                                    CYLTabBarItemImage          :   @"Item_fourth_N",
                                    CYLTabBarItemSelectedImage  :   @"Item_fourth_H",
                                    CYLTabBarItemController     :   @"BN_FourthViewController",

                                    };
    NSDictionary *centerAttDict = @{
                                    CYLTabBarItemTitle          :   @"总览",
                                    CYLTabBarItemImage          :   @"Item_center_N",
                                    CYLTabBarItemSelectedImage  :   @"Item_center_H",
                                    CYLTabBarItemController     :   @"BN_CenterViewController"
                                    
                                    };
    
    NSArray *tabBarItemsAttDict = @[
                                    firstAttDict,
                                    secondAttDict,
                                    centerAttDict,
                                    thirdAttDict,
                                    fourthAttDict
                                    ];

    return tabBarItemsAttDict;
}

#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UINavigationController*)viewController {
//    /// 特殊处理 - 是否需要登录
//    BOOL isBaiDuService = [viewController.topViewController isKindOfClass:[MPDiscoveryViewController class]];
//    if (isBaiDuService) {
//        NSLog(@"你点击了TabBar第二个");
//    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
