//
//  BNNetWorkAgent.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNRequstAgent.h"
#import "NNAPIConfi.h"

@interface NNRequstAgent()

@property (nonatomic, strong) NSMutableDictionary *sessionTaskDic;
@property (nonatomic, strong, readwrite) AFHTTPSessionManager *sessionManager;
@property (nonatomic, assign) BOOL isOpenLog;

@end

@implementation NNRequstAgent

+ (instancetype)shared{
    static NNRequstAgent *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[NNRequstAgent alloc]init];
    });
    return _instance;
}

+ (void)initialize{
    if (self == [self class]) {
        AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;

    }
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
    
}

#pragma mark - GET请求
- (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
                  success:(NNNetworkBlock)success
                  failure:(NNNetworkBlock)failure{
    
    DDLog(@"requestSerializer.HTTPRequestHeaders_%@",self.sessionManager.requestSerializer.HTTPRequestHeaders);
    
    if (![URL containsString:NNAPIConfi.serviceUrl]) {
        URL = [NNAPIConfi.serviceUrl stringByAppendingString:URL];
    }
    
    NSURLSessionTask *sessionTask = [self.sessionManager GET:URL
                                                  parameters:parameters
                                                     headers:nil
                                                    progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
        failure ? failure(model) : nil;
        
    }];
    // 添加sessionTask
    self.sessionTaskDic[@(sessionTask.taskIdentifier)] = sessionTask;
    [sessionTask resume];
    return sessionTask;
}

#pragma mark - - POST请求
- (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
                   success:(NNNetworkBlock)success
                   failure:(NNNetworkBlock)failure{
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager POST:URL
                              parameters:parameters
                                 headers:nil
                                progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            progress ? progress(uploadProgress) : nil;
//        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
        failure ? failure(model) : nil;
        
    }];
    return dataTask;
}

#pragma mark - 支持上传多张图片
- (NSURLSessionTask *)formDataPostWithURL:(NSString *)URL
                               parameters:(id)parameters
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                                 progress:(NNProgressBlock)progress
                                  success:(NNNetworkBlock)success
                                  failure:(NNNetworkBlock)failure{
    
    if (_isOpenLog) DDLog(@"parameters = %@",[parameters jsonString]);

    if (![URL containsString:NNAPIConfi.serviceUrl]) {
        URL = [NNAPIConfi.serviceUrl stringByAppendingString:URL];
    }
    NSURLSessionTask *sessionTask = [self.sessionManager POST:URL
                                                   parameters:parameters
                                                      headers:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [NNRequstAgent uploadFileFormData:formData parameters:parameters];
//        [images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSData *data = [obj compressToFileSize:1024*1024];
//            NSString *fileName = [NSDateFormatter stringFromDate:NSDate.date fmt:@"yyyyMMddHHmmss"];
//            NSString *imageType = [UIImage contentTypeForImageData:data];
//            fileName = [fileName stringByAppendingFormat:@".%@", imageType];
//
//            NSString *mimeType = [NSString stringWithFormat:@"image/%@", imageType];
//            [formData appendPartWithFileData:data
//                                        name:@"file"
//                                    fileName:fileName
//                                    mimeType:mimeType];
//            DDLog(@"formData上传图片_%@:%@ (fileName:%@_mimeType:%@)", @"file", @([(NSData *)obj length]), fileName, mimeType);
//        }];
        
        //add by bin
        if ([parameters isKindOfClass: NSString.class]) {
            NSData *paramData = [parameters dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:paramData
                                        name:@"file"];
            
//            DDLog(@"formData________字符串");
        } else if ([parameters isKindOfClass: NSData.class]){
            [formData appendPartWithFormData:parameters
                                        name:@"file"];
            
//            DDLog(@"formData________字符串");
        } else if ([parameters isKindOfClass: NSDictionary.class]){
            [NNRequstAgent uploadFileFormData:formData parameters:parameters];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
        failure ? failure(model) : nil;
        
    }];
    
    // 添加sessionTask
    self.sessionTaskDic[@(sessionTask.taskIdentifier)] = sessionTask;
    [sessionTask resume];
    return sessionTask;
}

#pragma mark - PUT请求
- (NSURLSessionTask *)PUT:(NSString *)URL
               parameters:(id)parameters
                  success:(NNNetworkBlock)success
                  failure:(NNNetworkBlock)failure{
    if (![URL containsString:NNAPIConfi.serviceUrl]) {
        URL = [NNAPIConfi.serviceUrl stringByAppendingString:URL];
    }
    
    NSURLSessionTask *sessionTask = [self.sessionManager PUT:URL
                                                  parameters:parameters
                                                     headers:nil
                                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
        failure ? failure(model) : nil;
    }];
    // 添加sessionTask
    self.sessionTaskDic[@(sessionTask.taskIdentifier)] = sessionTask;
    [sessionTask resume];
    return sessionTask;
}

#pragma mark - Delete请求
- (NSURLSessionTask *)DELETE:(NSString *)URL
                  parameters:(id)parameters
                     success:(NNNetworkBlock)success
                     failure:(NNNetworkBlock)failure{
    if (![URL containsString:NNAPIConfi.serviceUrl]) {
        URL = [NNAPIConfi.serviceUrl stringByAppendingString:URL];
    }
    
    NSURLSessionTask *sessionTask = [self.sessionManager DELETE:URL
                                                     parameters:parameters
                                                        headers:nil
                                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
        failure ? failure(model) : nil;
    }];
    // 添加sessionTask
    self.sessionTaskDic[@(sessionTask.taskIdentifier)] = sessionTask;
    [sessionTask resume];
    return sessionTask;
}

#pragma mark - funtions

+ (void)uploadFileFormData:(id <AFMultipartFormData>)formData parameters:(id)parameters {
    if ([parameters isKindOfClass: NSDictionary.class]) {
        [((NSDictionary *)parameters) enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass: NSString.class]) {
                NSData *paramData = [obj dataUsingEncoding:NSUTF8StringEncoding];
                [formData appendPartWithFormData:paramData name:key];
                DDLog(@"formData上传文字_%@:%@", key, obj);

            } else if ([obj isKindOfClass: NSData.class]){
                // 默认图片的文件名
                NSString *fileName = [NSDateFormatter stringFromDate:NSDate.date fmt:@"yyyyMMddHHmmss"];
                NSString *imageType = [UIImage contentTypeForImageData:obj];
                fileName = [fileName stringByAppendingFormat:@".%@", imageType];

                NSString *mimeType = [NSString stringWithFormat:@"image/%@", imageType];
                [formData appendPartWithFileData:obj
                                            name:@"file"
                                        fileName:fileName
                                        mimeType:mimeType];
                DDLog(@"formData上传图片_%@:%@ (fileName:%@_mimeType:%@)", key, @([(NSData *)obj length]), fileName, mimeType);
            }
        }];
    } else if ([parameters isKindOfClass: NSArray.class]) {
        [(NSArray *)parameters enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *data = [obj isKindOfClass: NSData.class] ? obj : [obj compressToFileSize:1024*1024];
            NSString *fileName = [NSDateFormatter stringFromDate:NSDate.date fmt:@"yyyyMMddHHmmss"];
            NSString *imageType = [UIImage contentTypeForImageData:data];
            fileName = [fileName stringByAppendingFormat:@".%@", imageType];

            NSString *mimeType = [NSString stringWithFormat:@"image/%@", imageType];
            [formData appendPartWithFileData:data
                                        name:@"file"
                                    fileName:fileName
                                    mimeType:mimeType];
            DDLog(@"formData上传图片_%@:%@ (fileName:%@_mimeType:%@)", @"file", @([(NSData *)obj length]), fileName, mimeType);
        }];
    }

}



/**
 返回结果模型化处理
 */
- (NNURLResponse *)modelWithTask:(NSURLSessionDataTask *)task responseObject:(id )responseObject error:(NSError *)error{
    if (_isOpenLog) {
        if (error) {
            DDLog(@"error_%@_",error);
        } else {
            DDLog(@"responseObject_%@_",[responseObject jsonString]);
        }
    }
    
    [self.sessionTaskDic removeObjectForKey:@(task.taskIdentifier)];
    
    NNURLResponse * model = BNURLResponseFromParam(task.currentRequest, task.response, responseObject, error);
    return model;
}

#pragma mark - Cancel Method

- (void)cancelRequestWithIDList:(NSArray *)taskIDs{
    for (NSNumber *taskID in taskIDs) {
        [self cancelRequestWithID: taskID.integerValue];
    }
}

- (void)cancelRequestWithID:(NSInteger)taskID{
    NSURLSessionDataTask *task = self.sessionTaskDic[@(taskID)];
    if (task) {
        [task cancel];
        [self.sessionTaskDic removeObjectForKey:@(taskID)];
    }
}

- (void)cancelAllRequest{
    [self.sessionManager.operationQueue cancelAllOperations];
    [self.sessionTaskDic removeAllObjects];
}

#pragma mark- -funtions


#pragma mark - -lazy

-(AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = AFHTTPSessionManager.manager;
        _sessionManager.requestSerializer = AFJSONRequestSerializer.serializer;
        _sessionManager.requestSerializer.timeoutInterval = NNAPIConfi.timeOut;
        [_sessionManager.requestSerializer setValue:NNAPIConfi.headerUserAgent forHTTPHeaderField:@"User-Agent"];
//        [_sessionManager.requestSerializer setValue:NNAPIConfi.headerAcceptVersion forHTTPHeaderField:@"Accept-Version"];

        _sessionManager.responseSerializer = AFJSONResponseSerializer.serializer;
        _sessionManager.responseSerializer = AFHTTPResponseSerializer.serializer;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    }
    return _sessionManager;
}

-(NSMutableDictionary *)sessionTaskDic{
    if (!_sessionTaskDic) {
        _sessionTaskDic = [NSMutableDictionary dictionary];
    }
    return _sessionTaskDic;
}

@end
