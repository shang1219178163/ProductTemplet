//
//  BaseCharge.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StrategyFinancyProtocal.h"

#import "StrategyFinancyAlipay.h"
#import "StrategyFinancyYouLi.h"

@interface StrategyFinancy : NSObject

@property (nonatomic, strong) id<StrategyFinancyProtocal> financy;

- (instancetype)initWithFinancy:(id<StrategyFinancyProtocal>)financy;

- (NSInteger)financyWithMonth:(NSInteger)month money:(NSInteger)money;

@end
