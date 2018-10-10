//
//  BN_Language.h
//  HuiZhuBang
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BN_Language : NSObject

@property (class, nonatomic, strong, nullable) NSString *userLanguage;
@property (class, nonatomic, strong, nullable) NSNumber *languageType;
/**
 重置系统语言
 */
+(void)resetSystemLanguage;

+(NSArray *)list;

@end
