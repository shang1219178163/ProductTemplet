//
//  NNRequstManager.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NNRequstManager;

typedef NS_ENUM (NSInteger, NNRequestType){
    NNRequestTypeGet,
    NNRequestTypePost,
    NNRequestTypeFormDataPost,
    NNRequestTypePut,
    NNRequestTypeDelete,
};

typedef NS_ENUM (NSInteger, NNRequestCode){
    NNRequestCodeSuccess        = 1,        //请求成功
    NNRequestCodeParamsError    = 100,      //参数错误，
    NNRequestCodeJSONError      = 101,      //JSON解析错误
    NNRequestCodeTimeout        = 102,      //请求超时
    NNRequestCodeNetworkError   = 103,      //网络错误，
    NNRequestCodeServerError    = 104,      //服务端返回非200的状态码
    NNRequestCodeCancel         = 105,      //取消网络请求
    NNRequestCodeNoLogin        = 106,      //未登录
    NNRequestCodeNotFound       = 107,      //服务器找不到给定的资源；文档不存在
    NNRequestCodeInvalidRequest = 108,      //无效请求
    NNRequestCodeInvalidToken   = 109,      //token失效
    NNRequestCodeUnknown        = 110,      //未知错误
};


@protocol NNRequestManagerProtocol <NSObject>

@required

/// URI
- (NSString *_Nonnull)requestURI;
/// 网络请求方式默认GET
- (NNRequestType)requestType;
/// 网络请求参数
- (NSDictionary *_Nullable)requestParams;
/// 网络请求参数验证
- (BOOL)validateParams;

@optional

/// 存储网络结果
- (BOOL)saveJsonOfCache:(NSDictionary *_Nullable)json;
/// 从缓存读取网络结果
- (NSDictionary *_Nullable)jsonFromCache;

- (BOOL)needLogin;

- (BOOL)printLog;

@end


@protocol NNRequestManagerResultDelegate <NSObject>

@required
- (void)managerAPISuccess:(NNRequstManager *_Nonnull)manager dic:(NSDictionary *_Nonnull)dic;
- (void)managerAPIFail:(NNRequstManager *_Nonnull)manager error:(NSError *_Nonnull)error;

@end

NS_ASSUME_NONNULL_BEGIN

/// 网络请求结果
typedef void(^NNRequestSuccessBlock)(NNRequstManager *manager, NSDictionary *jsonData);
typedef void(^NNRequestFailedBlock)(NNRequstManager *manager, NSError *error);


@interface NNRequstManager : NSObject

@property(nonatomic, weak) id<NNRequestManagerProtocol> child;
@property(nonatomic, weak) id<NNRequestManagerResultDelegate> delegate;
@property(nonatomic, copy) NNRequestSuccessBlock successBlock;
@property(nonatomic, copy) NNRequestFailedBlock failureBlock;

@property(nonatomic, assign, readonly) BOOL isLoading;

- (NSURLSessionTask *)requestWithSuccess:(NNRequestSuccessBlock)successBlock fail:(NNRequestFailedBlock)failureBlock;

- (void)cancelAllRequest;

@end

NS_ASSUME_NONNULL_END
