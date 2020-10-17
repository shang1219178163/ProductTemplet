//
//  UIApplication+Permission.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/9/10.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIApplication+Permission.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <EventKit/EventKit.h>
#import <Contacts/Contacts.h>
#import <Speech/Speech.h>
#import <HealthKit/HealthKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <UserNotifications/UserNotifications.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import <HealthKit/HealthKit.h>

@implementation UIApplication (Permission)

static NSDictionary *_dictPrivacy = nil;

+ (NSDictionary *)dictPrivacy{
    if (!_dictPrivacy) {
        _dictPrivacy = @{@0 : @"相册",
                         @1 : @"相机",
                         @2 : @"媒体资料库",
                         @3 : @"麦克风",
                         @4 : @"蓝牙",
                         @5 : @"推送",
                         @6 : @"语音识别",
                         @7 : @"日历",
                         @8 : @"提醒事项",
                         @9 : @"通讯录",
                         @10 : @"健康",

                         };
    }
    return _dictPrivacy;
}

+ (void)privacy:(PrivacyType)type completion:(void(^)(BOOL response,PrivacyStatus status, NSString *name))completion{
    NSParameterAssert(completion != nil);
    switch (type) {
        case PrivacyTypePhoto: {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else if (status == PHAuthorizationStatusDenied) {
                    completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                }
                else if (status == PHAuthorizationStatusNotDetermined) {
                    completion(NO, PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                }
                else if (status == PHAuthorizationStatusRestricted) {
                    completion(NO, PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    completion(NO, PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                }
            }];
        }
            break;
        case PrivacyTypeCamera: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (granted) {
                    completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == AVAuthorizationStatusAuthorized) {
                        completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusDenied) {
                        completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(NO, PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusRestricted) {
                        completion(NO, PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO, PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        case PrivacyTypeMedia: {
            if (@available(iOS 9.3, *)) {
                [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                    if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                        completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == MPMediaLibraryAuthorizationStatusDenied) {
                        completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == MPMediaLibraryAuthorizationStatusNotDetermined) {
                        completion(NO, PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == MPMediaLibraryAuthorizationStatusRestricted) {
                        completion(NO, PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO, PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }];
            } else {
                // Fallback on earlier versions
                //虽然没有查看是否开启权限的接口，但是还是需要在Info.plist中添加说明。
            }
        }
            break;
        case PrivacyTypeMicrophone: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                if (granted) {
                    completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == AVAuthorizationStatusAuthorized) {
                        completion(YES,PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusDenied) {
                        completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusNotDetermined) {
                        completion(NO, PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == AVAuthorizationStatusRestricted) {
                        completion(NO, PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO, PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        case PrivacyTypeBluetooth: {
            if (@available(iOS 10.0, *)) {
                CBCentralManager *centralManager = [[CBCentralManager alloc] init];
                CBManagerState state = [centralManager state];
                if (state == CBManagerStateUnsupported || state == CBManagerStateUnauthorized || state == CBManagerStateUnknown) {
                    completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
            } else {
                // Fallback on earlier versions

            }

        }break;

        case PrivacyTypePushNotification: {
            if (@available(iOS 10.0, *)) {
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                UNAuthorizationOptions types = UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
                [center requestAuthorizationWithOptions:types completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (granted) {
                        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                            completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                        }];
                    } else {
                        [UIApplication.sharedApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@""} completionHandler:^(BOOL success) { }];
                    }
                }];
            } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
                UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge;
                [UIApplication.sharedApplication registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:types categories:nil]];
            }
#pragma clang diagnostic pop
        }break;

        case PrivacyTypeSpeech: {
            if (@available(iOS 10.0, *)) {
                [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
                    if (status == SFSpeechRecognizerAuthorizationStatusAuthorized) {
                        completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == SFSpeechRecognizerAuthorizationStatusDenied) {
                        completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == SFSpeechRecognizerAuthorizationStatusNotDetermined) {
                        completion(NO, PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == SFSpeechRecognizerAuthorizationStatusRestricted) {
                        completion(NO, PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO, PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }];
            } else {
                // Fallback on earlier versions
                //不支持
            }
        }
            break;
        case PrivacyTypeEvent: {
            EKEventStore *store = [[EKEventStore alloc] init];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == EKAuthorizationStatusAuthorized) {
                        completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusDenied) {
                        completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusNotDetermined) {
                        completion(NO, PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusRestricted) {
                        completion(NO, PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else {
                        completion(NO, PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        case PrivacyTypeReminder: {
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
                if (granted) {
                    completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == EKAuthorizationStatusAuthorized) {
                        completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusDenied) {
                        completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusNotDetermined){
                        completion(NO, PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == EKAuthorizationStatusRestricted){
                        completion(NO, PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else{
                        completion(NO, PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        case PrivacyTypeContact: {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                if (granted) {
                    completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                }
                else {
                    if (status == EKAuthorizationStatusAuthorized) {
                        completion(YES, PrivacyStatusAuthorized, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == CNAuthorizationStatusDenied) {
                        completion(NO, PrivacyStatusDenied, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == CNAuthorizationStatusRestricted){
                        completion(NO, PrivacyStatusNotDetermined, UIApplication.dictPrivacy[@(type)]);
                    }
                    else if (status == CNAuthorizationStatusNotDetermined){
                        completion(NO, PrivacyStatusRestricted, UIApplication.dictPrivacy[@(type)]);
                    }
                    else{
                        completion(NO, PrivacyStatusUnkonwn, UIApplication.dictPrivacy[@(type)]);
                    }
                }
            }];
        }
            break;
        default:
            break;
    }
}

+ (BOOL)privacy:(PrivacyType)type handler:(void(^)(BOOL response, NSString *name))handler{
    __block BOOL isHasRight = NO;
    [UIApplication privacy:type completion:^(BOOL response, PrivacyStatus status, NSString *name) {
        isHasRight = response;
        if(handler) handler(response,name);

        switch (status) {
            case PrivacyStatusAuthorized:
            {
                //通过
            }
                break;
            case PrivacyStatusDenied:
            case PrivacyStatusNotDetermined:
            case PrivacyStatusRestricted:
            case PrivacyStatusUnkonwn:
            {
                NSString *msg = [NSString stringWithFormat:@"请去-> [设置 - 隐私 - %@ - %@] 打开访问开关", UIApplication.dictPrivacy[@(type)], UIApplication.appName];
                [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert]
                .nn_present(true, nil);
            }
                break;
            default:
                break;
        }
    }];
    return isHasRight;
}

+ (BOOL)hasRightOfPhotosLibrary{
    return [UIApplication privacy:PrivacyTypePhoto handler:nil];
}

+ (BOOL)hasRightOfCameraUsage{
    //相机权限
    return [UIApplication privacy:PrivacyTypeCamera handler:nil];
}


@end
