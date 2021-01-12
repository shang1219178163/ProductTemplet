//
//  BNNetWorkAgent.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "AFNetworkActivityIndicatorManager.h"

#import "NNURLResponse.h"
#import "NNUploadModel.h"

typedef void(^NNNetworkBlock) (NNURLResponse * _Nonnull response);
typedef void(^NNProgressBlock)(NSProgress * _Nonnull progress);

NS_ASSUME_NONNULL_BEGIN

/// <#Description#>
@interface NNRequstAgent : NSObject

+ (instancetype)shared;

@property (nonatomic, strong, readonly) AFHTTPSessionManager *sessionManager;

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;

/**
 GET 请求
 */
- (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(NNNetworkBlock)success
                  failure:(NNNetworkBlock)failure;
/**
 POST 请求
 */
- (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(NNNetworkBlock)success
                   failure:(NNNetworkBlock)failure;

/**
 [POST源方法]支持上传多张图片
 @param progress 进度条代码块
 */
- (NSURLSessionTask *)Upload:(NSString *)URL
                         parameters:(NSDictionary *)parameters
                           progress:(NNProgressBlock _Nullable)progress
                            success:(NNNetworkBlock)success
                            failure:(NNNetworkBlock)failure;

/**
 PUT请求
 */
- (NSURLSessionTask *)PUT:(NSString *)URL
               parameters:(id)parameters
                  success:(NNNetworkBlock)success
                  failure:(NNNetworkBlock)failure;

/**
 Delete请求
 */
- (NSURLSessionTask *)DELETE:(NSString *)URL
                  parameters:(id)parameters
                     success:(NNNetworkBlock)success
                     failure:(NNNetworkBlock)failure;

- (void)cancelRequestWithID:(NSInteger)requestID;
- (void)cancelRequestWithIDList:(NSArray *)requestIDs;
- (void)cancelAllRequest;


@end

NS_ASSUME_NONNULL_END
