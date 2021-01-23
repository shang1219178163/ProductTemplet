//
//  WHKReuestSevice.m
//  
//
//  Created by BIN on 2017/8/10.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "WHKReuestSevice.h"
#import "WHKRequestHelper.h"

#import <NNGloble/NNGloble.h>

@implementation WHKReuestSevice

+ (NSURLSessionTask *)formDataWithURL:(NSString *)URL
                           parameters:(NSDictionary *)parameters
                             progress:(PPHttpProgress)progress
                              success:(PPHttpRequestSuccess)success
                              failure:(PPHttpRequestFailed)failure{
    [PPNetworkHelper setRequestSerializer:PPRequestSerializerJSON];
    [PPNetworkHelper setResponseSerializer:PPResponseSerializerJSON];
//    [PPNetworkHelper setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    [PPNetworkHelper setValue:@"zh-cn" forHTTPHeaderField:@"langue"];
    
    return [PPNetworkHelper FormDataWithURL:URL
                                 parameters:parameters
                                   progress:progress
                                    success:success
                                    failure:failure];
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
