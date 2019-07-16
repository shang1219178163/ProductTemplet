//
//  StrategyFinancyAlipay.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "StrategyFinancyAlipay.h"

@implementation StrategyFinancyAlipay

- (NSInteger)financyWithMonth:(NSInteger)month money:(NSInteger)money {
    //    ​定期理财3个月，年化收益：7%
    //    ​​​定期理财6个月，年化收益：8%
    //    ​​​定期理财12个月，年化收益：9.5%
    //    ​​​定期理财24个月，年化收益：10.5%
    
    if (month <= 3) {
        return money * 0.07f / 12 * month + money;
    } else if (month <= 6) {
        return money * 0.08f / 12 * month + money;
    } else if (month <= 12) {
        return money * 0.095f / 12 * month + money;
    } else if (month <= 24) {
        return money * 0.105f / 12 * month + money;
    }
    return 0;
}

@end
