//
//  BNNetWorkAgent.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BNURLResponse.h"
#import "BNUploadModel.h"

typedef void(^BNNetworkBlock) (BNURLResponse * _Nonnull response);
typedef void(^BNProgressBlock)(NSProgress * _Nonnull progress);

NS_ASSUME_NONNULL_BEGIN

@interface BNRequstAgent : NSObject

+ (instancetype)shared;

/**
 GET 请求
 */
- (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(BNNetworkBlock)success
                  failure:(BNNetworkBlock)failure;
/**
 POST 请求
 */
- (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(BNNetworkBlock)success
                   failure:(BNNetworkBlock)failure;

/**
 [POST源方法]支持上传多张图片
 @param images 图片数组
 @param fileNames 图片名称数组
 @param progress 进度条代码块
 */
- (NSURLSessionTask *)postWithURL:(NSString *)URL
                       parameters:(id)parameters
                           images:(NSArray<UIImage *> * _Nullable )images
                        fileNames:(NSArray<NSString *> *_Nullable)fileNames
                         progress:(BNProgressBlock _Nullable)progress
                          success:(BNNetworkBlock)success
                          failure:(BNNetworkBlock)failure;

- (void)cancelRequestWithID:(NSInteger)requestID;
- (void)cancelRequestWithIDList:(NSArray *)requestIDs;
- (void)cancelAllRequest;


@end

NS_ASSUME_NONNULL_END
