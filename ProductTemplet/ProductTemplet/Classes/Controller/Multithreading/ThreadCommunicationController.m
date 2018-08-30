
//
//  ThreadCommunicationController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//

/*
 #### 基于runloop的线程通信
 
 首先明确一个概念，线程间的通信（不仅限于通信，几乎所有iOS事件都是如此），实际上是各种输入源，触发runloop去处理对应的事件，所以我们先来讲讲输入源：
 输入源异步的发送消息给你的线程。事件来源取决于输入源的种类：
 
 - 基于端口的输入源和自定义输入源。基于端口的输入源监听程序相应的端口。自定义输入源则监听自定义的事件源。
 
 至于run loop，它不关心输入源的是基于端口的输入源还是自定义的输入源。系统会实现两种输入源供你使用。两类输入源的区别在于：
 
 - 基于端口的输入源由内核自动发送，而自定义的则需要人工从其他线程发送。
 
 当你创建输入源，你需要将其分配给run loop中的一个或多个模式。模式只会在特定事件影响监听的源。大多数情况下，run loop运行在默认模式下，但是你也可以使其运行在自定义模式。若某一源在当前模式下不被监听，那么任何其生成的消息只在run loop运行在其关联的模式下才会被传递。
 
 1）基于端口的输入源:
 在runloop中，被定义名为souce1。Cocoa和Core Foundation内置支持使用端口相关的对象和函数来创建的基于端口的源。例如，在Cocoa里面你从来不需要直接创建输入源。你只要简单的创建端口对象，并使用NSPort的方法把该端口添加到run loop。端口对象会自己处理创建和配置输入源。
 
 在Core Foundation，你必须人工创建端口和它的run loop源.在两种情况下，你都可以使用端口相关的函数（CFMachPortRef，CFMessagePortRef，CFSocketRef）来创建合适的对象。
 
 这里用Cocoa里的举个例子，Cocoa里用来线程间传值的是NSMachPort，它的父类是NSPort。

 
 - 我们跨越线程，确实从主线程往另一个线程发送了消息。
 - 这里要注意几个点：
 1）- (void)handlePortMessage:(id)message这里这个代理的参数，从.h里去复制过来的为NSPortMessage类型的一个对象，但是我们发现苹果只是在.h中@class进来，我们无法调用它的任何方法。所以我们用id声明，然后通过KVC去取它的属性。
 2）关于下面这个传值类型的问题：
 NSMutableArray *array = [NSMutableArray arrayWithArray:@[mainPort,data]];
 **这个传参数组里面只能装两种类型的数据，一种是NSPort的子类，一种是NSData的子类。**所以我们如果要用这种方式传值必须得先把数据转成NSData类型的才行。
 
 */

#import "ThreadCommunicationController.h"

@interface ThreadCommunicationController ()<NSPortDelegate>

@end

@implementation ThreadCommunicationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)handleCommunication{
//    NSPort *port1 = [[NSPort alloc]init];
//    NSPort *port2 = [[NSMachPort alloc]init];
//    NSPort *port3 = [NSPort port];
//    NSPort *port4 = [NSMachPort port];
    //声明两个端口 随便怎么写创建方法，返回的总是一个NSMachPort实例
    NSMachPort *mainPort = [[NSMachPort alloc]init];
    NSPort *threadPort = [NSMachPort port];
    //设置线程的端口的代理回调为自己
    threadPort.delegate = self;
    
    //给主线程runloop加一个端口
    [[NSRunLoop currentRunLoop]addPort:mainPort forMode:NSDefaultRunLoopMode];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //添加一个Port
        [[NSRunLoop currentRunLoop]addPort:threadPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
    });
    
    NSString *s1 = @"hello";
    
    NSData *data = [s1 dataUsingEncoding:NSUTF8StringEncoding];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:@[mainPort,data]];
        //过2秒向threadPort发送一条消息，第一个参数：发送时间。msgid 消息标识。
        //components，发送消息附带参数。reserved：为头部预留的字节数（从官方文档上看到的，猜测可能是类似请求头的东西...）
        [threadPort sendBeforeDate:[NSDate date] msgid:1000 components:array from:mainPort reserved:0];
    });

}


#pragma mark - -NSPortMessage
-(void)handlePortMessage:(id)message{
    NSLog(@"收到消息了，线程为：%@",[NSThread currentThread]);
    //只能用KVC的方式取值
    NSArray *array = [message valueForKeyPath:@"components"];

    NSData *data = array[1];
    NSString *s1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",s1);
    
    // NSMachPort *localPort = [message valueForKeyPath:@"localPort"];
    // NSMachPort *remotePort = [message valueForKeyPath:@"remotePort"];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self handleCommunication];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
