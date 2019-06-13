//
//  AppDelegate.m
//  ProductTemplet
//
//  Created by BIN on 2018/4/17.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "AppDelegate.h"

//#import "UIApplication+Helper.h"
//#import "UIApplication+Other.h"
#import "BNCategory.h"
#import "BNMapManager.h"

#import "ZYSliderViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupThridSDKWithOptions:launchOptions];
//    UIColor.themeColor = UIColor.orangeColor;
    [UIApplication setupAppearanceDefault:false];

    UIViewController * controller = UICtrFromString(@"HomeViewController");
    UIViewController * controllerLeft = UICtrFromString(@"BNLeftViewController");
    UIViewController * controllerRight = UICtrFromString(@"BNRightViewController");

    ZYSliderViewController * rootVC = [[ZYSliderViewController alloc]initWithMainViewController:controller leftViewController:controllerLeft rightViewController:controllerRight];
    
//    controller = UICtrFromString(@"WHKGroupViewViewController");
//    controller = UICtrFromString(@"LiveLikeController");
//    controller = UICtrFromString(@"SortViewController");
//    controller = UICtrFromString(@"FriendListController");
    controller = UICtrFromString(@"HomeViewController");

//    [UIApplication setupRootController:rootVC isAdjust:NO];
//    [UIApplication setupRootController:controller isAdjust:NO];

    controller = UICtrFromString(@"LiveViewController");
    [UIApplication setupRootController:controller isAdjust:true];

//    [UIApplication setupRootController:UICtrFromString(@"RecognizerController") isAdjust:YES];
//    [UIApplication setupRootController:UICtrFromString(@"UIRecognizerController") isAdjust:YES];
    
    
    //因为左右侧滑栏失效
//    UIApplication.tabBarController.selectedIndex = 3;
//    UIApplication.tabBarController.selectedIndex = 4;

    return YES;
}

- (void)setupThridSDKWithOptions:(NSDictionary *)launchOptions{
    [UIApplication setupIQKeyboardManager];

    //高德地图
    AMapServices.sharedServices.apiKey = kGDMapKey;
    //微信支付
    //    [WXApi registerApp:kAppID_WX];
    //社交分享
    //    [UIApplication registerShareSDK];
    //友盟
//    [UIApplication registerUMengSDKAppKey:kAppKey_UMeng channel:kChannel_UMeng];
//    //极光
//    [self registerJPushSDKAppKey:kAppKey_JPush channel:kChannel_JPush isProduction:kIsProduction options:launchOptions];
//    [self startBackgroudUploadLocation];
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//    UIViewController * controller = [NSClassFromString(@"MainViewController") new];
////    controller = [NSClassFromString(@"BNTableViewController") new];
////    controller = [NSClassFromString(@"CircleViewController") new];
////    controller = [NSClassFromString(@"SphereViewController") new];
////    controller = [NSClassFromString(@"PickerViewController") new];
////    controller = [NSClassFromString(@"SectionListViewController") new];
//    controller = [NSClassFromString(@"BNUserLoginController") new];
////    controller = [NSClassFromString(@"BNLearnMasonryController") new];
//    controller = [NSClassFromString(@"TestViewController") new];
//
//    UINavigationController * mainNav = [[UINavigationController alloc]initWithRootViewController:controller];
//    self.window.rootViewController = mainNav;
//
//    self.window.backgroundColor = UIColor.whiteColor;
//    [self.window makeKeyAndVisible];
///*
//    if (DEBUG) InstallUncaughtExceptionHandler();
//    NSString * controlName = @"BNHomeViewController";
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
