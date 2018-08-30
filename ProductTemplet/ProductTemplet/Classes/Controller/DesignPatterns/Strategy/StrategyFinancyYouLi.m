//
//  StrategyFinancyYouLi.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "StrategyFinancyYouLi.h"

@implementation StrategyFinancyYouLi

- (NSInteger)financyWithMonth:(NSInteger)month money:(NSInteger)money {
    //    短期理财：6个月以内，年化收益：3%
    //    ​​​中期理财：12个月以内，年化收益：4%
    //    ​​​长期理财：24个月以内，年化收益：4.5%
    
    if (month <= 6) {
        return money * 0.03f / 12 * month + money;
    } else if (month <= 12) {
        return money * 0.04f / 12 * month + money;
    } else if (month <= 24) {
        return money * 0.045f / 12 * month + money;
    }
    
    return 0;
}

@end
