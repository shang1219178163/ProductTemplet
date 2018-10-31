//
//  NotificationTreadController.m
//  ProductTemplet
//
//  Created by hsf on 2018/10/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NotificationTreadController.h"

@interface NotificationTreadController ()<NSMachPortDelegate,NSPortDelegate>

@property (nonatomic) NSMutableArray    *notifications;         // 通知队列
@property (nonatomic) NSThread          *notificationThread;    // 期望线程
@property (nonatomic) NSLock            *notificationLock;      // 用于对通知队列加锁的锁对象，避免线程冲突
@property (nonatomic) NSMachPort        *notificationPort;      // 用于向期望线程发送信号的通信端口


@end

@implementation NotificationTreadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    NSLog(@"current thread = %@", NSThread.currentThread);
    
    // 初始化
    self.notifications = [NSMutableArray array];
    self.notificationLock = [[NSLock alloc] init];
    
    self.notificationThread = NSThread.currentThread;
    self.notificationPort = [[NSMachPort alloc] init];
    self.notificationPort.delegate = self;
    
    // 往当前线程的run loop添加端口源
    // 当Mach消息到达而接收线程的run loop没有运行时，则内核会保存这条消息，直到下一次进入run loop
    [NSRunLoop.currentRunLoop addPort:self.notificationPort forMode:(__bridge NSString *)kCFRunLoopCommonModes];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(processNotification:) name:@"TestNotification" object:nil];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSNotificationCenter.defaultCenter postNotificationName:@"TEST_NOTIFICATION" object:nil userInfo:nil];
        
    });
    
}

- (void)handlePortMessage:(NSPortMessage *)message{
    DDLog(@"%@",message);
    
}


- (void)handleMachMessage:(void *)msg {
    
    DDLog(@"%@",msg);
//    //1. 消息id
//    NSUInteger msgId = [[msg valueForKeyPath:@"msgid"] integerValue];
//
//    //2. 当前主线程的port
//    NSPort *localPort = [msg valueForKeyPath:@"localPort"];
//
//    //3. 接收到消息的port（来自其他线程）
//    NSPort *remotePort = [msg valueForKeyPath:@"remotePort"];

    
    [self.notificationLock lock];
    
    while (self.notifications.count) {
        NSNotification *notification = self.notifications[0];
        [self.notifications removeObjectAtIndex:0];
        [self.notificationLock unlock];
        [self processNotification:notification];
        [self.notificationLock lock];
    };
    
    [self.notificationLock unlock];
}

- (void)processNotification:(NSNotification *)notification {
    
    if (NSThread.currentThread != _notificationThread) {
        // Forward the notification to the correct thread.
        [self.notificationLock lock];
        [self.notifications addObject:notification];
        [self.notificationLock unlock];
        [self.notificationPort sendBeforeDate:NSDate.date
                                   components:nil
                                         from:nil
                                     reserved:0];
    }
    else {
        // Process the notification here;
        NSLog(@"current thread = %@", NSThread.currentThread);
        NSLog(@"process notification");
    }
}


@end
