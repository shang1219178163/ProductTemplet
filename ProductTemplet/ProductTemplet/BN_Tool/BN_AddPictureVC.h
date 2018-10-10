//
//  BN_AddPictureController.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/27.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreLocation/CoreLocation.h>

static NSString *const kPicture_maxCount =  @"kPicture_MaxCount";
static NSString *const kPicture_allowCrop =  @"kPicture_allowCrop";
static NSString *const kPicture_currentVC =  @"kPicture_currentVC";

@interface BN_AddPictureVC : UIViewController

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, copy) void(^blockView)(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSInteger maxCount);

+(instancetype)sharedInstance;

- (void)addPhotos;
- (void)goPhotoLibrary;
- (void)goTakePhoto;

- (void)addPhotosAttDict:(NSDictionary *)attDict handler:(void(^)(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto, NSInteger maxCount))handler;

@end
