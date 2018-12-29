//
//  CustomTextField.h
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputValidator.h"

@interface CustomTextField : UITextField

@property (nonatomic, strong) InputValidator *inputValidator; //用一个属性保持对InputValidator的引用。

- (BOOL)validate;

@end
