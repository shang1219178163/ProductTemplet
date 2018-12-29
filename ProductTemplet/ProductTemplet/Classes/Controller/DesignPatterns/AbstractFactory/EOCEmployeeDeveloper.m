//
//  EOCEmployeeDeveloper.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "EOCEmployeeDeveloper.h"

@implementation EOCEmployeeDeveloper

- (void)doADaysWork{
    [super doADaysWork];
    
    [self workToWriteCode];
}

- (void)workToWriteCode{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
}

@end
