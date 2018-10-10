//
//  OperationViewController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "OperationViewController.h"

#import "BN_Operation.h"

#import "BN_Globle.h"
#import "UIView+Helper.h"

@interface OperationViewController ()

@property (nonatomic, strong) UIButton *hideImageViewButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *itemList;

@end

@implementation OperationViewController

-(NSArray *)itemList{
    if (!_itemList) {
        _itemList = @[
                      @"NSInvocationOperation",@"NSBlockOperation",@"NSOperation子类",
                      @"addExecutionBlock:实现多线程",@"addOperation把任务添加到队列",@"addOperationWithBlock把任务添加到队列",
                      @"线程间通信",@"最大并发数",@"操作依赖addDependency",
                      ];
    }
    return _itemList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect = CGRectMake(20, 20, kScreen_width - 20*2, 0);
    UIView * containView = [UIView createViewWithRect:rect items:self.itemList numberOfRow:1 itemHeight:30 padding:10 type:@0 handler:^(id obj, id item, NSInteger idx) {
        [self handleActionBtn:item];
        
    }];
    
    containView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:containView];
    
    [self.view getViewLayer];
}

- (void)handleActionBtn:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
            [self testNSInvocationOperation];
            
            break;
        case 1:
            [self testNSBlockOperation];

            break;
        case 2:
            [self testWHOperation];
            
            break;
        case 3:
            [self testNSBlockOperationExecution];
            
            break;
        case 4:
            [self testAddOperation];

            break;
        case 5:
            [self testAddOperationWithBlock];

            break;
        case 6:
            [self communicationBetweenThread];
            
            break;
        case 7:
            [self testMaxConcurrentOperationCount];

            break;
        case 8:
            [self testAddDependency];

            break;
        default:
            break;
    }
    
}

/** NSInvocationOperation的使用 */
- (void)testNSInvocationOperation {
    // 创建NSInvocationOperation
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperation) object:nil];
    // 开始执行操作
    [invocationOperation start];
}

- (void)invocationOperation {
    NSLog(@"NSInvocationOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
}

/** NSBlockOperation的使用 */
- (void)testNSBlockOperation {
    // 把任务放到block中
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
    }];
    
    [blockOperation start];
}

/** 运用继承自NSOperation的子类 */
- (void)testWHOperation {
    BN_Operation *operation = [[BN_Operation alloc] init];
    [operation start];
}

/** addExecutionBlock:实现多线程 */
- (void)testNSBlockOperationExecution {
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation运用addExecutionBlock========%@", [NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务1========%@", [NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务2========%@", [NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"addExecutionBlock方法添加任务3========%@", [NSThread currentThread]);
    }];
    
    [blockOperation start];
}

/** addOperation把任务添加到队列 */
- (void)testAddOperation {
    // 创建队列，默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 创建操作，NSInvocationOperation
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationAddOperation) object:nil];
    // 创建操作，NSBlockOperation
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperation把任务%@添加到队列======%@",@(i), [NSThread currentThread]);
        }
    }];
    
    [queue addOperation:invocationOperation];
    [queue addOperation:blockOperation];
}

- (void)invocationOperationAddOperation {
    NSLog(@"invocationOperation===addOperation把任务添加到队列==========%@", [NSThread currentThread]);
}

/** addOperationWithBlock把任务添加到队列 */
- (void)testAddOperationWithBlock {
    // 创建队列，默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 添加操作到队列
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperationWithBlock把任务%@添加到队列======%@",@(i), [NSThread currentThread]);
        }
    }];
}

/** 线程间通信 */
- (void)communicationBetweenThread {
    NSLog(@"Waiting...");
//    [SVProgressHUD showWithStatus:@"Waiting..."];
    
    // 创建队列，默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 在子线程进行耗时操作
    [queue addOperationWithBlock:^{
        // 耗时操作放在这里，例如下载图片。（运用线程休眠三秒来模拟耗时操作）
        [NSThread sleepForTimeInterval:3];
        UIImage *image = [UIImage imageNamed:@"test"];
        
        // 回到主线程进行UI操作
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 在主线程上添加图片
            self.imageView.image = image;
            
            self.hideImageViewButton.hidden = NO;
            self.imageView.hidden = NO;
//            [SVProgressHUD dismiss];
            NSLog(@"finish...");

        }];
    }];
}

/** 最大并发数 */
- (void)testMaxConcurrentOperationCount {
    // 创建队列，默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 并发数为1，串行
    queue.maxConcurrentOperationCount = 1;
    // 并发数为2，并发
    queue.maxConcurrentOperationCount = 2;
    
    
    // 添加操作到队列
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperationWithBlock把任务添加到队列1======%@", [NSThread currentThread]);
        }
    }];
    
    // 添加操作到队列
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperationWithBlock把任务添加到队列2======%@", [NSThread currentThread]);
        }
    }];
    
    // 添加操作到队列
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperationWithBlock把任务添加到队列3======%@", [NSThread currentThread]);
        }
    }];
}

/** 操作依赖 */
- (void)testAddDependency {
    
    // 并发队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 操作1
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"operation1======%@", [NSThread  currentThread]);
        }
    }];
    
    // 操作2
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"****operation2依赖于operation1，只有当operation1执行完毕，operation2才会执行****");
        for (int i = 0; i < 3; i++) {
            NSLog(@"operation2======%@", [NSThread  currentThread]);
        }
    }];
    
    // 使操作2依赖于操作1
    [operation2 addDependency:operation1];
    
    // 把操作加入队列
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
