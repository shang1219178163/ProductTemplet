//
//  NumberInputValidator.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NumberInputValidator.h"

@implementation NumberInputValidator

- (void)configValidateInfo {
    self.regExpressPatter = @"^[0-9]*$";
    self.descriptionStr = NSLocalizedString(@"验证失败", @"");
    self.reason = NSLocalizedString(@"输入仅能包含数字", @"");
    self.errorCode = 1001;
}

@end
