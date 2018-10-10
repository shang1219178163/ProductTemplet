//
//  NSBundle+Language.h
//  HuiZhuBang
//
//  Created by BIN on 2018/9/12.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BN_Language.h"

@interface NSBundle (Language)

+ (BOOL)isChineseLanguage;

+ (NSString *)currentLanguage;

@end
