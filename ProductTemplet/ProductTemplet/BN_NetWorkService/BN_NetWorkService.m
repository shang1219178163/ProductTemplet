//
//  BN_NetWorkService.m
//  HuiZhuBang
//
//  Created by hsf on 2018/9/3.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_NetWorkService.h"


@implementation BN_NetWorkService

/**
 *  GET请求,
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(BN_RequestCache)responseCache
                  success:(BN_RequestSuccess)success
                  failure:(BN_RequestFailed)failure{
    
    return [BN_NetWorkTool GET:URL parameters:parameters responseCache:responseCache success:^(id responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    
}

/**
 *  POST请求,无缓存
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(BN_RequestCache)responseCache
                   success:(BN_RequestSuccess)success
                   failure:(BN_RequestFailed)failure{
    
    [[BN_NetWorkTool manager].requestSerializer setValue:@"zh-cn" forHTTPHeaderField:@"langue"];
    return [BN_NetWorkTool POST:URL parameters:parameters responseCache:responseCache success:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
    
}

/**
 *  上传文件
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       文件对应服务器上的字段
 *  @param filePath   文件本地的沙盒路径
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               loadProgress:(BN_Progress)loadProgress
                                success:(BN_RequestSuccess)success
                                failure:(BN_RequestFailed)failure{
    
    return [BN_NetWorkTool uploadFileWithURL:URL parameters:parameters name:name filePath:filePath progress:^(NSProgress *progress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            loadProgress ? loadProgress(progress) : nil;
        });
    } success:^(id responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}


/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param namePefix  图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */

+ (NSURLSessionTask *)uploadImgWithURL:(NSString *)URL
                            parameters:(id)parameters
                             namePefix:(NSString *)namePefix
                                images:(NSArray<UIImage *> *)images
                             fileNames:(NSArray<NSString *> *)fileNames
                              progress:(BN_Progress)progress
                               success:(BN_RequestSuccess)success
                               failure:(BN_RequestFailed)failure{
    return [BN_NetWorkTool uploadImgWithURL:URL parameters:parameters namePefix:namePefix images:images fileNames:fileNames progress:progress success:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
    
}

/**
 表单形式提交数据(add by bin)
 
 @param URL  请求地址
 @param parameters 请求参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)FormDataWithURL:(NSString *)URL
                           parameters:(id)parameters
                             progress:(BN_Progress)progress
                              success:(BN_RequestSuccess)success
                              failure:(BN_RequestFailed)failure{
    [BN_NetWorkTool closeLog];
    return [BN_NetWorkTool FormDataWithURL:URL parameters:parameters progress:progress success:^(id responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
    
}
/**
 *  下载文件
 *
 *  @param URL      请求地址
 *  @param fileDir  文件存储目录(默认存储目录为Download)
 *  @param progress 文件下载的进度信息
 *  @param success  下载成功的回调(回调参数filePath:文件的路径)
 *  @param failure  下载失败的回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，开始下载调用resume方法
 */

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(BN_Progress)progress
                              success:(void(^)(NSString *))success
                              failure:(BN_RequestFailed)failure{
    
    return [BN_NetWorkTool downloadWithURL:URL fileDir:fileDir progress:progress success:success failure:failure];
    
}

@end
