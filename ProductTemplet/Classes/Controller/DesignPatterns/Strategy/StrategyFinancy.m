//
//  BaseCharge.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "StrategyFinancy.h"

@implementation StrategyFinancy

- (instancetype)initWithFinancy:(id<StrategyFinancyProtocal>)financy {
    self = [super init];
    if (self) {
        _financy = financy;
    }
    return self;
}

- (NSInteger)financyWithMonth:(NSInteger)month money:(NSInteger)money {
    return [_financy financyWithMonth:month money:money];
}

@end
