//
//  BNRequstManager.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNRequstManager.h"
#import "BNRequstAgent.h"
#import "BNLog.h"
#import "NSError+Helper.h"
#import "BNAPIConfi.h"

@interface BNRequstManager()

@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, strong) NSMutableDictionary *taskDic;
@property (nonatomic, strong) NSDictionary *errorDic;

@end


@implementation BNRequstManager

- (instancetype)init{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(BNRequestManagerProtocol)]) {
            self.child = (id <BNRequestManagerProtocol>)self;
            
        } else {
            NSException *exception = [[NSException alloc] initWithName:@"BNRequestManager init exption" reason:@"必须在子数实现BNRequestManagerProtocol" userInfo:nil];
            @throw exception;
        }
    }
    return self;
}

- (AFHTTPSessionManager *)sessionManager{
    return BNRequstAgent.shared.sessionManager;
}

- (NSURLSessionTask *)requestWithSuccessBlock:(BNRequestResultBlock)successBlock failedBlock:(BNRequestResultBlock)failureBlock{
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    return [self startRequest];
}

- (NSURLSessionTask *)startRequest{
    NSURLSessionTask * task = nil;

    if (![self.child validateParams]) {
        NSError * error = [NSError errorWithMessage:@"validateParams参数校验失败" code:BNRequestCodeParamsError obj:nil];
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(BNRequestManagerProtocol)]) {
            [self.delegate manager:self successDic:nil failError:error];
        }
        if (self.failureBlock) {
            self.failureBlock(self, nil, error);
        }
        return task;
    }
    
    if ([self.child respondsToSelector:@selector(jsonFromCache)] && self.child.jsonFromCache) {
        NSDictionary *cacheDic = self.child.jsonFromCache;
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(BNRequestManagerProtocol)]) {
            [self.delegate manager:self successDic:cacheDic failError:nil];
        }
        if (self.successBlock) {
            self.successBlock(self, cacheDic, nil);
        }
        return task;
    }
    return [self startRequestFromNetWork];
}

- (NSURLSessionTask *)startRequestFromNetWork{
    
    self.isLoading = true;
    //请求日志
    NSString * urlStr = [BNAPIConfi.serviceUrl stringByAppendingPathComponent:self.child.requestURI];
    [BNLog logRequestInfoWithURI:urlStr params:self.child.requestParams];
    id token = [NSUserDefaults objectForKey:@"token"];
    if (token) {
        [BNRequstAgent.shared setValue:token forHTTPHeaderField:@"token"];

//        NSString *token = [NSUserDefaults objectForKey:@"token"];
        NSNumber *tokenTimeout = [NSUserDefaults objectForKey:@"tokenTimeout"];
        NSString *cookieStr = [NSHTTPCookieStorage cookieDesWithToken:token tokenTimeout:tokenTimeout];
        DDLog(@"cookieStr_%@", cookieStr);
        [BNRequstAgent.shared setValue:cookieStr forHTTPHeaderField:@"Set-Cookie"];
        
        //
//        NSNumber *tokenTimeout = [NSUserDefaults objectForKey:@"tokenTimeout"];
        NSDictionary *properties = @{
                                     NSHTTPCookieDomain: BNAPIConfi.serviceUrl,
                                     NSHTTPCookiePath: @"/",
                                     NSHTTPCookieName: @"token",
                                     NSHTTPCookieValue: token,
                                     NSHTTPCookieExpires: [NSDate dateWithTimeIntervalSinceNow:tokenTimeout.integerValue],
                                     NSHTTPCookieMaximumAge: tokenTimeout,
                                     };

        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:properties];
        [NSHTTPCookieStorage.sharedHTTPCookieStorage setCookie:cookie];

        NSLog(@"cookie:%@",cookie.description);
        NSArray *cookies = [NSArray arrayWithObjects:cookie,nil];
        NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
        NSLog(@"headers:%@",headers);
    }
    
    NSURLSessionTask * task = nil;
    @weakify(self);
    switch (self.child.requestType) {
        case BNRequestTypePost:
        {
            task = [BNRequstAgent.shared POST:self.child.requestURI parameters:self.child.requestParams success:^(BNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didSuccessOfResponse:response];
                
            } failure:^(BNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didFailureOfResponse:response];
                
            }];

        }
            break;
        case BNRequestTypeGet:
        {
            task = [BNRequstAgent.shared GET:self.child.requestURI parameters:self.child.requestParams success:^(BNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didSuccessOfResponse:response];

            } failure:^(BNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didFailureOfResponse:response];
                
                NSDictionary *allHeaders = response.response.allHeaderFields;
                DDLog(@"allHeaders_%@", allHeaders);
                
                NSArray * cookies = NSHTTPCookieStorage.sharedHTTPCookieStorage.cookies;
                NSDictionary *headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
                NSLog(@"headers:%@",headers);
            }];
        }
            break;
        default:
            break;
    }
    
    return task;
}

- (void)didSuccessOfResponse:(BNURLResponse *)model{
    if (model.response.statusCode != 200) {
        model.errorOther = [NSError errorWithMessage:@"服务器返回statusCode出错" code:BNRequestCodeServerError obj:nil];
        [self didFailureOfResponse:model];
        return;
    }
    
    if ([BNRequstAgent.shared.sessionManager.responseSerializer isKindOfClass:AFHTTPResponseSerializer.class]) {
        NSString *string = [[NSString alloc]initWithData:model.responseObject encoding:NSUTF8StringEncoding];
        NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
        id obj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
        obj = obj? : string;
        
        if (self.successBlock) {
            self.successBlock(self, obj, nil);
        }
        return;
    }
   
    
    NSDictionary *jsonDic = nil;
    if ([model.responseObject isKindOfClass: NSDictionary.class]) {
        jsonDic = model.responseObject;
        
    } else {
        NSString *jsonString = [[NSString alloc]initWithData:model.responseObject encoding:NSUTF8StringEncoding];
        if (!jsonString) {
            model.errorOther = [NSError errorWithMessage:@"服务器返回的responseObject错误" code:BNRequestCodeJSONError obj:nil];
            [self didFailureOfResponse:model];
            return;
        }
        
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            model.errorOther = [NSError errorWithMessage:@"服务器返回的josn格式错误" code:BNRequestCodeJSONError obj:nil];
            [self didFailureOfResponse:model];
            return;
        }
    }
    
    if ([jsonDic.allKeys containsObject:@"code"] || [jsonDic.allKeys containsObject:@"resultCount"] ) {
        NSString * codeKey = [jsonDic.allKeys containsObject:@"code"] ? @"code" : @"resultCount";
        NSInteger code = [jsonDic[codeKey] integerValue];
        NSString *message = jsonDic[@"message"];
        if (code != 1) {
            model.errorOther = [NSError errorWithMessage:message code:code obj:nil];
            [self didFailureOfResponse:model];
            return;
        }
    }

    //请求结果日志
    [BNLog logResponseInfoWithURI:self.child.requestURI responseJSON:jsonDic];
    
    DDLog(@"delegate:%@",self.delegate);
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(BNRequestManagerProtocol)]) {
        [self.delegate manager:self successDic:jsonDic failError:nil];
    }
    if (self.successBlock) {
        self.successBlock(self, jsonDic, nil);
    }
    //缓存数据
    if ([self.child respondsToSelector:@selector(saveJsonOfCache:)]) {
        [self.child saveJsonOfCache:jsonDic];
    }
}

- (void)didFailureOfResponse:(BNURLResponse *)model{
    NSInteger statusCode = model.response.statusCode;
    if (model.response.statusCode != BNRequestCodeSuccess && statusCode > 0) {
        model.errorOther = [NSError errorWithMessage:@"服务器返回statusCode出错" code:BNRequestCodeServerError obj:nil];
        return;
    }
    
    NSInteger errorCode = model.error.code;
    switch (errorCode) {
        case NSURLErrorTimedOut:
            model.errorOther = [NSError errorWithMessage:@"请求超时" code:BNRequestCodeTimeout obj:nil];
            
            break;
            
        case NSURLErrorCancelled:
            //当调用[task cancel]时，取消请求不回调
            model.errorOther = [NSError errorWithMessage:@"请求被取消" code:BNRequestCodeCancel obj:nil];

            break;
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorBadURL:
        case NSURLErrorUnsupportedURL:
        case NSURLErrorCannotFindHost:
        case NSURLErrorNetworkConnectionLost:
        case NSURLErrorDNSLookupFailed:
        case NSURLErrorNotConnectedToInternet:
            model.errorOther = [NSError errorWithMessage:@"网络错误" code:BNRequestCodeNetworkError obj:nil];
            
            break;
        default:
            model.errorOther = [NSError errorWithMessage:@"未知错误" code:BNRequestCodeUnknown obj:nil];

            break;
    }
    model.errorOther.obj = @{
                            @"URI": self.child.requestURI,
                            @"response" : model.response,
                            };
    [self handleFailureWithError:model.errorOther];
}

- (void)handleFailureWithError:(NSError *)error{
    
    if (error.code == BNRequestCodeInvalidToken || error.code == BNRequestCodeNoLogin) {
        [BNRequstAgent.shared cancelAllRequest];
        
        //重置token
        NSString * errorMsg = error.code == BNRequestCodeNoLogin ? @"您已在其他设备登录" : @"登录失效";
        [UIAlertController showAletTitle:nil msg:errorMsg block:nil];
        
    }
    
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(BNRequestManagerProtocol)]) {
        [self.delegate manager:self successDic:nil failError:error];
    }
    
    if (self.failureBlock) {
        self.failureBlock(self, nil, error);
    }
    
}

#pragma mark - -lazy

-(NSDictionary *)errorDic{
    if (!_errorDic) {
        _errorDic = @{
                      @(BNRequestCodeParamsError)    : @"参数错误",
                      @(BNRequestCodeJSONError)      : @"JSON解析错误",
                      @(BNRequestCodeTimeout)        : @"请求超时",
                      @(BNRequestCodeNetworkError)   : @"网络错误",
                      @(BNRequestCodeServerError)    : @"服务端返回非200的状态码",
                      @(BNRequestCodeCancel)         : @"取消网络请求",
                      @(BNRequestCodeNoLogin)        : @"未登录",
                      @(BNRequestCodeNotFound)       : @"服务器找不到给定的资源；文档不存在",
                      @(BNRequestCodeInvalidRequest) : @"无效请求",
                      @(BNRequestCodeInvalidToken)   : @"参数错误",
                      @(BNRequestCodeUnknown)        : @"未知错误",
                      };
    }
    return _errorDic;
}

@end
