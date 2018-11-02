//
//  NotificationTreadController.m
//  ProductTemplet
//
//  Created by hsf on 2018/10/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NotificationTreadController.h"

@interface NotificationTreadController ()<NSMachPortDelegate>

@property (nonatomic) NSMutableArray    *notiList;         // 通知队列
@property (nonatomic) NSThread          *notiThread;    // 期望线程
@property (nonatomic) NSLock            *notiLock;      // 用于对通知队列加锁的锁对象，避免线程冲突
@property (nonatomic) NSMachPort        *notiPort;      // 用于向期望线程发送信号的通信端口


@end

@implementation NotificationTreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSLog(@"current thread = %@", NSThread.currentThread);
    
    // 初始化
    self.notiList = [NSMutableArray array];
    self.notiLock = [[NSLock alloc] init];
    
    self.notiThread = NSThread.currentThread;
    self.notiPort = [[NSMachPort alloc] init];
    self.notiPort.delegate = self;
    
    // 往当前线程的run loop添加端口源
    // 当Mach消息到达而接收线程的run loop没有运行时，则内核会保存这条消息，直到下一次进入run loop
    [NSRunLoop.currentRunLoop addPort:self.notiPort forMode:(__bridge NSString *)kCFRunLoopCommonModes];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(processNotification:) name:@"kNoti_fication" object:nil];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSNotificationCenter.defaultCenter postNotificationName:@"kNoti_fication" object:nil userInfo:nil];

    });
    
}

- (void)handlePortMessage:(NSPortMessage *)message{
    [self.notiLock lock];
    while (self.notiList.count) {
        NSNotification *notification = self.notiList[0];
        [self.notiList removeObjectAtIndex:0];
        [self.notiLock unlock];
        [self processNotification:notification];
        [self.notiLock lock];
    };
    
    [self.notiLock unlock];
}

- (void)processNotification:(NSNotification *)notification {
    if (NSThread.currentThread != _notiThread) {
        // Forward the notification to the correct thread.
        [self.notiLock lock];
        [self.notiList addObject:notification];
        [self.notiLock unlock];
        [self.notiPort sendBeforeDate:NSDate.date components:nil from:nil reserved:0];
    }
    else {
        // Process the notification here;
        NSLog(@"current thread = %@", NSThread.currentThread);
        NSLog(@"process notification");
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSNotificationCenter.defaultCenter postNotificationName:@"kNoti_fication" object:nil userInfo:nil];
        
    });
}


@end
