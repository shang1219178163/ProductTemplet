//
//  CustomTextField.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (BOOL)validate {
    // 在这里调用该方法，对其不同的部分进行配置。
    [_inputValidator configValidateInfo];
    
    NSError *error = nil;
    BOOL validationResult = [_inputValidator validateInput:self error:&error];
    
    if (!validationResult) {
        DDLog(@"%@\n%@",error.localizedDescription,error.localizedFailureReason);

    }
    return validationResult;
}


@end
