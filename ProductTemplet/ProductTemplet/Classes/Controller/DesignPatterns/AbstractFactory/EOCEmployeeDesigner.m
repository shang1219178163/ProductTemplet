//
//  EOCEmployeeDesigner.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "EOCEmployeeDesigner.h"

@implementation EOCEmployeeDesigner

- (void)doADaysWork{
    [super doADaysWork];

    [self workToDesigner];
}

- (void)workToDesigner{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
}

@end
