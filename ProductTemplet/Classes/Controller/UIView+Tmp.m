//
//  UIView+Tmp.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/10/18.
//  Copyright © 2019 BN. All rights reserved.
//

#import "UIView+Tmp.h"
#import <objc/runtime.h>

@implementation UIView (Tmp)

+ (__kindof UITextField *)createTextFieldPwdRect:(CGRect)rect image:(UIImage *)image imageSelected:(UIImage *)imageSelected {
    UITextField *textField = [[self alloc]initWithFrame:rect];
    textField.placeholder = @"  请输入密码";
    textField.backgroundColor = UIColor.greenColor;
    textField.clearsOnBeginEditing = true;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.secureTextEntry = true;
    
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = ({
        CGRect imgViewRect = CGRectEqualToRect(CGRectZero, rect) ? CGRectMake(0, 0, 30, 30) : CGRectMake(0, 0, CGRectGetHeight(rect) - 5, CGRectGetHeight(rect) - 5);
        UIImageView *imgView = [[UIImageView alloc]initWithFrame: imgViewRect];
        imgView.userInteractionEnabled = true;
        imgView.contentMode = UIViewContentModeCenter;
//        imgView.backgroundColor = UIColor.redColor;
        imgView.image = image;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        //    tapGesture.cancelsTouchesInView = NO;
        //    tapGesture.delaysTouchesEnded = NO;
        [tap addActionBlock:^(UIGestureRecognizer * _Nonnull reco) {
//            DDLog(@"%@", reco)
            UIImageView * sender = (UIImageView *)reco.view;
            sender.selected = !sender.selected;
            sender.image = sender.selected == false ? image : imageSelected;
            
            NSString *tempPwdStr = textField.text;
            textField.text = @""; // 这句代码可以防止切换的时候光标偏移
            textField.secureTextEntry = !sender.selected;
            textField.text = tempPwdStr;
        }];
        
        [imgView addGestureRecognizer:tap];
        
        imgView;
    });
    return textField;
}


@end
