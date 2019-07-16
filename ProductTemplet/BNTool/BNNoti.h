//
//  BNNoti.h
//  Location
//
//  Created by BIN on 2017/12/22.
//  Copyright © 2017年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>

#define kNoti_isRemote   @"kNoti_isRemote"

//#define kLocation_latitude   @"kLocation_latitude"
//#define kLocation_longitude  @"kLocation_longitude"
//#define kLocation_accuracy   @"kLocation_accuracy"
//#define kLocation_timeStamp  @"kLocation_timeStamp"

#define kNoti_location_UploadCoordinate @"kNoti_location_UploadCoordinate"

@interface BNNoti : NSObject

+ (instancetype)shared;

@property (nonatomic, copy) void (^NotiHandler)(NSString * notiName, NSNotification *noti);

- (void)addObserverNotiName:(NSString *)name object:(id)object handler:(void (^)(NSString * notiName, NSNotification *noti))handler;

- (void)removeNotiName:(NSString *)notiName;

+ (void)registerPushType;

- (void)addLocalizedUserNotiTrigger:(id)trigger content:(UNMutableNotificationContent *)content identifier:(NSString *)identifier notiCategories:(id)notiCategories handler:(void(^)(UNUserNotificationCenter* center, UNNotificationRequest *request,NSError * _Nullable error))handler;

@end
