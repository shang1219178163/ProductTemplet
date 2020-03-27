//
//  FileUploadController.h
//  ProductTemplet
//
//  Created by Bin Shang on 2020/3/2.
//  Copyright © 2020 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuickLook/QuickLook.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNFileUploadController : UIViewController<QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (class, nonatomic, strong) NSArray *docTypes;

@property (nonatomic, copy) NSURL *localFileUrl;

@property (nonatomic, assign) BOOL isUpload;

@end

NS_ASSUME_NONNULL_END
