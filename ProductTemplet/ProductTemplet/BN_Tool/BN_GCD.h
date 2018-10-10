//
//  GCD.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/7.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BN_GCD : NSObject

void BN_dispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer));

@end
