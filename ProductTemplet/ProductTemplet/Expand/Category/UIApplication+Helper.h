//
//  UIApplication+Helper.h
//  HuiZhuBang
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

//#import <JPUSHService.h>
//#import <AdSupport/AdSupport.h>

#define kJPushKey_type          @"into_page_type"
#define kJPushKey_extras        @"extras"

@interface UIApplication (Helper)

+(UIWindow *)keyWindow;
+(UIViewController *)rootVC;

+(NSString *)app_Name;
+(NSString *)app_Icon;
+(NSString *)app_Version;
+(NSString *)app_build;
+(NSString *)phone_SystemVersion;
+(NSString *)phone_SystemName;
+(NSString *)phone_Name;
+(NSString *)phone_Model;
+(NSString *)phone_localizedModel;

+ (void)setupRootController:(id)controller;

+ (void)setupAppearance;

+ (void)setupNavigationbar;

+ (void)setupIQKeyboardManager;

+ (void)registerUMengSDKAppKey:(NSString *)appKey channel:(NSString *)channel;

/**
 * 初始化JPushSDK
 */
//+ (void)registerJPushSDKAppKey:(NSString *)appKey channel:(NSString *)channel isProduction:(BOOL)isProduction options:(NSDictionary *)launchOptions;

+ (void)setupTabBarSelectedIndex:(NSUInteger)selectedIndex;

@end
