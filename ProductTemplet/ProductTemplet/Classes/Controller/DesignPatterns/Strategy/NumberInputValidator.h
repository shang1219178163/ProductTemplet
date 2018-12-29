//
//  NumberInputValidator.h
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "InputValidator.h"

@interface NumberInputValidator : InputValidator

/**
 *  这里重新声明了这个方法，以强调这个子类实现或重写了什么，这不是必须的，但是是个好习惯。
 */
- (void)configValidateInfo;

@end
