//
//  APIRequestURL.h
//  AccessControlSystem
//
//  Created by Bin Shang on 2019/5/22.
//  Copyright © 2019 irain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIRequestURL : NSObject

UIKIT_EXTERN NSString * const kAPIRequestURLLogin;

UIKIT_EXTERN NSString * const kAPIRequestURLLogout;

UIKIT_EXTERN NSString * const kAPIRequestURLUserInfo;

UIKIT_EXTERN NSString * const kAPIRequestURLModifyPwd;

UIKIT_EXTERN NSString * const kAPIRequestURLServerinfo;

UIKIT_EXTERN NSString * const kAPIRequestURLRestart;

UIKIT_EXTERN NSString * const kAPIRequestURLDeviceList;

//UIKIT_EXTERN NSString * const kAPIRequestURLChannels;
NSString * const APIRequestURLChannels(NSString *ID);

//UIKIT_EXTERN NSString * const kAPIRequestURLChannelstream;
NSString * const APIRequestURLChannelstream(NSString *ID);

NSString * const APIRequestURLTouchcChannelstream(NSString *ID);

+ (void)requestUrl:(NSString *)url method:(NSString *)method completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler;

//+ (NSString *)cookieDesWithToken:(NSString *)token tokenTimeout:(NSNumber *)tokenTimeout;

@end

NS_ASSUME_NONNULL_END
