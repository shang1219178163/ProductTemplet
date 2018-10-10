//
//  AddPicturesVC.h
//  HuiZhuBang
//
//  Created by BIN on 2017/12/1.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//
/**
 添加图片功能可以继承此类(不满足需求的可重建一类在此基础上修改即可)
 */


#import <UIKit/UIKit.h>

#import <Photos/Photos.h>
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "TZLocationManager.h"

#import "Utilities_DM.h"

static const NSInteger kRowCount_imageView = 4;

@interface AddPicturesVC : UIViewController<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImage * imageDefault;
@property (nonatomic, assign) CGFloat imgWH;

@property (nonatomic, strong) UIView * photoContainView;

@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, assign) NSInteger photoMaxCount;

@property (nonatomic, assign) BOOL allowCropImage;
@property (nonatomic, strong) UIImagePickerController *imagePickerVC;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, strong) NSMutableArray *photoMarr;

//去其他页面时清除数据用(all)
- (void)cleanImagesDataAll;

- (void)addPhotos;

- (void)goPhotosAdd;

- (void)goPhotosDelete:(UIButton *)sender;

- (UIView *)loadContainView:(UIView *)backgroudView;

- (void)goPhotoLibrary;

- (void)goTakePhoto;

@end
