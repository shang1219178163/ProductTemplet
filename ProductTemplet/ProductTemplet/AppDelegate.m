//
//  AppDelegate.m
//  ProductTemplet
//
//  Created by hsf on 2018/4/17.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "AppDelegate.h"

#import "UIApplication+Helper.h"
#import "UIApplication+Other.h"
#import "BN_Category.h"

#import "ZYSliderViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  
    UIViewController * controller = UICtrFromString(@"BN_HomeViewController");
    UIViewController * controllerLeft = UICtrFromString(@"BN_LeftViewController");
    UIViewController * controllerRight = UICtrFromString(@"BN_RightViewController");

//    controller = UICtrFromString(@"WHKGroupViewViewController");
//    controller = UICtrFromString(@"LiveLikeController");
//    controller = UICtrFromString(@"SortViewController");
    controller = UICtrFromString(@"FriendListController");
    controller = UICtrFromString(@"FontListController");
    
    ZYSliderViewController * rootVC = [[ZYSliderViewController alloc]initWithMainViewController:controller leftViewController:controllerLeft rightViewController:controllerRight];
    
//    NSArray *list = @[@[@"BN_FirstViewController",@"首页",@"Item_first_N",@"Item_first_H",@"8",],
//                      @[@"BN_SecondViewController",@"圈子",@"Item_second_N",@"Item_second_H",@"11",],
//                      @[@"BN_CenterViewController",@"总览",@"Item_center_N",@"Item_center_H",@"10",],
//                      @[@"BN_ThirdViewController",@"消息",@"Item_third_N",@"Item_third_H",@"12",],
//                      @[@"BN_FourthViewController",@"我的",@"Item_fourth_N",@"Item_fourth_H",@"13",],
//
//                      ];
//    UITabBarController * rootVC = UITarBarCtrFromList(list);
//    rootVC = UINaviCtrFromObj(@"BN_SecondViewController");
//    rootVC.tabBar.tintColor = UIColor.themeColor;
//    if (iOSVersion(10)) rootVC.tabBar.unselectedItemTintColor = UIColor.grayColor;
//    rootVC.tabBar.tintColor = UIColor.themeColor;
//    rootVC.selectedViewController = rootVC.viewControllers[2];

    [UIApplication setupRootController:rootVC isAdjust:NO];
    [UIApplication setupAppearance];
    [UIApplication setupIQKeyboardManager];
    
    UIApplication.tabBarController.selectedIndex = 3;

    return YES;
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//    UIViewController * controller = [NSClassFromString(@"MainViewController") new];
////    controller = [NSClassFromString(@"BN_TableViewController") new];
////    controller = [NSClassFromString(@"CircleViewController") new];
////    controller = [NSClassFromString(@"SphereViewController") new];
////    controller = [NSClassFromString(@"PickerViewController") new];
////    controller = [NSClassFromString(@"SectionListViewController") new];
//    controller = [NSClassFromString(@"BN_UserLoginController") new];
////    controller = [NSClassFromString(@"BN_LearnMasonryController") new];
//    controller = [NSClassFromString(@"TestViewController") new];
//
//    UINavigationController * mainNav = [[UINavigationController alloc]initWithRootViewController:controller];
//    self.window.rootViewController = mainNav;
//
//    self.window.backgroundColor = UIColor.whiteColor;
//    [self.window makeKeyAndVisible];
///*
//    if (DEBUG) InstallUncaughtExceptionHandler();
//    NSString * controlName = @"BN_HomeViewController";
//    [UIApplication setupRootControllerName:controlName];
// */
//    [UIApplication setupAppearance];
//
//    return YES;
//}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
