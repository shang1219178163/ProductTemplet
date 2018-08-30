//
//  ThreadNormolController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "ThreadNormolController.h"

@interface ThreadNormolController ()

@property(nonatomic,strong) NSThread * thread;


@end

@implementation ThreadNormolController

-(NSThread *)thread{
    if (!_thread) {
        _thread = [[NSThread alloc]initWithTarget:self selector:@selector(subThreadEnter) object:nil];
        [_thread start];
    }
    return _thread;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

/**
 子线程启动后，启动runloop
 这里创建了一个线程，取名为AFNetworking，因为添加了一个runloop，所以这个线程不会被销毁，直到runloop停止。
 这种runloop，只有一种方式能终止
 [NSRunLoop currentRunLoop]removePort:<#(nonnull NSPort *)#> forMode:<#(nonnull NSRunLoopMode)#>```
 只有从runloop中移除我们之前添加的端口，这样runloop没有任何事件，所以直接退出。
 
 再次回到 AF2.x 的这行源码上，因为他用的是run，而且并没有记录下自己添加的NSMachPort，所以显然，他就没打算退出这个runloop，**这是一个常驻线程**。事实上，看过AF2.x源码的同学会知道，这个thread需要常驻的原因，在此就不在赘述了。
 #####  我们看看AF3.x是怎么用runloop的：
 开启的时候：CFRunLoopRun();
 终止的时候：CFRunLoopStop(CFRunLoopGetCurrent());
 
 (- 由于NSUrlSession参考了AF的2.x的优点，自己维护了一个线程池，做Request线程的调度与管理，所以在AF3.x中，没有了常驻线程，都是用的时候run，结束的时候stop。)
 
 #### 总结一下：
 
 - runloop运行方法一共5种：包括NSRunloop的3种，CFRunloop的两种;
 而取消的方式一共为3种：
 1）移除掉runloop中的所有事件源（timer和source）。
 2）设置一个超时时间。
 3）只要CFRunloop运行起来就可以用：void CFRunLoopStop( CFRunLoopRef rl );去停止。
 - 除此之外用NSRunLoop下面这个方法运行也能使用void CFRunLoopStop( CFRunLoopRef rl );停止：
 
 */

- (void)subThreadEnter{
    @autoreleasepool {
        [[NSThread currentThread] setName:@"AFNetworking"];
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        //如果注释了下面这一行，子线程中的任务并不能正常执行
        [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];//线程永不停止
        NSLog(@"启动RunLoop前--%@",runLoop.currentMode);
        [runLoop run];
        
    }
}

/**
 子线程任务
 */
- (void)handleThreadAction{
    
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
    
    for (int i=0; i<30; i++){
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"----子线程任务 %ld",(long)i);
    }
    NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(handleThreadAction) onThread:self.thread withObject:nil waitUntilDone:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
