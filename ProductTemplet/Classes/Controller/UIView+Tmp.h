//
//  UIView+Tmp.h
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/18.
//  Copyright © 2019 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Tmp)

+ (__kindof UITextField *)createTextFieldPwdRect:(CGRect)rect image:(UIImage *)image imageSelected:(UIImage *)imageSelected;

@end

NS_ASSUME_NONNULL_END
