//
//  WHKReuestSevice.m
//  
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "WHKReuestSevice.h"
#import "WHKRequestHelper.h"

#import "BN_Globle.h"

@implementation WHKReuestSevice

/*
 配置好PPNetworkHelper各项请求参数,封装成一个公共方法,给以上方法调用,
 相比在项目中单个分散的使用PPNetworkHelper/其他网络框架请求,可大大降低耦合度,方便维护
 在项目的后期, 你可以在公共请求方法内任意更换其他的网络请求工具,切换成本小
 */

/**
 *  上传单/多张图片
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
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
                                  failure:(PPHttpRequestFailed)failure {
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
    NSString * name = @"image";
    CGFloat imageScale = 1.0;
    NSString * imageType = @"jpeg";

    return [PPNetworkHelper uploadImagesWithURL:URL parameters:parameters name:name images:images fileNames:fileNames imageScale:imageScale imageType:imageType progress:^(NSProgress *progress) {
        //上传进度
    } success:^(id responseObject) {
        success(responseObject);
        
    } failure:^(NSError *error) {
        failure(error);
        
    }];
}

+ (NSURLSessionTask *)uploadImagesWithURL:(NSString *)URL
                               parameters:(id)parameters
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                                 progressRate:(PPHttpProgress)progressRate
                                  success:(PPHttpRequestSuccess)success
                                  failure:(PPHttpRequestFailed)failure {
    // 在请求之前你可以统一配置你请求的相关参数 ,设置请求头, 请求参数的格式, 返回数据的格式....这样你就不需要每次请求都要设置一遍相关参数
    // 设置请求头
    NSString * name = @"image";
    CGFloat imageScale = 1.0;
    NSString * imageType = @"jpeg";
    
    return [PPNetworkHelper uploadImagesWithURL:URL parameters:parameters name:name images:images fileNames:fileNames imageScale:imageScale imageType:imageType progress:^(NSProgress *progress) {
        progressRate(progress);//上传进度
        
    } success:^(id responseObject) {
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
+ (NSURLSessionTask *)formDataWithURL:(NSString *)URL
                           parameters:(id)parameters
                              success:(PPHttpRequestSuccess)success
                              failure:(PPHttpRequestFailed)failure{
    
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
//    [PPNetworkHelper setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    [PPNetworkHelper setValue:@"zh-cn" forHTTPHeaderField:@"langue"];

    return [PPNetworkHelper FormDataWithURL:URL parameters:parameters success:^(id responseObject) {
        success(responseObject);

    } failure:^(NSError *error) {
        failure(error);

    }];
}



+ (void)recognizeCardWithParameters:(id)parameters
                            success:(PPHttpRequestSuccess)success
                            failure:(PPHttpRequestFailed)failure{
    
    NSString *appcode = kRecognizeCard_AppCode;
    NSString *host = @"https://dm-51.data.aliyun.com";
    NSString *path = @"/rest/160601/ocr/ocr_idcard.json";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = parameters;
//        NSString *bodys = @"{
//            \"inputs\": [
//            {
//                    \"image\": {
//                    \"dataType\": 50,
//                    \"dataValue\": \"图片二进制数据的base64编码\"
//                },
//                    \"configure\": {
//                    \"dataType\": 50,
//                    \"dataValue\": \"{\\\"side\\\":\\\"face\\\"}\"  #身份证正反面类型:face/back
//            }
//        }
//        ]
//    }";

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue: [NSString  stringWithFormat:@"APPCODE %@" ,appcode] forHTTPHeaderField:@"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       
//                                                       DDLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       //打印应答中的body
                                                       DDLog(@"Response body: %@" , bodyString);
                                                       bodyString = [bodyString stringByRemovingPercentEncoding];
                                                       DDLog(@"UTF8EncodeStrNew: %@" , bodyString);

                                                       if (error) {
                                                           failure(error);
                                                           
                                                       } else {
                                                           success(bodyString);
                                                           
                                                       }
                                                   }];

    [task resume];
}


@end
