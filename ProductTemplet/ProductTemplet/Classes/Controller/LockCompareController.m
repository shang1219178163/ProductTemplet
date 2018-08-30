//
//  LockCompareController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "LockCompareController.h"

#import <pthread.h>
#import <libkern/OSAtomic.h>
#import <QuartzCore/QuartzCore.h>
#import <os/lock.h>

typedef NS_ENUM(NSUInteger, LockType) {
    LockTypeOSSpinLock = 0,
    LockTypedispatch_semaphore,
    LockTypepthread_mutex,
    LockTypeNSCondition,
    LockTypeNSLock,
    LockTypepthread_mutex_recursive,
    LockTypeNSRecursiveLock,
    LockTypeNSConditionLock,
    LockTypesynchronized,
    LockTypeUnfairLock,
    LockTypeCount,
};


NSTimeInterval TimeCosts[LockTypeCount] = {0};
int TimeCount = 0;

@interface LockCompareController ()

@end

@implementation LockCompareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int buttonCount = 5;
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 200, 50);
        button.center = CGPointMake(self.view.frame.size.width / 2, i * 60 + 160);
        button.tag = pow(10, i + 3);
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"run (%d)",(int)button.tag] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    [self.view getViewLayer];
}

- (void)tap:(UIButton *)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test:(int)sender.tag];
    });
}

- (void)test:(int)count {
    NSTimeInterval begin, end;
    TimeCount += count;
    
    {
        OSSpinLock lock = OS_SPINLOCK_INIT;
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            OSSpinLockLock(&lock);
            OSSpinLockUnlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeOSSpinLock] += end - begin;
        printf("OSSpinLock:               %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        dispatch_semaphore_t lock =  dispatch_semaphore_create(1);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
            dispatch_semaphore_signal(lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypedispatch_semaphore] += end - begin;
        printf("dispatch_semaphore:       %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        pthread_mutex_t lock;
        pthread_mutex_init(&lock, NULL);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            pthread_mutex_unlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypepthread_mutex] += end - begin;
        pthread_mutex_destroy(&lock);
        printf("pthread_mutex:            %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSCondition *lock = [NSCondition new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSCondition] += end - begin;
        printf("NSCondition:              %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSLock *lock = [NSLock new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSLock] += end - begin;
        printf("NSLock:                   %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        pthread_mutex_t lock;
        pthread_mutexattr_t attr;
        pthread_mutexattr_init(&attr);
        pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
        pthread_mutex_init(&lock, &attr);
        pthread_mutexattr_destroy(&attr);
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            pthread_mutex_lock(&lock);
            pthread_mutex_unlock(&lock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypepthread_mutex_recursive] += end - begin;
        pthread_mutex_destroy(&lock);
        printf("pthread_mutex(recursive): %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSRecursiveLock *lock = [NSRecursiveLock new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSRecursiveLock] += end - begin;
        printf("NSRecursiveLock:          %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            [lock lock];
            [lock unlock];
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeNSConditionLock] += end - begin;
        printf("NSConditionLock:          %8.2f ms\n", (end - begin) * 1000);
    }
    
    
    {
        NSObject *lock = [NSObject new];
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            @synchronized(lock) {}
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypesynchronized] += end - begin;
        printf("@synchronized:            %8.2f ms\n", (end - begin) * 1000);
    }
    
    {
        os_unfair_lock_t unfairLock;
        unfairLock = &(OS_UNFAIR_LOCK_INIT);
        
        begin = CACurrentMediaTime();
        for (int i = 0; i < count; i++) {
            os_unfair_lock_lock(unfairLock);
            os_unfair_lock_unlock(unfairLock);
        }
        end = CACurrentMediaTime();
        TimeCosts[LockTypeUnfairLock] += end - begin;
        printf("os_unfair_lock:           %8.2f ms\n", (end - begin) * 1000);
    }
    printf("---- fin (%d) ----\n\n",count);
}

@end