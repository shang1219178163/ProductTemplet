//
//  GCD.h
//  
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNGCD : NSObject

void BNdispatchTimer(id target, double timeInterval,void (^handler)(dispatch_source_t timer));

@end
