//
//  BNNetWorkAgent.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNRequstAgent.h"


#import "BNAPIConfi.h"

@interface BNRequstAgent()

@property (nonatomic, strong) NSMutableDictionary *sessionTaskDic;
@property (nonatomic, strong, readwrite) AFHTTPSessionManager *sessionManager;
@property (nonatomic, assign) BOOL isOpenLog;

@end

@implementation BNRequstAgent

+ (instancetype)shared{
    static BNRequstAgent *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[BNRequstAgent alloc]init];
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
                  success:(BNNetworkBlock)success
                  failure:(BNNetworkBlock)failure{
    
    DDLog(@"requestSerializer.HTTPRequestHeaders_%@",self.sessionManager.requestSerializer.HTTPRequestHeaders);
    
    if (![URL containsString:BNAPIConfi.serviceUrl]) {
        URL = [BNAPIConfi.serviceUrl stringByAppendingString:URL];
    }
    NSURLSessionTask *sessionTask = [self.sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
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
                                  success:(BNNetworkBlock)success
                                  failure:(BNNetworkBlock)failure{
    return [BNRequstAgent.shared postWithURL:URL
                                  parameters:parameters
                                      images:nil
                                   fileNames:nil
                                    progress:nil
                                     success:success
                                     failure:failure];
}

#pragma mark - 支持上传多张图片
- (NSURLSessionTask *)postWithURL:(NSString *)URL
                       parameters:(id)parameters
                           images:(NSArray<UIImage *> *)images
                        fileNames:(NSArray<NSString *> *)fileNames
                         progress:(BNProgressBlock)progress
                          success:(BNNetworkBlock)success
                          failure:(BNNetworkBlock)failure{
    
    if (_isOpenLog) DDLog(@"parameters = %@",[parameters jsonString]);

    if (![URL containsString:BNAPIConfi.serviceUrl]) {
        URL = [BNAPIConfi.serviceUrl stringByAppendingString:URL];
    }
    NSURLSessionTask *sessionTask = [self.sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            BNUploadModel * model = BNUploadModelFromParam(images, i, fileNames[i]);
            [formData appendPartWithFileData:model.data
                                        name:model.name
                                    fileName:model.fileName
                                    mimeType:model.mimeType];
            DDLog(@"formData________image%@->%@->%@->%luk", @(i), model.name, model.fileName, model.data.length/1024);
        }
        //add by bin
        if ([parameters isKindOfClass:[NSString class]]) {
            NSData *paramData = [parameters dataUsingEncoding:NSUTF8StringEncoding];
            [formData appendPartWithFormData:paramData
                                        name:@"data"];
            
//            DDLog(@"formData________字符串");
        } else if ([parameters isKindOfClass:[NSData class]]){
            [formData appendPartWithFormData:parameters
                                        name:@"data"];
            
//            DDLog(@"formData________字符串");
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
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
                  success:(BNNetworkBlock)success
                  failure:(BNNetworkBlock)failure{
    if (![URL containsString:BNAPIConfi.serviceUrl]) {
        URL = [BNAPIConfi.serviceUrl stringByAppendingString:URL];
    }
    
    NSURLSessionTask *sessionTask = [self.sessionManager PUT:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
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
                     success:(BNNetworkBlock)success
                     failure:(BNNetworkBlock)failure{
    if (![URL containsString:BNAPIConfi.serviceUrl]) {
        URL = [BNAPIConfi.serviceUrl stringByAppendingString:URL];
    }
    
    NSURLSessionTask *sessionTask = [self.sessionManager DELETE:URL parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BNURLResponse * model = [self modelWithTask:task responseObject:responseObject error:nil];
        success ? success(model) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        BNURLResponse * model = [self modelWithTask:task responseObject:nil error:error];
        failure ? failure(model) : nil;
    }];
    // 添加sessionTask
    self.sessionTaskDic[@(sessionTask.taskIdentifier)] = sessionTask;
    [sessionTask resume];
    return sessionTask;
}


/**
 返回结果模型化处理
 */
- (BNURLResponse *)modelWithTask:(NSURLSessionDataTask *)task responseObject:(id )responseObject error:(NSError *)error{
    if (_isOpenLog) {
        if (error) {
            DDLog(@"error_%@_",error);
        } else {
            DDLog(@"responseObject_%@_",[responseObject jsonString]);
        }
    }
    
    [self.sessionTaskDic removeObjectForKey:@(task.taskIdentifier)];
    
    BNURLResponse * model = BNURLResponseFromParam(task.currentRequest, task.response, responseObject, error);
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
        _sessionManager.requestSerializer.timeoutInterval = BNAPIConfi.timeOut;
        [_sessionManager.requestSerializer setValue:BNAPIConfi.headerUserAgent forHTTPHeaderField:@"User-Agent"];
//        [_sessionManager.requestSerializer setValue:BNAPIConfi.headerAcceptVersion forHTTPHeaderField:@"Accept-Version"];

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
