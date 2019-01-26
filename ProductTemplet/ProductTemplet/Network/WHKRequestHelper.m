//
//  WHKRequestHelper.m
//  
//
//  Created by BIN on 2017/8/9.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "WHKRequestHelper.h"

#import "BN_Globle.h"
#import "NSObject+Helper.h"
#import "NSString+Helper.h"

#import "NSDate+Helper.h"
#import "UIDevice+FCUUID.h"

NSString *const kHTTP_URLMiddle = @"i=42&c=entry&do=fengmian&m=android&source=ios";//通用参数

//#define KIOS_TESTSERVER //测试服务器
#ifndef KIOS_TESTSERVER //正式服务器

//HTML
#define kHTTP_URLPreFix_HTML  @"https://www..com/app"
//通用
#define kHTTP_URLPreFix  @"https://www..com/app"
//图片前缀
#define kIMG_URLPrefix  @"https://www..com/attachment/"

#else

//HTML
#define kHTTP_URLPreFix_HTML  @"http://192.168.0.149//app"
//通用
#define kHTTP_URLPreFix  @"http://192.168.0.149//app"

//图片前缀
#define kIMG_URLPrefix  @"http://192.168.0.149//attachment/"

#endif

@implementation WHKRequestHelper

/** 还有参数uuid token
 获取业务接口地址+参数
 */
+ (NSString *)getInterfaceUrlWithMessageName:(NSString *)messageName{
    
    messageName = [messageName stringByReplacingOccurrencesOfString:@"" withString:@" "];
    
    NSString * domain = [NSString stringWithFormat:@"%@",kHTTP_URLPreFix];
    NSString * allAddresss = [domain stringByAppendingFormat:@"/index.php?"];
    
    allAddresss = [allAddresss stringByAppendingFormat:@"%@",kHTTP_URLMiddle];
    allAddresss = [allAddresss stringByAppendingFormat:@"&r=%@",messageName];

    //imei
    NSString * imei = UIDevice.currentDevice.uuid;
    allAddresss = [allAddresss stringByAppendingFormat:@"&imei=%@",imei];
    allAddresss = [allAddresss stringByAppendingFormat:@"&platform=%@",@"ios"];

    //token
    NSString * tokenRequest = [WHKRequestHelper getTokenRequestMessageName:[NSString stringWithFormat:@"r=%@",messageName]];
    allAddresss = [allAddresss stringByAppendingFormat:@"&psw=%@",tokenRequest];
    
    //userID
//    WHKNetInfoCheckLoginModel *userModel = [BN_FileHandler UnarchiveObjectFilName:kAir_UserModel];
//    WHKNetHogpenInfoModel * factoryModel = [BN_FileHandler UnarchiveObjectFilName:kAir_FacoryModel];
//    allAddresss = [allAddresss stringByAppendingFormat:@"&uid=%@",userModel.uid];
//    allAddresss = [allAddresss stringByAppendingFormat:@"&uniacid=%@",factoryModel.uniacid];
    
    return allAddresss;
}

+ (NSString *)getInterfaceUrlWithMessageNameAboutAppInfoDict:(NSDictionary *)infoDict{
    
    NSString * urlString = @"http://www.weihouyunbao.cn/app/index.php?i=3&c=entry&do=goods&m=nonghuotongweihou&source=1";
//    NSString * domain = [NSString stringWithFormat:@"%@/index.php?i=3&c=entry&do=goods&m=nonghuotongweihou&source=1",kHTTP_URLPreFix_HTML];

    for (NSString * key in infoDict.allKeys) {
        urlString = [urlString stringByAppendingFormat:@"&%@=%@",key,infoDict[key]];
        
    }
    
    //token
    return urlString;
}

+ (NSString *)getTokenRequestMessageName:(NSString *)messageName{
    //
    NSDate * now = NSDate.date;
    NSString * dateStr = [NSDateFormatter stringFromDate:now format:@"yyyyMMdd"];
    NSString * string = [dateStr stringByAppendingFormat:@"%@",messageName];
    NSString * md5String = [string md5Encode];
    
    md5String = [md5String lowercaseString];
//    DDLog(@"md5String__原始\n%@",md5String);

    NSDateComponents *components = [now components];
//    DDLog(@"components__%@",components);
    //和后台保持一致必须减一
    NSInteger day = components.weekday - 1;
    if (day == 2 || day == 4 || day == 6) {
        md5String = [md5String stringByReplacingCharacterIndex:2 withString:@"*"];
        md5String = [md5String stringByReplacingCharacterIndex:4 withString:@"*"];
        md5String = [md5String stringByReplacingCharacterIndex:16 withString:@"*"];
        
    } else {
        md5String = [md5String stringByReplacingCharacterIndex:3 withString:@"*"];
        md5String = [md5String stringByReplacingCharacterIndex:6 withString:@"*"];
        md5String = [md5String stringByReplacingCharacterIndex:18 withString:@"*"];
        
    }
//    DDLog(@"md5String__替换\n%@",md5String);
    return md5String;
}


+ (NSString *)getInterfaceUrlWithParamDict:(NSDictionary *)paramDict{
    
    //    http://www.weihouyunbao.cn:9999/app/index.php?i=3&c=entry&do=goods&m=nonghuotongweihou&r=api.user.sendCode&&r=api.user.sendCode&phone=123456789663
    //    NSDictionary * dicDomain = [NSDictionary dictionaryWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"InterfaceDomain" ofType:@"plist"]];
    NSString * domain = [NSString stringWithFormat:@"%@",kHTTP_URLPreFix];
    NSString * allAddresss = [domain stringByAppendingFormat:@"/index.php?"];
    
    allAddresss = [allAddresss stringByAppendingFormat:@"%@",kHTTP_URLMiddle];
    
    NSString * jsonString = @"";
    
    NSString * rKey = @"r";   //r=api.user.sendCode暂时不支持加密
    if (paramDict != nil) {
        //获取参数
        NSArray *keyArr = [paramDict allKeys];
        //r=api.user.sendCode暂时不支持加密
        if (![keyArr containsObject:rKey]) {
            NSAssert(![keyArr containsObject:rKey], @"messageName不能为空!");
            
        } else {
//            allAddresss = [allAddresss stringByAppendingFormat:@"%@%@%@%@",@"&",rKey,@"=",[Utilities encodeTheString:paramDict[rKey]]];
            
        }
        
        //遍历参数
        NSMutableDictionary * mDict = [NSMutableDictionary dictionaryWithDictionary:paramDict];
        [mDict removeObjectForKey:rKey];
        
        jsonString = [mDict JSONValue];
        DDLog(@"parameters_加密前_\%@",jsonString);
//        jsonString = [Utilities AESEncryptTheString:jsonString];//加密
//        DDLog(@"parameters_加密后_\%@",jsonString);
//        jsonString = [Utilities AESDencryptTheString:jsonString];
//        DDLog(@"parameters_解密后_\%@",jsonString);
        
        allAddresss = [allAddresss stringByAppendingFormat:@"&"];//需要用&把加密部分分隔开
        allAddresss = [allAddresss stringByAppendingFormat:@"%@",jsonString.description];
        
    }
    
    DDLog(@"allAddresss_\n%@",allAddresss);
    return allAddresss;
}

//拼接图片
+ (NSString *)getImageUrlWithImageName:(NSString *)imageName{
    if ([imageName containsString:kIMG_URLPrefix]) {
        return imageName;
    }
    NSString * domain = [NSString stringWithFormat:@"%@",kIMG_URLPrefix];
    NSString * allAddresss = [domain stringByAppendingFormat:@"%@",imageName];
    
    return allAddresss;
}

@end
