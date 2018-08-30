//
//  WHKReuestSevice.h
//  HuiZhuBang
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YYModel.h"
#import "MJRefresh.h"
#import "MJExtension.h"

#import "PPNetworkHelper.h"
#import "WHKRequestHelper.h"

typedef NS_ENUM(NSInteger,WHKRequestServiceType) {
    
    WHKRequestServiceTypeGet = 0,
    WHKRequestServiceTypePost
};

/**
 请求成功的block
 
 @param info     返回信息
 @param response 响应体数据
 */
typedef void(^PPRequestSuccess)(id responseObject);
/**
 请求失败的block
 
 @param extInfo 扩展信息
 */
typedef void(^PPRequestFailure)(NSError *error);

@interface WHKReuestSevice : NSObject

@property(nonatomic,readonly) WHKRequestServiceType requestType;

/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                                  success:(PPHttpRequestSuccess)success
                                  failure:(PPHttpRequestFailed)failure;

/**
 增加进度返回
 */
+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                             progressRate:(PPHttpProgress)progressRate
                                  success:(PPHttpRequestSuccess)success
                                  failure:(PPHttpRequestFailed)failure;
/**
 表单形式提交数据(add by bin)
 
 @param URL  请求地址
 @param parameters 请求参数
 @param success 请求成功的回调
 @param failure 请求失败的回调
 @return 返回的对象可取消请求,调用cancel方法
 */
+ (NSURLSessionTask *)formDataWithURL:(NSString *)URL
                           parameters:(id)parameters
                              success:(PPHttpRequestSuccess)success
                              failure:(PPHttpRequestFailed)failure;


/**
 身份证识别接口
 */
+ (void)recognizeCardWithParameters:(id)parameters
                            success:(PPHttpRequestSuccess)success
                            failure:(PPHttpRequestFailed)failure;



@end
