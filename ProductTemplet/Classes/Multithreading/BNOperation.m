//
//  BNOperation.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BNOperation.h"

@implementation BNOperation

- (void)main {
    //自己创建自动释放池（因为如果是异步操作，无法访问主线程的自动释放池）
    @autoreleasepool {
        for (int i = 0; i < 3; i++) {
            NSLog(@"NSOperation的子类Operation======%@",NSThread.currentThread);
        }
        
    };
    
   
}

@end