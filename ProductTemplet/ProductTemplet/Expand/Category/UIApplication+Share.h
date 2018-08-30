//
//  UIApplication+Share.h
//  HuiZhuBang
//
//  Created by BIN on 2017/12/28.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BINShareDataModel.h"

@interface UIApplication (Share)

+ (void)registerShareSDK;

+ (void)handleMsgShareDataModel:(BINShareDataModel *)dataModel patternType:(NSString *)patternType;

@end
