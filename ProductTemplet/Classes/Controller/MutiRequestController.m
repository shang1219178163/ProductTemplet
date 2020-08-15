//
//  MutiRequestController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/19.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "MutiRequestController.h"
#import "AFNetworking/AFNetworking.h"

@interface MutiRequestController ()

@end

@implementation MutiRequestController

-(void)dealloc{
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSInteger idx = 2;
    switch (idx) {
        case 0:
            [self requestGCD];

            break;
        case 1:
            [self requestBlockOperation];
            
            break;
        case 2:
            [self requestSemaphore];
            
            break;
        default:
            break;
    }
}

//测试请求
- (void)requestGCD {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [self request1];
    }) ;
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [self request2];
    }) ;
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        [self request3];
    }) ;
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"刷新界面");
    });
}

- (void)requestBlockOperation{
    //按照顺序
    NSBlockOperation *operation_1 = [NSBlockOperation blockOperationWithBlock:^{
        [self request1];
    }];
    NSBlockOperation *operation_2 = [NSBlockOperation blockOperationWithBlock:^{
        [self request2];
    }];
    NSBlockOperation *operation_3 = [NSBlockOperation blockOperationWithBlock:^{
        [self request3];
    }];
    NSBlockOperation *operation_4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"刷新界面__");
    }];
    //设置依赖
    [operation_2 addDependency:operation_1];
    [operation_3 addDependency:operation_1];
    
    [operation_4 addDependency:operation_2];
    [operation_4 addDependency:operation_3];
    
    //创建队列并添加任务
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperations:@[operation_1,operation_2,operation_3,operation_4] waitUntilFinished:NO];
}

//真正的网络请求
- (void)request1{
    //创建信号量并设置计数默认为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%s","http://v3.wufazhuce.com:8000/api/channel/movie/more/0?platform=ios&version=v4.0.1"];
    [manager GET:url
      parameters:nil
         headers:nil
        progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"];
//        for (NSDictionary *dic in data) {
//            NSLog(@"请求1---%@",dic[@"id"]);
//        }
        NSLog(@"请求1---%@",data.firstObject[@"id"]);

        //计数加1
        dispatch_semaphore_signal(semaphore);
        //11380-- data.lastObject[@"id"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"shibai...");
        //计数加1
        dispatch_semaphore_signal(semaphore);
    }];
    //若计数为0则一直等待
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}
- (void)request2{
    //创建信号量并设置计数默认为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url1 = [NSString stringWithFormat:@"%s","http://v3.wufazhuce.com:8000/api/channel/movie/more/11380?platform=ios&version=v4.0.1"];
    [manager GET:url1
      parameters:nil
         headers:nil
        progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"];
//        for (NSDictionary *dic in data) {
//            NSLog(@"请求2---%@",dic[@"id"]);
//        }
        NSLog(@"请求2---%@",data.firstObject[@"id"]);

        //计数加1
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //计数加1
        dispatch_semaphore_signal(semaphore);
    }];
    //若计数为0则一直等待
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}
- (void)request3{
    //创建信号量并设置计数默认为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url2 = [NSString stringWithFormat:@"%s","http://v3.wufazhuce.com:8000/api/channel/movie/more/11317?platform=ios&version=v4.0.1"];
    [manager GET:url2
      parameters:nil
        headers:nil
        progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *data = responseObject[@"data"];
//        for (NSDictionary *dic in data) {
//            NSLog(@"请求3---%@",dic[@"id"]);
//        }
        NSLog(@"请求3---%@",data.firstObject[@"id"]);

        //计数加1
        dispatch_semaphore_signal(semaphore);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //计数加1
        dispatch_semaphore_signal(semaphore);
    }];
    //若计数为0则一直等待
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestSemaphore{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);//创建信号量
    dispatch_group_t group = dispatch_group_create();             //创建线程组
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"第一个网络请求");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"第二个网络请求");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"第三个网络请求");
        dispatch_semaphore_signal(semaphore);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"三个请求完成后执行");
    });
    
}

@end
