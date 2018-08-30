//
//  UIApplication+Share.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "UIApplication+Share.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
//#import “WeiboSDK.h”
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”

#import "NSObject+Helper.h"

#import "Globle_Key.h"

@implementation UIApplication (Share)

+ (void)registerShareSDK{
    /**初始化ShareSDK应用
     @param activePlatforms
     使用的分享平台集合
     @param importHandler (onImport)
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     @param configurationHandler (onConfiguration)
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     */
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeQQ),
                                        @(SSDKPlatformTypeWechat),
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:kAppID_QQ
                                      appKey:kAppKey_QQ
                                    authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:kAppID_WX
                                       appSecret:kAppKey_WX];
                 break;
             default:
                 break;
         }
     }];

}

+ (void)handleMsgShareDataModel:(BINShareDataModel *)dataModel patternType:(NSString *)patternType{
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:dataModel.shareContent
                                     images:dataModel.shareImages //传入要分享的图片
                                        url:[NSURL URLWithString:dataModel.shareUrl]
                                      title:dataModel.shareTitle
                                       type:SSDKContentTypeAuto];
    
    SSDKPlatformType thePlatformType = SSDKPlatformSubTypeQZone;
    switch ([patternType integerValue]) {
        case 0:
        {
            thePlatformType = SSDKPlatformSubTypeQZone;
        }
            break;
        case 1:
        {
            thePlatformType = SSDKPlatformSubTypeWechatSession;
            
        }
            break;
        case 2:
        {
            thePlatformType = SSDKPlatformSubTypeWechatTimeline;
            
        }
            break;
        case 3:
        {
            thePlatformType = SSDKPlatformSubTypeQQFriend;
            
        }
            break;
        default:
            break;
    }
    
    //进行分享
    [ShareSDK share:thePlatformType//传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { /* 回调处理....*/
         
         DDLog(@"error_%ld",(NSInteger)state);
         
         NSString * tipMsg = @"";
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 tipMsg = @"分享成功";
                 DDLog(@"分享成功!");
                 
             }
                 break;
             case SSDKResponseStateFail:
             {
                 tipMsg = @"分享失败";
                 DDLog(@"分享失败%@",error);
             }
                 break;
             case SSDKResponseStateCancel:
             {
                 tipMsg = @"分享已取消";
                 DDLog(@"分享已取消");
             }
                 break;
             default:
                 break;
         }
         
         UIAlertController * alertCtl = [UIAlertController alertControllerWithTitle:tipMsg message:nil  preferredStyle:UIAlertControllerStyleAlert];
         [alertCtl addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             
         }]];
         [self.rootVC presentViewController:alertCtl animated:YES completion:nil];
     }];
    
}


@end
