//
//  NNRequstManager.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/4/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNRequstManager.h"
#import "NNRequstAgent.h"
#import "NNLog.h"
#import "NSError+Helper.h"
#import "NNAPIConfi.h"

@interface NNRequstManager()

@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, strong) NSMutableDictionary *taskDic;
@property (nonatomic, strong) NSDictionary *errorDic;

@end


@implementation NNRequstManager

- (instancetype)init{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(NNRequestManagerProtocol)]) {
            self.child = (id <NNRequestManagerProtocol>)self;
            
        } else {
            NSException *exception = [[NSException alloc] initWithName:@"BNRequestManager init exption" reason:@"必须在子数实现BNRequestManagerProtocol" userInfo:nil];
            @throw exception;
        }
    }
    return self;
}

- (AFHTTPSessionManager *)sessionManager{
    return NNRequstAgent.shared.sessionManager;
}

+ (NSDictionary *)paramsFromOrigin:(NSDictionary *)params{
    NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:params];
    NSString *token = [NSUserDefaults.standardUserDefaults objectForKey:@"token"];
    if (token.length > 0) {
        [mdic setObject:token forKey:@"token"];
    }
    return mdic.copy;
}

- (NSURLSessionTask *)requestWithSuccess:(NNRequestSuccessBlock)successBlock fail:(NNRequestFailedBlock)failureBlock{
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    return [self startRequest];
}

- (NSURLSessionTask *)startRequest{
    NSURLSessionTask *task = nil;

    if (![self.child validateParams]) {
        NSError *error = [NSError errorWithMessage:@"validateParams参数校验失败" code:NNRequestCodeParamsError obj:nil];
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(NNRequestManagerProtocol)]) {
            [self.delegate managerAPIFail:self error:error];
        }
        if (self.failureBlock) {
            self.failureBlock(self, error);
        }
        return task;
    }
    
    if ([self.child respondsToSelector:@selector(jsonFromCache)] && self.child.jsonFromCache) {
        NSDictionary *cacheDic = self.child.jsonFromCache;
        [self printLog:cacheDic isSend:false];
        
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(NNRequestManagerProtocol)]) {
            [self.delegate managerAPISuccess:self dic:cacheDic];
        }
        if (self.successBlock) {
            self.successBlock(self, cacheDic);
        }
        return task;
    }
    return [self startRequestFromNetWork];
}

- (NSURLSessionTask *)startRequestFromNetWork{
    
    self.isLoading = true;
    //请求日志
    NSString *urlString = self.child.requestURI;
    if (![urlString hasPrefix:@"http"]) {
        urlString = [NNAPIConfi.serviceUrl stringByAppendingString:urlString];
    }

    NSDictionary *params = [NNRequstManager paramsFromOrigin:self.child.requestParams];
    [self printLog:params isSend:true];
    
    id token = [NSUserDefaults objectForKey:@"token"];
    if (token) {
        [NNRequstAgent.shared setValue:token forHTTPHeaderField:@"token"];
    }
    
    NSURLSessionTask *task = nil;
    @weakify(self);
    switch (self.child.requestType) {
        case NNRequestTypePost:
        {
            task = [NNRequstAgent.shared POST:urlString parameters:params success:^(NNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didSuccessOfResponse:response];
                
            } failure:^(NNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didFailureOfResponse:response];
                
            }];
        }
            break;
        case NNRequestTypeFormDataPost:
       {
           task = [NNRequstAgent.shared Upload:urlString parameters:params progress:nil success:^(NNURLResponse * _Nonnull response) {
               @strongify(self);
               self.isLoading = false;
               [self didSuccessOfResponse:response];
               
           } failure:^(NNURLResponse * _Nonnull response) {
               @strongify(self);
               self.isLoading = false;
               [self didFailureOfResponse:response];
               
           }];

       }
           break;
        case NNRequestTypeGet:
        {
            task = [NNRequstAgent.shared GET:urlString parameters:params success:^(NNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didSuccessOfResponse:response];

            } failure:^(NNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didFailureOfResponse:response];
    
            }];
        }
            break;
        case NNRequestTypePut:
        {
            task = [NNRequstAgent.shared PUT:urlString parameters:params success:^(NNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didSuccessOfResponse:response];
                
            } failure:^(NNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didFailureOfResponse:response];
                
            }];
        }
            break;
        case NNRequestTypeDelete:
        {
            task = [NNRequstAgent.shared DELETE:urlString parameters:params success:^(NNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didSuccessOfResponse:response];
                
            } failure:^(NNURLResponse * _Nonnull response) {
                @strongify(self);
                self.isLoading = false;
                [self didFailureOfResponse:response];
                
            }];
        }
            break;
        default:
            break;
    }
    
    return task;
}

- (void)didSuccessOfResponse:(NNURLResponse *)model{
    if (model.response.statusCode != 200) {
        [self didFailureOfResponse:model];
        return;
    }
    
    NSDictionary *jsonDic = nil;
    if ([model.responseObject isKindOfClass: NSDictionary.class]) {
        jsonDic = model.responseObject;
        
    } else {
        NSString *jsonString = [[NSString alloc]initWithData:model.responseObject encoding:NSUTF8StringEncoding];
        if (!jsonString) {
            model.errorOther = [NSError errorWithDomain:@"服务器返回的josn格式错误" code:NNRequestCodeJSONError userInfo:nil];
            [self didFailureOfResponse:model];
            return;
        }
        
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            model.errorOther = [NSError errorWithDomain:@"服务器返回的josn格式错误" code:NNRequestCodeJSONError userInfo:nil];
            [self didFailureOfResponse:model];
            return;
        }
    }
    
    NSInteger code = 0;
    NSString *message = @"";
    if ([jsonDic.allKeys containsObject:@"code"]) {
        code = [jsonDic[@"code"] integerValue];
        
    } else if ([jsonDic.allKeys containsObject:@"resultCount"]) {
        code = [jsonDic.allKeys containsObject:@"resultCount"];
    }
    
    if ([jsonDic.allKeys containsObject:@"message"]) {
        message = jsonDic[@"message"];
    }
    
    BOOL isFailCode = [jsonDic.allKeys containsObject:@"code"] && code != 1;
    BOOL isFailStatus = [jsonDic.allKeys containsObject:@"status"] && ![jsonDic[@"status"] isEqualToString:@"success"];
    if (isFailCode || isFailStatus) {
        NSString *tips = message ? : @"message为空";
        model.errorOther = [NSError errorWithDomain:tips code:code userInfo:nil];
        [self didFailureOfResponse:model];
        return;
    }
    //请求结果日志
    [self printLog:jsonDic isSend:false];

//    DDLog(@"delegate:%@",self.delegate);
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(NNRequestManagerProtocol)]) {
        [self.delegate managerAPISuccess:self dic:jsonDic];
    }
    if (self.successBlock) {
        self.successBlock(self, jsonDic);
    }
    //缓存数据
    if ([self.child respondsToSelector:@selector(saveJsonOfCache:)]) {
        [self.child saveJsonOfCache:jsonDic];
    }
}

- (void)didFailureOfResponse:(NNURLResponse *)model{
    if (model.error) {
        NSData *data = model.error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSInteger statusCode = model.response.statusCode;
        DDLog(@"error:%@_%@",@(statusCode), errorStr);
        
    } else {
        if (model.errorOther.code == NNRequestCodeInvalidToken || model.errorOther.code == NNRequestCodeNoLogin) {
            [NNRequstAgent.shared cancelAllRequest];
            
            //重置token
            NSString *errorMsg = model.errorOther.code == NNRequestCodeNoLogin ? @"您已在其他设备登录" : @"登录失效";
            [UIAlertController showAlertTitle:nil
                                      message:errorMsg
                                 actionTitles:@[kTitleKnow]
                                      handler:^(UIAlertController *alertVC, UIAlertAction * _Nonnull action) {
//                NSNotificationCenter.defaultCenter postNotificationName:<#(nonnull NSNotificationName)#> object:<#(nullable id)#>

            }];

        }
    }
    
    NSError *error = model.error ? : model.errorOther;
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(NNRequestManagerProtocol)]) {
        [self.delegate managerAPIFail:self error:error];
    }
    
    if (self.failureBlock) {
        self.failureBlock(self, error);
    }
}


#pragma mark - funtions

- (void)printLog:(NSDictionary *)dic isSend:(BOOL)isSend{
    if (!self.child.printLog) {
        return;
    }
    NSString *urlString = [self.child requestURI];
    if (![urlString hasPrefix:@"http"]) {
        urlString = [NSString stringWithFormat:@"%@%@", NNAPIConfi.serviceUrl, urlString];
    }
    if (isSend) {
        [NNLog logRequestInfoWithURI:urlString params:dic];
    } else {
        [NNLog logResponseInfoWithURI:urlString responseJSON:dic];
    }
}

#pragma mark - -lazy

-(NSDictionary *)errorDic{
    if (!_errorDic) {
        _errorDic = @{
                      @(NNRequestCodeParamsError): @"参数错误",
                      @(NNRequestCodeJSONError): @"JSON解析错误",
                      @(NNRequestCodeTimeout): @"请求超时",
                      @(NNRequestCodeNetworkError): @"网络错误",
                      @(NNRequestCodeServerError): @"服务端返回非200的状态码",
                      @(NNRequestCodeCancel): @"取消网络请求",
                      @(NNRequestCodeNoLogin): @"未登录",
                      @(NNRequestCodeNotFound): @"服务器找不到给定的资源；文档不存在",
                      @(NNRequestCodeInvalidRequest): @"无效请求",
                      @(NNRequestCodeInvalidToken): @"参数错误",
                      @(NNRequestCodeUnknown): @"未知错误",
                      };
    }
    return _errorDic;
}



@end
