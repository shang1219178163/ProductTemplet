//
//  AppDelegate.m
//  ProductTemplet
//
//  Created by BIN on 2018/4/17.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "AppDelegate.h"

#import "NNCategoryPro.h"

#import "ZYSliderViewController.h"
#import "FileShareController.h"
#import "ProductTemplet-Swift.h"

@interface AppDelegate ()
/// 后台定时定位
@property(nonatomic, strong) NSTimer *locationTimer;
/// app间文件共享
@property(nonatomic, strong) FileShareController * fileController;
@property(nonatomic, strong) UINavigationController * navController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupThridSDKWithOptions:launchOptions];
    UIColor.themeColor = UIColor.orangeColor;
    UIColor.themeColor = UIColorHexValue(0x0082e0);
    
    [UIApplication setupAppearanceDefault:false];
    
    UIViewController * controller = UICtrFromString(@"HomeViewController");
    UIViewController * controllerLeft = UICtrFromString(@"NNLeftViewController");
    UIViewController * controllerRight = UICtrFromString(@"NNRightViewController");

    ZYSliderViewController * rootVC = [[ZYSliderViewController alloc]initWithMainViewController:controller leftViewController:controllerLeft rightViewController:controllerRight];
    
//    controller = UICtrFromString(@"WHKGroupViewViewController");
//    controller = UICtrFromString(@"LiveLikeController");
//    controller = UICtrFromString(@"SortViewController");
//    controller = UICtrFromString(@"FriendListController");
    controller = UICtrFromString(@"HomeViewController");
//    controller = UICtrFromString(@"TestViewController");
    
//    [UIApplication setupRootController:rootVC isAdjust:NO];
    [UIApplication setupRootController:controller isAdjust:NO];

//    controller = UICtrFromString(@"LoginViewController");
//    controller = UICtrFromString(@"GroupViewController");
//    [UIApplication setupRootController:controller isAdjust:true];

//    [UIApplication setupRootController:UICtrFromString(@"RecognizerController") isAdjust:YES];
//    [UIApplication setupRootController:UICtrFromString(@"UIRecognizerController") isAdjust:YES];
    
    //因为左右侧滑栏失效
//    UIApplication.tabBarController.selectedIndex = 3;
//    UIApplication.tabBarController.selectedIndex = 4;
    
    NSString * a = [NSNumberFormatter fractionDigits:@(1.4988) min:2 max:2 roundingMode:NSNumberFormatterRoundUp];
    NSString * b = [NSNumberFormatter fractionDigits:@(1.4988) min:2 max:3 roundingMode:NSNumberFormatterRoundUp];
    NSString * c = [NSNumberFormatter fractionDigits:@(1.4988) min:2 max:3 roundingMode:NSNumberFormatterRoundDown];
    NSString * e = [NSNumberFormatter fractionDigits:@(.4988) min:2 max:3 roundingMode:NSNumberFormatterRoundDown];
    NSString * f = [NSNumberFormatter fractionDigits:@(.4) min:2 max:3 roundingMode:NSNumberFormatterRoundDown];

    NSString * d = @(1.595).toString;
    
    [d isNewerWithVersion:@"1.3."];
    [d isSameWithVersion:@"2"];
    [d isOlderWithVersion:@"3"];
    [NSString dateTime:@"2" isEnd:false];
    
    return YES;
}

- (void)setupThridSDKWithOptions:(NSDictionary *)launchOptions{
    [UIApplication setupIQKeyboardManager];

//高德地图
//    AMapServices.sharedServices.apiKey = kGDMapKey;
//微信支付
//    [WXApi registerApp:kAppID_WX];
//社交分享
//    [UIApplication registerShareSDK];
    //友盟
//    [UIApplication registerUMengSDKAppKey:kAppKey_UMeng channel:kChannel_UMeng];
//    //极光
//    [self registerJPushSDKAppKey:kAppKey_JPush channel:kChannel_JPush isProduction:kIsProduction options:launchOptions];
    // 后台定位
//    [self startBackgroudUploadLocation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [UIApplication didEnterBackgroundBlock:nil];
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    DDLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    
    NSString *deviceString = [UIApplication deviceTokenStringWithDeviceToken:deviceToken];
    DDLog(@"deviceToken_%@",deviceString);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    DDLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark -
#pragma mark -Image view

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation{
    return YES;
}

#else
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options{
    //    UINavigationController * rootVC = (UINavigationController *)UIApplication.sharedApplication.delegate.window.rootViewController;
    
    NSLog(@"%@\n%@",url,options);
    self.fileController.url = url;
    self.fileController.dict = options;
    
    UIViewController *rootVC = UIApplication.sharedApplication.delegate.window.rootViewController;
    [rootVC presentViewController:self.navController animated:YES completion:nil];
    
    return YES;
}
#endif

-(FileShareController *)fileController{
    if (!_fileController) {
        _fileController = [[FileShareController alloc]init];
    }
    return _fileController;
}

-(UINavigationController *)navController{
    if (!_navController) {
        _navController = [[UINavigationController alloc] initWithRootViewController:self.fileController];
    }
    return _navController;
}

@end
