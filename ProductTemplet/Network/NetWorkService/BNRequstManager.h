//
//  BNRequstManager.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRequstManager;

typedef NS_ENUM (NSInteger, BNRequestType){
    BNRequestTypeGet,
    BNRequestTypePost,
    BNRequestTypePut,
    BNRequestTypeDelete,
};

typedef NS_ENUM (NSInteger, BNRequestCode){
    BNRequestCodeSuccess        = 1,        //请求成功
    BNRequestCodeParamsError    = 100,      //参数错误，
    BNRequestCodeJSONError      = 101,      //JSON解析错误
    BNRequestCodeTimeout        = 102,      //请求超时
    BNRequestCodeNetworkError   = 103,      //网络错误，
    BNRequestCodeServerError    = 104,      //服务端返回非200的状态码
    BNRequestCodeCancel         = 105,      //取消网络请求
    BNRequestCodeNoLogin        = 106,      //未登录
    BNRequestCodeNotFound       = 107,      //服务器找不到给定的资源；文档不存在
    BNRequestCodeInvalidRequest = 108,      //无效请求
    BNRequestCodeInvalidToken   = 109,      //token失效
    BNRequestCodeUnknown        = 110,      //未知错误
};


@protocol BNRequestManagerProtocol <NSObject>

@required

/// URI
- (NSString *_Nonnull)requestURI;
/// 网络请求方式默认GET
- (BNRequestType)requestType;
/// 网络请求参数
- (NSDictionary *_Nullable)requestParams;
/// 网络请求参数验证
- (BOOL)validateParams;

@optional

/// 存储网络结果
- (BOOL)saveJsonOfCache:(NSDictionary *_Nullable)json;
/// 从缓存读取网络结果
- (NSDictionary *_Nullable)jsonFromCache;

@end


@protocol BNRequestManagerResultDelegate <NSObject>

@required
- (void)manager:(BNRequstManager *_Nonnull)manager successDic:(NSDictionary *_Nullable)dic failError:(NSError *_Nullable)error;

@end

NS_ASSUME_NONNULL_BEGIN

/// 网络请求结果
typedef void(^BNRequestBlock)(BNRequstManager *manager, id _Nullable responseObject, NSError *_Nullable error);

@interface BNRequstManager : NSObject

@property(nonatomic, weak) id<BNRequestManagerProtocol> child;
@property(nonatomic, weak) id<BNRequestManagerResultDelegate> delegate;
@property(nonatomic, copy) BNRequestBlock successBlock;
@property(nonatomic, copy) BNRequestBlock failureBlock;
@property(nonatomic, copy) BNRequestBlock requestBlock;

@property(nonatomic, assign, readonly) BOOL isLoading;

- (NSURLSessionTask *)requestWithSuccessBlock:(BNRequestBlock)successBlock failedBlock:(BNRequestBlock)failureBlock;

- (NSURLSessionTask *)requestWithBlock:(BNRequestBlock)block;

- (void)cancelAllRequest;

@end

NS_ASSUME_NONNULL_END
