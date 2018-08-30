//
//  BN_Operation.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/31.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_Operation.h"

@implementation BN_Operation

- (void)main {
    for (int i = 0; i < 3; i++) {
        NSLog(@"NSOperation的子类Operation======%@",[NSThread currentThread]);
    }
}

@end
