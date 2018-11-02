
//
//  NSThreadViewController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//


/*
 // 方法一，需要start
NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1:) object:@"NSThread1"];
// 线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
[thread1 start];
 
 // 方法二，创建好之后自动启动
[NSThread detachNewThreadSelector:@selector(doSomething2:) toTarget:self withObject:@"NSThread2"];
 
 // 方法三，隐式创建，直接启动
[self performSelectorInBackground:@selector(doSomething3:) withObject:@"NSThread3"];
 
 */

#import "ThreadViewController.h"

@interface ThreadViewController ()

@property(nonatomic,strong) NSPort * port;

@end

@implementation ThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)memoryTest {
    for (int i = 0; i < 10000; ++i) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
        thread.name = @"thread";
        [thread start];
        [self performSelector:@selector(stopThread) onThread:thread withObject:nil waitUntilDone:YES];
    }
}

- (void)stopThread {
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSThread *thread = NSThread.currentThread;
    [thread cancel];
}

- (void)run {
    @autoreleasepool {
        NSLog(@"current thread = %@", NSThread.currentThread);
        NSRunLoop *runLoop = NSRunLoop.currentRunLoop;
        if (!self.port) {
            self.port = NSMachPort.port;
        }
        [runLoop addPort:self.port forMode:NSDefaultRunLoopMode];
        CFRunLoopRun();
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self memoryTest];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
