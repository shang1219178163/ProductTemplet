//
//  BNPwdModifyView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/14.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNPwdModifyView.h"

@implementation BNPwdModifyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

- (void)createControls{
    [self addSubview:self.textFieldPwd];
    [self.textFieldPwd makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(40);
    }];
    
    [self addSubview:self.textFieldConfirm];
    [self.textFieldConfirm makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPwd.bottom).offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(40);
    }];
    
    [self addSubview:self.btn];
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldConfirm.bottom).offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(45);
    }];
}


#pragma mark - - textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    
}

#pragma mark -lazy

-(UITextField *)textFieldPwd{
    if (!_textFieldPwd) {
        _textFieldPwd = ({
            UITextField * textField = [[UITextField alloc]init];
            textField.placeholder = @"  请输入密码";
            textField.backgroundColor = UIColorHexValue(0xE9E9E9);
            textField.clearsOnBeginEditing = YES;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.delegate = self;
            textField;
        });
    }
    return _textFieldPwd;
}

-(UITextField *)textFieldConfirm{
    if (!_textFieldConfirm) {
        _textFieldConfirm = ({
            UITextField * textField = [[UITextField alloc]init];
            textField.placeholder = @"  请重复密码";
            textField.backgroundColor = UIColorHexValue(0xE9E9E9);
            textField.clearsOnBeginEditing = YES;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.delegate = self;
            textField;
        });
    }
    return _textFieldConfirm;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIView createBtnRect:CGRectZero title:@"确定" image:nil type:@1];
    }
    return _btn;
}

@end

