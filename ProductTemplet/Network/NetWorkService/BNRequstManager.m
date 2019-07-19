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

+ (NSDictionary *)paramsFromOrigin:(NSDictionary *)params{
    NSMutableDictionary * mdic = [NSMutableDictionary dictionaryWithDictionary:params];
    if ([NSUserDefaults.standardUserDefaults objectForKey:@"token"]) {
        [mdic setObject:[NSUserDefaults objectForKey:@"token"] forKey:@"token"];
    }
    return mdic.copy;
}

- (NSURLSessionTask *)requestWithSuccessBlock:(BNRequestBlock)successBlock failedBlock:(BNRequestBlock)failureBlock{
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    return [self startRequest];
}

- (NSURLSessionTask *)requestWithBlock:(BNRequestBlock)block{
    self.requestBlock = block;
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
        if (self.requestBlock) {
            self.requestBlock(self, nil, error);
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
        if (self.requestBlock) {
            self.requestBlock(self, cacheDic, nil);
        }
        return task;
    }
    return [self startRequestFromNetWork];
}

- (NSURLSessionTask *)startRequestFromNetWork{
    
    self.isLoading = true;
    //请求日志
    NSString *urlString = [BNAPIConfi.serviceUrl stringByAppendingPathComponent:self.child.requestURI];
    NSDictionary *params = [BNRequstManager paramsFromOrigin:self.child.requestParams];
    [BNLog logRequestInfoWithURI:urlString params:params];
    id token = [NSUserDefaults objectForKey:@"token"];
    if (token) {
        [BNRequstAgent.shared setValue:token forHTTPHeaderField:@"Authorization"];
    }
    
    NSURLSessionTask * task = nil;
    @weakify(self);
    switch (self.child.requestType) {
        case BNRequestTypePost:
        {
            task = [BNRequstAgent.shared POST:urlString parameters:params success:^(BNURLResponse * _Nonnull response) {
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
            task = [BNRequstAgent.shared GET:urlString parameters:params success:^(BNURLResponse * _Nonnull response) {
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
        case BNRequestTypePut:
        {
            task = [BNRequstAgent.shared PUT:urlString parameters:params success:^(BNURLResponse * _Nonnull response) {
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
        case BNRequestTypeDelete:
        {
            task = [BNRequstAgent.shared DELETE:urlString parameters:params success:^(BNURLResponse * _Nonnull response) {
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
        default:
            break;
    }
    
    return task;
}

- (void)didSuccessOfResponse:(BNURLResponse *)model{
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
            model.errorOther = [NSError errorWithDomain:@"服务器返回的josn格式错误" code:BNRequestCodeJSONError userInfo:nil];
            [self didFailureOfResponse:model];
            return;
        }
        
        NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error) {
            model.errorOther = [NSError errorWithDomain:@"服务器返回的josn格式错误" code:BNRequestCodeJSONError userInfo:nil];
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
    DDLog(@"_%@_%@_", @(code), message);
    
    BOOL isFailCode = [jsonDic.allKeys containsObject:@"code"] && code != 1;
    BOOL isFailStatus = [jsonDic.allKeys containsObject:@"status"] && ![jsonDic[@"status"] isEqualToString:@"success"];
    if (isFailCode || isFailStatus) {
        NSString *tips = message ? : @"message为空";
        model.errorOther = [NSError errorWithDomain:tips code:code userInfo:nil];
        [self didFailureOfResponse:model];
        return;
    }
    //请求结果日志
    NSString * urlString = [BNAPIConfi.serviceUrl stringByAppendingString:self.child.requestURI];
    [BNLog logResponseInfoWithURI:urlString responseJSON:jsonDic];
    
//    DDLog(@"delegate:%@",self.delegate);
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(BNRequestManagerProtocol)]) {
        [self.delegate manager:self successDic:jsonDic failError:nil];
    }
    if (self.successBlock) {
        self.successBlock(self, jsonDic, nil);
    }
    if (self.requestBlock) {
        self.requestBlock(self, jsonDic, nil);
    }
    //缓存数据
    if ([self.child respondsToSelector:@selector(saveJsonOfCache:)]) {
        [self.child saveJsonOfCache:jsonDic];
    }
}

- (void)didFailureOfResponse:(BNURLResponse *)model{
    if (model.error) {
        NSData *data = model.error.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *errorStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSInteger statusCode = model.response.statusCode;
        DDLog(@"error:%@_%@",@(statusCode), errorStr);
        
    } else {
        if (model.errorOther.code == BNRequestCodeInvalidToken || model.errorOther.code == BNRequestCodeNoLogin) {
            [BNRequstAgent.shared cancelAllRequest];
            
            //重置token
            NSString * errorMsg = model.errorOther.code == BNRequestCodeNoLogin ? @"您已在其他设备登录" : @"登录失效";
            [UIAlertController showAletTitle:nil msg:errorMsg handler:^{
//                NSNotificationCenter.defaultCenter postNotificationName:<#(nonnull NSNotificationName)#> object:<#(nullable id)#>
            }];
        }
    }
    
    NSError * error = model.error ? : model.errorOther;
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(BNRequestManagerProtocol)]) {
        [self.delegate manager:self successDic:nil failError:error];
    }
    
    if (self.failureBlock) {
        self.failureBlock(self, nil, error);
    }
    if (self.requestBlock) {
        self.requestBlock(self, nil, error);
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
