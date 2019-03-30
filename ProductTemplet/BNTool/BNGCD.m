
//
//  GCD.m
//  
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "BNGCD.h"

@implementation BNGCD

void BNdispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer)){
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(timeInterval *NSEC_PER_SEC), 0);
    // 设置回调
    __weak __typeof(target) weaktarget = target;
    dispatch_source_set_event_handler(timer, ^{
        if (!weaktarget)  {
            dispatch_source_cancel(timer);
            NSLog(@"dispatch_source_cancel!!!");
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (handler) handler(timer);
            });
        }
    });
    // 启动定时器
    dispatch_resume(timer);
}

@end
