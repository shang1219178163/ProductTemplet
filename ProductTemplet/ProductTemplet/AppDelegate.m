//
//  AppDelegate.m
//  ProductTemplet
//
//  Created by hsf on 2018/4/17.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "AppDelegate.h"


#import "UIApplication+Helper.h"
#import "UIApplication+Share.h"


#import "ZYSliderViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController * controller = [NSClassFromString(@"BN_HomeViewController") new];
    UIViewController * controllerLeft = [NSClassFromString(@"BN_LeftViewController") new];
    UIViewController * controllerRight = [NSClassFromString(@"BN_RightViewController") new];
    controller = [NSClassFromString(@"WHKGroupViewViewController") new];
    controller = [NSClassFromString(@"LiveLikeController") new];
    
    ZYSliderViewController * rootVC = [[ZYSliderViewController alloc]initWithMainViewController:controller leftViewController:controllerLeft rightViewController:controllerRight];
    self.window.rootViewController = rootVC;

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

     [UIApplication setupAppearance];

    return YES;
}

//- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
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
//    self.window.backgroundColor = [UIColor whiteColor];
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
