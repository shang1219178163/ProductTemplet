//
//  BN_NetWorkTool.m
//  HuiZhuBang
//
//  Created by hsf on 2018/9/3.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_NetWorkTool.h"


#import "Utilities_DM.h"
#import "NSDateFormatter+Helper.h"

#ifdef DEBUG
#define PPLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define PPLog(...)
#endif

#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

@implementation BN_NetWorkTool

static BOOL _isOpenLog;   // 是否已开启日志打印
static NSMutableArray *_allSessionTask;
static AFHTTPSessionManager *_sessionManager;
static AFNetworkReachabilityManager *_reachabilityManager;

#pragma mark - 开始监听网络
+ (void)networkStatusWithBlock:(BN_NetworkStatus)networkStatus {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            networkStatus ? networkStatus(status) : nil;
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    if (_isOpenLog) PPLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    if (_isOpenLog) PPLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    if (_isOpenLog) PPLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    if (_isOpenLog) PPLog(@"WIFI");
                    break;
            }
        }];
    });
}

/**
 存储着所有的请求task数组
 */
+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

+ (void)cancelAllRequest {
    // 锁操作
    @synchronized(self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}

+ (void)cancelRequestWithURL:(NSString *)URL {
    if (!URL) { return; }
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:URL]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - GET请求
+ (NSURLSessionTask *)GET:(NSString *)URL
               parameters:(id)parameters
            responseCache:(BN_RequestCache)responseCache
                  success:(BN_RequestSuccess)success
                  failure:(BN_RequestFailed)failure {
    //读取缓存
    //读取缓存
    responseCache != nil ? responseCache([BN_NetWorkCache httpCacheForURL:URL parameters:parameters]) : nil;
    
    NSURLSessionTask *sessionTask = [_sessionManager GET:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog == YES) PPLog(@"%@",[(NSDictionary *)responseObject JSONValue]);

        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [BN_NetWorkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog == YES) PPLog(@"%@",error.description);

        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

#pragma mark - POST请求自动缓存
+ (NSURLSessionTask *)POST:(NSString *)URL
                parameters:(id)parameters
             responseCache:(BN_RequestCache)responseCache
                   success:(BN_RequestSuccess)success
                   failure:(BN_RequestFailed)failure {
    //读取缓存
    responseCache != nil ? responseCache([BN_NetWorkCache httpCacheForURL:URL parameters:parameters]) : nil;

    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog == YES) PPLog(@"%@",[(NSDictionary *)responseObject JSONValue]);

        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        //对数据进行异步缓存
        responseCache != nil ? [BN_NetWorkCache setHttpCache:responseObject URL:URL parameters:parameters] : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog == YES) PPLog(@"%@",error.description);

        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    
    // 添加最新的sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

#pragma mark - 上传文件
+ (NSURLSessionTask *)uploadFileWithURL:(NSString *)URL
                             parameters:(id)parameters
                                   name:(NSString *)name
                               filePath:(NSString *)filePath
                               progress:(BN_Progress)progress
                                success:(BN_RequestSuccess)success
                                failure:(BN_RequestFailed)failure {
    
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:name error:&error];
        (failure && error) ? failure(error) : nil;
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog == YES) PPLog(@"%@",[(NSDictionary *)responseObject JSONValue]);

        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog == YES) PPLog(@"%@",error.description);

        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

#pragma mark - 上传多张图片
+ (NSURLSessionTask *)uploadImgWithURL:(NSString *)URL
                               parameters:(id)parameters
                                namePefix:(NSString *)namePefix
                                   images:(NSArray<UIImage *> *)images
                                fileNames:(NSArray<NSString *> *)fileNames
                                 progress:(BN_Progress)progress
                                  success:(BN_RequestSuccess)success
                                  failure:(BN_RequestFailed)failure {
    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [self uploadFormData:formData parameters:parameters images:images namePefix:namePefix fileNames:fileNames progress:progress];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (_isOpenLog == YES) PPLog(@"%@",[(NSDictionary *)responseObject JSONValue]);
        
        [[self allSessionTask] removeObject:task];
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (_isOpenLog == YES) PPLog(@"%@",error.description);

        [[self allSessionTask] removeObject:task];
        failure ? failure(error) : nil;
        
    }];
    
    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

+ (void)uploadFormData:(id<AFMultipartFormData>  _Nonnull)formData
            parameters:(id)parameters
                images:(NSArray<UIImage *> *)images
             namePefix:(NSString *)namePefix
             fileNames:(NSArray<NSString *> *)fileNames
              progress:(BN_Progress)progress{
    
    for (NSUInteger i = 0; i < images.count; i++) {
        // 图片经过等比压缩后得到的二进制文件
        NSData *imageData = [Utilities_DM compressImageDataFromImage:images[i] maxFileSize:kFileSize_image];
        NSString *imageType = [Utilities_DM contentTypeForImageData:imageData];
        
        // 默认图片的文件名, 若fileNames为nil就使用
        NSDateFormatter *formatter = [NSDateFormatter dateFormat:@"yyyyMMddHHmmss"];
        NSString *dateStr = [formatter stringFromDate:[NSDate date]];
        NSString *imageFileName = NSStringFormat(@"%@%ld.%@",dateStr,(unsigned long)i,imageType?:@"jpg");
        
        NSString *name = fileNames[i] ? : [namePefix stringByAppendingFormat:@"%@",@(i+1)];
        [formData appendPartWithFileData:imageData
                                    name:name
                                fileName:fileNames ? NSStringFormat(@"%@.%@",fileNames[i],imageType?:@"jpg") : imageFileName
                                mimeType:NSStringFormat(@"image/%@",imageType ?: @"image/png")];
        DDLog(@"formData________image%@->%@->%@->%luk",@(i),name,imageFileName,[imageData length]/1024);
    }
  
    //其他参数
    if ([parameters isKindOfClass:[NSString class]]) {
        NSData * data = [parameters dataUsingEncoding:NSUTF8StringEncoding];
        [formData appendPartWithFormData:data name:@"data"];

    }
    else if([parameters isKindOfClass:[NSDate class]]){
        [formData appendPartWithFormData:parameters name:@"data"];

    }
    else{
        NSParameterAssert([parameters isKindOfClass:[NSString class]] || [parameters isKindOfClass:[NSDate class]]);
        
    }
    
}

#pragma mark - -表单形式提交数据
+ (NSURLSessionTask *)FormDataWithURL:(NSString *)URL
                           parameters:(id)parameters
                             progress:(BN_Progress)progress
                              success:(BN_RequestSuccess)success
                              failure:(BN_RequestFailed)failure {
    
    NSURLSessionTask *sessionTask = [self uploadImgWithURL:URL parameters:parameters namePefix:nil images:nil fileNames:nil progress:progress success:^(id responseObject) {
        success ? success(responseObject) : nil;

    } failure:^(NSError *error) {
        failure ? failure(error) : nil;

    }];
    
//    NSURLSessionTask *sessionTask = [_sessionManager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSParameterAssert([parameters isKindOfClass:[NSString class]] || [parameters isKindOfClass:[NSData class]]);
//
//        //add by bin
//      NSData * data = [parameters isKindOfClass:[NSData class]] ? parameters : [parameters dataUsingEncoding:NSUTF8StringEncoding];
//      [formData appendPartWithFormData:data name:@"data"];
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        //上传进度
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            progress ? progress(uploadProgress) : nil;
//        });
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [[self allSessionTask] removeObject:task];
//        success ? success(responseObject) : nil;
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[self allSessionTask] removeObject:task];
//        failure ? failure(error) : nil;
//
//    }];

    // 添加sessionTask到数组
    sessionTask ? [[self allSessionTask] addObject:sessionTask] : nil ;
    return sessionTask;
}

#pragma mark - 下载文件
+ (NSURLSessionTask *)downloadWithURL:(NSString *)URL
                              fileDir:(NSString *)fileDir
                             progress:(BN_Progress)progress
                              success:(void(^)(NSString *))success
                              failure:(BN_RequestFailed)failure {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    __block NSURLSessionDownloadTask *downloadTask = [_sessionManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //返回文件位置的URL路径
        NSURL * fileUrl = [self downloadFileDir:fileDir defaultDir:@"Download" respone:response];
        return fileUrl;
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allSessionTask] removeObject:downloadTask];
        if(failure && error) {failure(error) ; return ;};
        success ? success(filePath.absoluteString /** NSURL->NSString*/) : nil;
        
    }];
    //开始下载
    [downloadTask resume];
    // 添加sessionTask到数组
    downloadTask ? [[self allSessionTask] addObject:downloadTask] : nil ;
    return downloadTask;
}

+(NSURL *)downloadFileDir:(NSString *)fileDir defaultDir:(NSString *)defaultDir respone:(NSURLResponse * _Nonnull)response{
    
    NSString *downloadDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDir ? fileDir : (defaultDir ? : @"Download")];//拼接缓存目录
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//打开文件管理器
    [fileManager createDirectoryAtPath:downloadDir withIntermediateDirectories:YES attributes:nil error:nil];//创建Download目录
    
    NSString *filePath = [downloadDir stringByAppendingPathComponent:response.suggestedFilename];//拼接文件路径
    //返回文件位置的URL路径
    return [NSURL fileURLWithPath:filePath];

}


#pragma mark - - request

#pragma mark - 初始化AFHTTPSessionManager相关属性
/**
 开始监测网络状态
 */
+ (void)load {
    [[self reaManager] startMonitoring];
}
/**
 *  所有的HTTP请求共享一个AFHTTPSessionManager
 *  原理参考地址:http://www.jianshu.com/p/5969bbb4af9f
 */

+ (void)initialize {
    _sessionManager = [self manager];
    // 设置请求的超时时间
    _sessionManager.requestSerializer.timeoutInterval = 6.f;
    // 设置服务器返回结果的类型:JSON (AFJSONResponseSerializer,AFHTTPResponseSerializer)
    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
}

+(AFHTTPSessionManager *)manager{
    _sessionManager = [AFHTTPSessionManager manager];
    return _sessionManager;
}

+(AFNetworkReachabilityManager *)reaManager{
    _reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    return _reachabilityManager;
    
}

+ (void)openLog {
    _isOpenLog = YES;
}

+ (void)closeLog {
    _isOpenLog = NO;
}

#pragma mark - 重置AFHTTPSessionManager相关属性

+ (void)setAFHTTPSessionManagerProperty:(void (^)(AFHTTPSessionManager *))sessionManager {
    sessionManager ? sessionManager(_sessionManager) : nil;
}

+ (void)openNetworkActivityIndicator:(BOOL)open{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

+ (void)setSecurityPolicyWithCerPath:(NSString *)cerPath validatesDomainName:(BOOL)validatesDomainName {
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    // 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    // 如果需要验证自建证书(无效证书)，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    // 是否需要验证域名，默认为YES;
    securityPolicy.validatesDomainName = validatesDomainName;
    securityPolicy.pinnedCertificates = [[NSSet alloc] initWithObjects:cerData, nil];
    
    [_sessionManager setSecurityPolicy:securityPolicy];
}

@end


