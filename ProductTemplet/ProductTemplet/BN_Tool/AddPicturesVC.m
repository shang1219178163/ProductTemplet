//
//  AddPicturesVC.m
//  HuiZhuBang
//
//  Created by BIN on 2017/12/1.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "AddPicturesVC.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"

@interface AddPicturesVC ()


@end

@implementation AddPicturesVC

-(UIImage *)imageDefault{
    if (!_imageDefault) {
        _imageDefault = [UIImage imageNamed:kIMAGE_defaultAddPhoto];

    }
    return _imageDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.photoMaxCount = 4;
    
    
    self.photoContainView = [self loadContainView:nil];
    
//    self.photoContainView.layer.borderColor = UIColor.blueColor.CGColor;
//    self.photoContainView.layer.borderWidth = 1;
    
    [self.view addSubview:self.photoContainView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - - 拍照与相册
//此方法在子类执行
- (void)cleanImagesDataAll{
//    [self.selectedPhotos removeAllObjects];
//    [self.selectedAssets removeAllObjects];
    
}

- (void)addPhotos{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拍照不会调用viewWillDisappear方法所以此处清除数据
        [self cleanImagesDataAll];
        
        [self goTakePhoto];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cleanImagesDataAll];//待优化

        [self goPhotoLibrary];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
//添加图片
- (void)goPhotosAdd{
    [self loadContainView:self.photoContainView];

}
//删除图片
- (void)goPhotosDelete:(UIButton *)sender{
    NSUInteger index = [sender.titleLabel.text integerValue];
    if (index < self.selectedPhotos.count) [self.selectedPhotos removeObjectAtIndex:index];
    if (index < self.selectedAssets.count) [self.selectedAssets removeObjectAtIndex:index];
    
    [self loadContainView:self.photoContainView];

}

//更新UI方法
- (UIView *)loadContainView:(UIView *)backgroudView{
    if (backgroudView == nil) {
        backgroudView = [[UIView alloc]initWithFrame:CGRectMake(kX_GAP, kY_GAP ,kScreen_width - kX_GAP*2, 60)];
    }
    else{
        for (UIImageView * view in backgroudView.subviews) {
            [view removeFromSuperview];
        }
    }

    NSMutableArray * array = [NSMutableArray arrayWithArray:self.selectedPhotos];
    if (array.count < self.photoMaxCount && ![array containsObject:self.imageDefault]) [array addObject:self.imageDefault];
    DDLog(@"photo___%ld->%ld->%ld->%ld",backgroudView.subviews.count,array.count,self.selectedPhotos.count,self.selectedAssets.count);


    CGSize imgViewSize = CGSizeMake(60, 60);
    CGFloat imgViewPadding = (CGRectGetWidth(backgroudView.frame) - (imgViewSize.width * kRowCount_imageView))/(kRowCount_imageView + 1);
    //    CGFloat rowHeight = imgViewSize.height + imgViewPadding * 2;
    for (NSInteger i = 0; i < array.count; i++) {
        CGFloat x = imgViewPadding + (imgViewSize.width + imgViewPadding)*i;
        CGRect rect = CGRectMake(x, 0, imgViewSize.width, imgViewSize.height);
        UIImageView * imgView = [UIView createImageViewWithRect:rect image:array[i] tag:kTAG_IMGVIEW+i patternType:@"0" hasDeleteBtn:NO];
        [backgroudView addSubview:imgView];
        
        [imgView addActionHandler:^(id obj, id item, NSInteger idx) {
            if ([Utilities_DM imageOne:imgView.image equelToImageTwo:kIMAGE_defaultAddPhoto]) {
                [self addPhotos];
                
            }else{
                //点击查看大图
                
            }
        }];
        UIButton * btn = [imgView viewWithTag:kTAG_BTN];
        [btn addTarget:self action:@selector(goPhotosDelete:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.text = [NSString stringWithFormat:@"%@",@(i)];
        
        if ([Utilities_DM imageOne:array[i] equelToImageTwo:kIMAGE_defaultAddPhoto]) {
            btn.hidden = YES;
        }else{
            btn.hidden = NO;
        }
    }
    
//    [backgroudView getViewLayer];
    self.photoContainView = backgroudView;
    return backgroudView;
}

//去相册(第一步)
- (void)goPhotoLibrary{
    if ([Utilities_DM hasAccessRightOfCameraUsage]) {
        [self pushTZImagePickerController];
        
    }else{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 无权限 引导去开启
            UIApplication * application = [UIApplication sharedApplication];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([application canOpenURL:url]) [application openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}
//去拍照(第一步)
- (void)goTakePhoto{
    
    if ([Utilities_DM hasAccessRightOfCameraUsage]) {
        [self pushImagePickerController];
        
    }else{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"无法访问相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // 无权限 引导去开启
            UIApplication * application = [UIApplication sharedApplication];
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([application canOpenURL:url]) [application openURL:url options:@{UIApplicationOpenURLOptionUniversalLinksOnly : @YES} completionHandler:nil];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}
//去相册(第二步)
- (void)pushTZImagePickerController {
    if (self.photoMaxCount <= 0) {
        NSAssert(self.photoMaxCount > 0, @"图片选择数量不能为0");
        return;
    }
    TZImagePickerController *pickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:self.photoMaxCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    if (self.photoMaxCount > 1) {
        // 1.设置目前已经选中的图片数组
        pickerVC.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    }
    pickerVC.allowPickingOriginalPhoto = NO;
    pickerVC.allowPickingMultipleVideo = NO;
    pickerVC.isSelectOriginalPhoto = NO;
    pickerVC.sortAscendingByModificationDate = YES;
    
    pickerVC.allowPickingVideo = NO;
    pickerVC.allowPickingGif = NO;
    pickerVC.allowTakePicture = NO; // 在内部显示拍照按钮
    pickerVC.statusBarStyle = UIStatusBarStyleDefault;
    
    [pickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
        self.selectedAssets = [NSMutableArray arrayWithArray:assets];
        [self goPhotosAdd];
        
    }];
    [self presentViewController:pickerVC animated:YES completion:nil];
}
//去拍照(第二步)
- (void)pushImagePickerController {
    // 提前定位
    __weak typeof(self) weakSelf = self;
    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
        weakSelf.location = [locations firstObject];

    } failureBlock:^(NSError *error) {
        weakSelf.location = nil;

    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVC.sourceType = sourceType;
        self.imagePickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:self.imagePickerVC animated:YES completion:nil];
    } else {
        DDLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
//去拍照(第三步)
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = YES;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image location:self.location completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                DDLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES needFetchAssets:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        [self.selectedAssets addObject:assetModel.asset];
                        [self.selectedPhotos addObject:image];
                        
                        [self goPhotosAdd];
                        
//                        if (self.allowCropImage) { // 允许裁剪,去裁剪
//                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
//
//                            }];
//                            imagePicker.needCircleCrop = NO;
//                            imagePicker.circleCropRadius = 100;
//                            [self presentViewController:imagePicker animated:YES completion:nil];
//                        } else {
//                            [_selectedAssets addObject:assetModel.asset];
//                            [_selectedPhotos addObject:image];
//
//                            [self updatePhotosUI];
//                        }
                    }];
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

-(UIImagePickerController *)imagePickerVC{
    if (!_imagePickerVC) {
        _imagePickerVC = [[UIImagePickerController alloc] init];
        _imagePickerVC.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVC.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVC.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOSVersion(9)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVC;
}

#pragma mark - - layz
-(NSMutableArray *)selectedPhotos{
    if (!_selectedPhotos) {
        _selectedPhotos = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _selectedPhotos;
}

-(NSMutableArray *)selectedAssets{
    if (!_selectedAssets) {
        _selectedAssets = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _selectedAssets;
}

-(NSMutableArray *)photoMarr{
    if (!_photoMarr) {
        _photoMarr = [NSMutableArray arrayWithCapacity:0];
        
    }
    return _photoMarr;
}


@end
