//
//  UIApplication+Permission.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/9/10.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,PrivacyType) {
    PrivacyTypePhoto = 0,
    PrivacyTypeCamera,
    PrivacyTypeMedia,
    PrivacyTypeMicrophone,
    PrivacyTypeBluetooth,
    PrivacyTypePushNotification,
    PrivacyTypeSpeech,
    PrivacyTypeEvent,
    PrivacyTypeReminder,
    PrivacyTypeContact,

};

typedef NS_ENUM(NSUInteger,PrivacyStatus) {
    PrivacyStatusAuthorized = 0,
    PrivacyStatusDenied,
    PrivacyStatusNotDetermined,
    PrivacyStatusRestricted,
    PrivacyStatusUnkonwn,
};

@interface UIApplication (Permission)

+ (void)privacy:(PrivacyType)type completion:(nullable void(^)(BOOL response,PrivacyStatus status, NSString *name))completion;

+ (BOOL)privacy:(PrivacyType)type handler:(nullable void(^)(BOOL response, NSString *name))handler;

@end

NS_ASSUME_NONNULL_END
