//
//  AlphaInputValidator.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "AlphaInputValidator.h"

@implementation AlphaInputValidator

- (void)configValidateInfo {
    self.regExpressPatter = @"^[a-zA-Z]*$";
    self.descriptionStr = NSLocalizedString(@"验证失败", @"");
    self.reason = NSLocalizedString(@"输入仅能包字母", @"");
    self.errorCode = 1002;
}

@end
