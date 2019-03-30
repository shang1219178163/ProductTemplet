//
//  EOCEmployeeFinance.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "EOCEmployeeFinance.h"

@implementation EOCEmployeeFinance

- (void)doADaysWork{
    [super doADaysWork];

    [self workToFinance];
}

- (void)workToFinance{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
}

@end
