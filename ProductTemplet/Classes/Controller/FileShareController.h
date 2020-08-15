//
//  FileShareController.h
//  NNFileShare
//
//  Created by hsf on 2018/9/13.
//  Copyright © 2018年 Sera. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuickLook/QuickLook.h>

@interface FileShareController : UIViewController<UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource, QLPreviewControllerDelegate>

@property (nonatomic, copy) NSURL *url;
@property (nonatomic, copy) NSDictionary *dict;

@property (nonatomic, copy) void(^block)(UIApplication *app,NSURL *url, NSDictionary *dict);

@end
