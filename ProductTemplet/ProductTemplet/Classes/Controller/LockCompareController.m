//
//  LockCompareController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "LockCompareController.h"

#import "UIView+Helper.h"

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
        [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
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


/*
 临界区：指的是一块对公共资源进行访问的代码，并非一种机制或是算法。
 
 自旋锁：是用于多线程同步的一种锁，线程反复检查锁变量是否可用。由于线程在这一过程中保持执行，因此是一种忙等待。一旦获取了自旋锁，线程会一直保持该锁，直至显式释放自旋锁。 自旋锁避免了进程上下文的调度开销，因此对于线程只会阻塞很短时间的场合是有效的。
 
 互斥锁（Mutex）：是一种用于多线程编程中，防止两条线程同时对同一公共资源（比如全局变量）进行读写的机制。该目的通过将代码切片成一个一个的临界区而达成。(当一个线程获得这个锁之后，其他想要获得此锁的线程将会被阻塞，直到该锁被释放)
 
 读写锁：是计算机程序的并发控制的一种同步机制，也称“共享-互斥锁”、多读者-单写者锁) 用于解决多线程对公共资源读写问题。读操作可并发重入，写操作是互斥的。 读写锁通常用互斥锁、条件变量、信号量实现。(读写锁实际是一种特殊的自旋锁，它把对共享资源的访问者划分成读者和写者，读者只对共享资源进行读访问，写者则需要对共享资源进行写操作。这种锁相对于自旋锁而言，能提高并发性，因为在多处理器系统中，它允许同时有多个读者来访问共享资源，最大可能的读者数为实际的逻辑CPU数。写者是排他性的，一个读写锁同时只能有一个写者或多个读者（与CPU数相关），但不能同时既有读者又有写者)
 
 信号量（semaphore）：是一种更高级的同步机制，互斥锁可以说是semaphore在仅取值0/1时的特例。信号量可以有更多的取值空间，用来实现更加复杂的同步，而不单单是线程间互斥。
 
 条件锁：就是条件变量，当进程的某些资源要求不满足时就进入休眠，也就是锁住了。当资源被分配到了，条件锁打开，进程继续运行。
 
 在线程之间共享更多的资源，会使用更多的锁，同时也会增加死锁的概率。这也是为什么我们需要尽量减少线程间资源共享，并确保共享的资源尽量简单的原因之一.
 */

//锁的使用原则:对共享资源操作前一定要获得锁.完成操作以后一定要释放锁.尽量短时间地占用锁.

/*
 互斥锁
 解释:当一个线程获得这个锁之后，其他想要获得此锁的线程将会被阻塞，直到该锁被释放。
 特点:
 使用:
 NSLock：是Foundation框架中以对象形式暴露给开发者的一种锁，（Foundation框架同时提供了NSConditionLock，NSRecursiveLock，NSCondition）
 tryLock 和 lock 方法都会请求加锁，唯一不同的是trylock在没有获得锁的时候可以继续做一些任务和处理。lockBeforeDate方法也比较简单，就是在limit时间点之前获得锁，没有拿到返回NO。
 
 它的实现非常简单，通过宏，定义了 lock 方法:
 #define    MLOCK \
 - (void) lock\
 {\
 int err = pthread_mutex_lock(&_mutex);\
 // 错误处理 ……
 }
 NSLock 只是在内部封装了一个pthread_mutex，属性为 PTHREAD_MUTEX_ERRORCHECK，它会损失一定性能换来错误提示。
 这里使用宏定义的原因是，OC内部还有其他几种锁，他们的lock方法都是一模一样，仅仅是内部pthread_mutex互斥锁的类型不同。通过宏定义，可以简化方法的定义。
 
 NSLock 比 pthread_mutex 略慢的原因在于它需要经过方法调用，同时由于缓存的存在，多次方法调用不会对性能产生太大的影响。
 - (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
     ...
     self.lock = [[NSLock alloc] init];
     self.lock.name = AFURLSessionManagerLockName;
     ...
 }
 - (void)setDelegate:(AFURLSessionManagerTaskDelegate *)delegate forTask:(NSURLSessionTask *)task{
     ...
     [self.lock lock];
     self.mutableTaskDelegatesKeyedByTaskIdentifier[@(task.taskIdentifier)] = delegate;
     [delegate setupProgressForTask:task];
     [self addNotificationObserverForTask:task];
     [self.lock unlock];
 }
 
 
 自旋锁
 解释:当一个线程获得锁之后，其他线程将会一直循环在哪里查看是否该锁被释放。
 特点:可以避免了进程上下文的调度开销.
 使用:对于线程只会阻塞很短时间的场合是有效的.
 1.OSSpinLock:
 
 OSSpinLock lock = OS_SPINLOCK_INIT;
 OSSpinLockLock(&lock);
 ...
 OSSpinLockUnlock(&lock);
 自旋锁因为优先级翻转问题,不在安全;除非开发者能保证访问锁的线程全部都处于同一优先级，否则 iOS 系统中所有类型的自旋锁都不能再使用了。
 
 (优先级反转)具体来说，如果一个低优先级的线程获得锁并访问共享资源，这时一个高优先级的线程也尝试获得这个锁，它会处于 spin lock 的忙等(busy-wait)状态从而占用大量 CPU。此时低优先级线程无法与高优先级线程争夺 CPU 时间，从而导致任务迟迟完不成、无法释放 lock;
 
 附:现代操作系统在管理普通线程时，通常采用时间片轮转算法(Round Robin，简称 RR)。每个线程会被分配一段时间片(quantum)，通常在 10-100 毫秒左右。当线程用完属于自己的时间片以后，就会被操作系统挂起，放入等待队列中，直到下一次被分配时间片。
 
 2.os_unfair_lock 是苹果官方推荐的替换OSSpinLock的方案，但是它在iOS10.0以上的系统才可以调用。(等待os_unfair_lock锁的线程会处于休眠状态，从用户态切换到内核态，而并非忙等。)
 
 os_unfair_lock_t unfairLock;
 unfairLock = &(OS_UNFAIR_LOCK_INIT);
 os_unfair_lock_lock(unfairLock);
 os_unfair_lock_unlock(unfairLock);
 
 读写锁又称共享-互斥锁，
 pthread_rwlock：
 使用场景:文件写入读出
 //加读锁
 pthread_rwlock_rdlock(&rwlock);
 //加写锁
 pthread_rwlock_wrlock(&rwlock);
 //解锁
 pthread_rwlock_unlock(&rwlock);
 
 递归锁
 特点:同一个线程可以加锁N次而不会引发死锁。
 1.NSRecursiveLock:
 NSRecursiveLock在YYKit中YYWebImageOperation.m中有用到：
     _lock = [NSRecursiveLock new];
     - (void)dealloc {
     [_lock lock];
     ...
     ...
     [_lock unlock];
 }
 
 2.pthread_mutex(recursive):
 pthread_mutex锁也支持递归，只需要设置PTHREAD_MUTEX_RECURSIVE即可
 
 pthread_mutex_t lock;
 pthread_mutexattr_t attr;
 pthread_mutexattr_init(&attr);
 pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE);
 pthread_mutex_init(&lock, &attr);
 pthread_mutexattr_destroy(&attr);
 pthread_mutex_lock(&lock);
 pthread_mutex_unlock(&lock);

 由于 pthread_mutex 有多种类型，可以支持递归锁等，因此在申请加锁时，需要对锁的类型加以判断，这也就是为什么它和信号量的实现类似，但效率略低的原因。
 
 条件锁
 
 1. NSCondition:
 定义：
 @interface NSCondition : NSObject <nslocking> {
 @private
    void *_priv;
 }
 - (void)wait;
 - (BOOL)waitUntilDate:(NSDate *)limit;
 - (void)signal;
 - (void)broadcast;</nslocking>
 遵循NSLocking协议，使用的时候同样是lock,unlock加解锁，wait是傻等，waitUntilDate:方法是等一会，都会阻塞掉线程，signal是唤起一个在等待的线程，broadcast是广播全部唤起。

 NSCondition *lock = [[NSCondition alloc] init];
 //Son 线程
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     [lock lock];
     while (No Money) {
        [lock wait];
     }
     NSLog(@"The money has been used up.");
     [lock unlock];
 });
 
 //Father线程
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     [lock lock];
     NSLog(@"Work hard to make money.");
     [lock signal];
     [lock unlock];
 });
 
 2.NSConditionLock:
 
 定义：
 @interface NSConditionLock : NSObject <nslocking> {
 @private
 void *_priv;
 }
 - (instancetype)initWithCondition:(NSInteger)condition NS_DESIGNATED_INITIALIZER;
 @property (readonly) NSInteger condition;
 - (void)lockWhenCondition:(NSInteger)condition;
 - (BOOL)tryLock;
 - (BOOL)tryLockWhenCondition:(NSInteger)condition;
 - (void)unlockWithCondition:(NSInteger)condition;
 - (BOOL)lockBeforeDate:(NSDate *)limit;
 - (BOOL)lockWhenCondition:(NSInteger)condition beforeDate:(NSDate *)limit;</nslocking>

 */

/*
 //关于锁的使用:
 1.spinlock适用于开发硬件驱动，比如USB外接设备的软件，因为需要低级（内核级）的锁来控制设备的传输状态同步等。
 2.dispatch_semaphore和mutex适合服务器软件需要高并发模型的网络应用开发，但是据我了解，Mac OS信号量做得不是很好，signal很容易crash，要set sigpipe。
 3.所有的general target（一般目标）应用软件，用NSQueue是最理想的，也是它设计的初衷，为绝大多数Cocoa应用布置多线程。
 4.@synchronized是：当需要自行控制锁的时候，而NSQueue不够自己的需求，然后需要手动控制的情况。
 不要觉得什么都要用低级的才觉得bigger很高，要根据业务需求，如果本身对lock需求不高，只是做UI应用层业务开发的去使用spin，本身操作系统、硬件层面知识不足的人（这些人一般是软件工程师而不是硬件工程师）很容易犯错，导致死锁，实际上所有的锁都是安全的。
 spin出问题也是出在开发者错误的逻辑，也是建立在不符自身领域范围的控制欲。区分优先级也是为了避免越权，有些开发者为了满足自己特殊的癖好或者虚荣心才用无法master的工具，甚至跨越上一层runtime级别的操作，很容易会开发出buggy的应用。
 这也是编译器出现的目的，不至于你使用指令集级别去写应用程序，而是一层一层的编译，你要是为了bigger用Assembly Language（汇编）去写iOS应用也是很无聊的。
 */
