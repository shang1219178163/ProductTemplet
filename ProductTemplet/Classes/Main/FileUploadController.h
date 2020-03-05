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

@interface FileUploadController : UIViewController<QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (nonatomic, copy) NSURL *fileUrl;

@property (nonatomic, assign) BOOL isUpload;

@end

NS_ASSUME_NONNULL_END
