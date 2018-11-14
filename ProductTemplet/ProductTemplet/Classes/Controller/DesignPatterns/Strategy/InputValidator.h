//
//  InputValidator.h
//  ProductTemplet
//
//  Created by hsf on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

/*
 输入验证
 */

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const InputValidationErrorDomain = @"InputValidationErrorDomain";

@interface InputValidator : NSObject

/**
 *  这些属性的值，由其子类提供来进行配置的。
 */
@property (nonatomic, copy) NSString *regExpressPatter;
@property (nonatomic, copy) NSString *descriptionStr;
@property (nonatomic, copy) NSString *reason;
@property (nonatomic, assign) NSInteger errorCode;
/**
 *  实际验证策略的存根方法
 */
- (BOOL)validateInput:(UITextField *)input error:(NSError *__autoreleasing *)error;

/**
 *  配置与验证相关的信息，这个要求子类必须重写，不进行重写的话，就抛出异常。
 */
- (void)configValidateInfo;

/**
 *  配置一些额外的信息，留给将来扩展来使用。
 */
- (void)configExtraInfo;

@end
