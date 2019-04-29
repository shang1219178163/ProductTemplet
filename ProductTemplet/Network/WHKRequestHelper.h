//
//  WHKRequestHelper.h
//  
//
//  Created by BIN on 2017/8/9.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever 0
#define TestSever    1
#define ProductSever 0

/** 接口前缀-开发服务器*/
UIKIT_EXTERN NSString *const kApiPrefix;

#pragma mark - 详细接口地址
/** 登录*/
UIKIT_EXTERN NSString *const kLogin;
/** 平台会员退出*/
UIKIT_EXTERN NSString *const kExit;

//WHB
UIKIT_EXTERN NSString *const kHTTP_URLPreFix;
UIKIT_EXTERN NSString *const kHTTP_URLMiddle;


@interface WHKRequestHelper : NSObject

+ (NSString *)getInterfaceUrlWithMessageName:(NSString *)messageName;

+ (NSString *)getInterfaceUrlWithMessageNameAboutAppInfoDict:(NSDictionary *)infoDict;

//+ (NSString *)getInterfaceUrlWithMessageNameAboutAppInfo:(NSString *)messageName;

//+ (NSString *)getTokenRequest;

+ (NSString *)getInterfaceUrlWithParamDict:(NSDictionary *)paramDict;
//拼接车型图片
+ (NSString *)getImageUrlWithImageName:(NSString *)imageName;

@end
