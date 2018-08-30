
//
//  UIApplication+Helper.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIApplication+Helper.h"
#import <objc/runtime.h>

@implementation UIApplication (Helper)

+(UIWindow *)keyWindow{
    return [UIApplication sharedApplication].keyWindow;
    
}

+(UIViewController *)rootVC{
    return self.keyWindow.rootViewController;
    
}

+(NSString *)app_Name{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return  infoDict[@"CFBundleDisplayName"] ? : infoDict[@"CFBundleName"];
}

+(UIImage *)app_Icon{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    
    NSString *icon = [[infoDict valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage * image = [UIImage imageNamed:icon];
    return image;
    
}

+(NSString *)app_Version{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return  infoDict[@"CFBundleShortVersionString"];
}

+(NSString *)app_build{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    return  infoDict[@"CFBundleVersion"];
}

+(NSString *)phone_SystemVersion{
    return  [[UIDevice currentDevice] systemVersion];
    
}

+(NSString *)phone_SystemName{
    return  [[UIDevice currentDevice] systemName];
    
}

+(NSString *)phone_Name{
    if ([UIDevice currentDevice]) {
        UIDevice * device = [UIDevice currentDevice];
        return device.name;
    }
    return @"";
}

+(NSString *)phone_Model{
    return  [[UIDevice currentDevice] model];
    
}

+(NSString *)phone_localizedModel{
    return  [[UIDevice currentDevice] localizedModel];
    
}

+ (void)setupRootController:(id)controller{
    if ([controller isKindOfClass:[NSString class]]) {
        controller = [NSClassFromString(controller) new];
    }
    
    UIApplication * app = [UIApplication sharedApplication];
    app.delegate.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    app.delegate.window.backgroundColor = [UIColor whiteColor];
    
    if ([controller isKindOfClass:[UINavigationController class]] || [controller isKindOfClass:[UITabBarController class]]) {
        app.delegate.window.rootViewController = controller;
        
    }else{
        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:controller];
        app.delegate.window.rootViewController = navController;
        
    }
    [app.delegate.window makeKeyAndVisible];
}

+ (void)setupAppearance{
    [self setupNavigationbar];
    [self setupTableView];
    
    if (@available(iOS 11.0, *)) {
        UICollectionView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

    }
}

+ (void)setupNavigationbar{
    
    UINavigationBar * navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:kC_ThemeCOLOR];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:@{
                                            NSForegroundColorAttributeName  :   [UIColor whiteColor],
                                            
                                            }];

    //    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    //    [navigationBar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    if (iOS(11)) {
//        UIImage *origImage = [UIImage imageNamed:@"img_btnBack.png"];
//        //系统返回按钮处的title偏移到可视范围之外
//        //iOS11 和 iOS11以下分别处理
//        UIOffset offset = iOS(11) ? UIOffsetMake(-200, 0) : UIOffsetMake(0, -80);
//
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsDefault];
//        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:offset forBarMetrics:UIBarMetricsCompact];
//
//        [[UINavigationBar appearance] setBackIndicatorImage:origImage];
//        [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:origImage];
        
    }
    else{

    }
}

+ (void)setupTableView{
    if (@available(iOS 11.0, *)) {
        UITableView.appearance.estimatedRowHeight = 0.0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0.0;
        UITableView.appearance.estimatedSectionFooterHeight = 0.0;

    }
}

+ (void)setupIQKeyboardManager{
//    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
//    keyboardManager.enable = YES; // 控制整个功能是否启用
//    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
//    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
//    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
//    keyboardManager.enableAutoToolbar = NO; // 控制是否显示键盘上的工具条
//    keyboardManager.shouldShowToolbarPlaceholder = YES; // 是否显示占位文字
//    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:14]; // 设置占位文字的字体
//    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
}


+ (void)setupTabBarSelectedIndex:(NSUInteger)selectedIndex{
    UIViewController *rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if ([rootController isKindOfClass:[UITabBarController class]]) {
        ((UITabBarController *)rootController).selectedIndex = selectedIndex;
    }else{
        NSParameterAssert([rootController isKindOfClass:[UITabBarController class]]);
        
    }
    
}


@end
