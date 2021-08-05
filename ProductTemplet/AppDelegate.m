//
//  AppDelegate.m
//  ProductTemplet
//
//  Created by BIN on 2018/4/17.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "AppDelegate.h"

#import <NNCategoryPro/NNCategoryPro.h>

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
//
    UIColor.themeColor = UIColor.orangeColor;
    UIColor.themeColor = UIColorHexValue(0x0082e0);
    [UIApplication setupAppearance:UIColor.whiteColor barTintColor:UIColor.themeColor];
    
//    UIViewController *vc = UIControllerFromString(@"HomeViewController");
//    UIViewController *vcLeft = UIControllerFromString(@"NNLeftViewController");
//    UIViewController *vcRight = UIControllerFromString(@"NNRightViewController");
//    ZYSliderViewController *rootVC = [[ZYSliderViewController alloc]initWithMainViewController:vc
//                                                                            leftViewController:vcLeft
//                                                                           rightViewController:vcRight];
    
//    vc = UIControllerFromString(@"WHKGroupViewViewController");
//    vc = UIControllerFromString(@"LiveLikeController");
//    vc = UIControllerFromString(@"SortViewController");
//    vc = UIControllerFromString(@"FriendListController");
//    vc = UIControllerFromString(@"HomeViewController");
//    vc = UIControllerFromString(@"TestViewController");
    UIApplication.rootController = UIControllerFromString(@"HomeViewController");;
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self setupThridSDKWithOptions:launchOptions];
//    })

//    controller = UIControllerFromString(@"LoginViewController");
//    controller = UIControllerFromString(@"GroupViewController");
//    [UIApplication setupRootController:controller isAdjust:true];

//    [UIApplication setupRootController:UIControllerFromString(@"RecognizerController") isAdjust:YES];
//    [UIApplication setupRootController:UIControllerFromString(@"UIRecognizerController") isAdjust:YES];
    
    //因为左右侧滑栏失效
//    UIApplication.tabBarController.selectedIndex = 3;
//    UIApplication.tabBarController.selectedIndex = 4;
    
//    NSString *a = [NSNumberFormatter fractionDigits:@(1.4988) min:2 max:2 roundingMode:NSNumberFormatterRoundUp];
//    NSString *b = [NSNumberFormatter fractionDigits:@(1.4988) min:2 max:3 roundingMode:NSNumberFormatterRoundUp];
//    NSString *c = [NSNumberFormatter fractionDigits:@(1.4988) min:2 max:3 roundingMode:NSNumberFormatterRoundDown];
//    NSString *e = [NSNumberFormatter fractionDigits:@(.4988) min:2 max:3 roundingMode:NSNumberFormatterRoundDown];
//    NSString *f = [NSNumberFormatter fractionDigits:@(.4) min:2 max:3 roundingMode:NSNumberFormatterRoundDown];
//
//    NSString *d = @(1.595).toString;
//    [NSString dateTime:@"2" isEnd:false];
    
//    NSString *json = NSBundle.mainBundle.infoDictionary.jsonString;
//    DDLog(@"json: %@", json);
    
//    NSMutableString *mSt = [NSMutableString string];
//    mSt.appending(@"000").appendingFormat(@"%@", @"112").replacingOccurrences(@"2", @"3", NSBackwardsSearch);
////    mSt.append(@"000").appendFormat(@"%@", @"112").replaceOccurrences(@"2", @"3", NSBackwardsSearch);
//    DDLog(@"mSt: %@", mSt);
    
//    NSString *tmp = [self appendFormat:@"%@_%@", @"aaa", @"bbb"];
//    DDLog(@"tmp: %@", tmp);
    
    NSNumber *min = @(0.6767);
    NSNumber *max = @(123456789.6767);
    
    NSNumber *phone = @(18729742695);
    NSNumber *IDCard = @(4392260032488908);
    NSNumber *bankCard = @(610431198903080651);
   
    NSNumberFormatter *fmtNone = [NSNumberFormatter numberStyle:NSNumberFormatterNoStyle];
    fmtNone.group(@" ", 4);

    NSString *a =  [fmtNone stringFromNumber:phone];
    NSString *b =  [fmtNone stringFromNumber:IDCard];
    NSString *c =  [fmtNone stringFromNumber:bankCard];
    DDLog(@": %@ %@ %@", a, b, c);
    
    NSNumberFormatter *fmt = [NSNumberFormatter numberStyle:NSNumberFormatterCurrencyStyle];
    NSString *e =  [fmt stringFromNumber:min];
    NSString *f =  [fmt stringFromNumber:max];
    DDLog(@": %@ %@", e, f);

    return YES;
}

//- (NSString *)appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2) {
- (NSString *)appendFormat:(NSString *)format, ...{
    va_list args;
    va_start(args, format);
    NSString *appendStr = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    return appendStr;
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


+ (void)changeAppearance:(UIColor *)tintColor barTintColor:(UIColor *)barTintColor{
    
    UINavigationBar.appearance.tintColor = tintColor;
    UINavigationBar.appearance.barTintColor = barTintColor;
//    [UINavigationBar.appearance setBackgroundImage:UIImageColor(barTintColor) forBarMetrics:UIBarMetricsDefault];
//    [UINavigationBar.appearance setShadowImage:UIImageColor(barTintColor)];
    UINavigationBar.appearance.titleTextAttributes = @{NSForegroundColorAttributeName: tintColor,};
    return;

    NSDictionary *attDic = @{NSForegroundColorAttributeName: UIColor.blackColor,};
    UIBarButtonItem *speacilItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[UIImagePickerController.class, UIDocumentPickerViewController.class]];
    [speacilItem setTitleTextAttributes:attDic forState:UIControlStateNormal];

//    [UIBarButtonItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor,} forState: UIControlStateNormal];
//    [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses: @[UISearchBar.class]];
    
    
    UIButton *speacilButton = [UIButton appearanceWhenContainedInInstancesOfClasses:@[UINavigationBar.class, ]];
    [speacilButton setTitleColor:tintColor forState:UIControlStateNormal];
    speacilButton.titleLabel.adjustsFontSizeToFitWidth = true;
    speacilButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    speacilButton.exclusiveTouch = true;
    speacilButton.adjustsImageWhenHighlighted = false;
    
    
    [UIButton.appearance setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    UIButton.appearance.titleLabel.adjustsFontSizeToFitWidth = true;
    UIButton.appearance.imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIButton.appearance.exclusiveTouch = true;
    UIButton.appearance.adjustsImageWhenHighlighted = false;
    
    
    UISegmentedControl *speacilSegmentedControl = [UISegmentedControl appearanceWhenContainedInInstancesOfClasses:@[UINavigationBar.class, ]];
    speacilSegmentedControl.tintColor = tintColor;
    [speacilSegmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor} forState:UIControlStateNormal];
    [speacilSegmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: barTintColor} forState:UIControlStateSelected];

    UISegmentedControl.appearance.tintColor = tintColor;

    
    UIScrollView.appearance.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIScrollView.appearance.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    UIScrollView.appearance.showsHorizontalScrollIndicator = false;
    UIScrollView.appearance.exclusiveTouch = true;
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    UITableView.appearance.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    UITableView.appearance.separatorInset = UIEdgeInsetsZero;
    UITableView.appearance.rowHeight = 60;
    UITableView.appearance.backgroundColor = UIColor.groupTableViewBackgroundColor;
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0.0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0.0;
        UITableView.appearance.estimatedSectionFooterHeight = 0.0;
    }
    
    
    UITableViewCell.appearance.layoutMargins = UIEdgeInsetsZero;
    UITableViewCell.appearance.separatorInset = UIEdgeInsetsZero;
    UITableViewCell.appearance.selectionStyle = UITableViewCellSelectionStyleNone;
    UITableViewCell.appearance.backgroundColor = UIColor.whiteColor;

    
    UICollectionView.appearance.scrollsToTop = false;
    UICollectionView.appearance.pagingEnabled = false;

    
    UICollectionViewCell.appearance.layoutMargins = UIEdgeInsetsZero;
    UICollectionViewCell.appearance.backgroundColor = UIColor.whiteColor;
    
    
    UIImageView.appearance.userInteractionEnabled = true;
    
    
    UILabel.appearance.userInteractionEnabled = true;

    
    UIPageControl.appearance.pageIndicatorTintColor = barTintColor;
    UIPageControl.appearance.currentPageIndicatorTintColor = tintColor;
    UIPageControl.appearance.userInteractionEnabled = true;
    UIPageControl.appearance.hidesForSinglePage = true;
    
    
    UIProgressView.appearance.progressTintColor = barTintColor;
    UIProgressView.appearance.trackTintColor = UIColor.clearColor;
    
    
    UIDatePicker.appearance.datePickerMode = UIDatePickerModeDate;
    UIDatePicker.appearance.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    UIDatePicker.appearance.backgroundColor = UIColor.whiteColor;
    if (@available(iOS 13.4, *)) {
        UIDatePicker.appearance.preferredDatePickerStyle = UIDatePickerStyleWheels;
    }
    
    
    UISlider.appearance.minimumTrackTintColor = tintColor;
    UISlider.appearance.autoresizingMask = UIViewAutoresizingFlexibleWidth;


    UISwitch.appearance.onTintColor = tintColor;
    UISwitch.appearance.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

@end
