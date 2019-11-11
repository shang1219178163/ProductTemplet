//
//  BNPhoneCodeView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/14.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNPhoneCodeView.h"

@implementation BNPhoneCodeView

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
    [self addSubview:self.textFieldPhone];
    [self.textFieldPhone makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(40);
    }];
    
    [self addSubview:self.textFieldCode];
    [self.textFieldCode makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPhone.bottom).offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15-80);
        make.height.equalTo(40);
    }];
    
    [self addSubview:self.btnCode];
    [self.btnCode makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldCode).offset(5);
        make.left.equalTo(self.textFieldCode.right).offset(8);
        make.right.equalTo(self.textFieldPhone.right);
        make.bottom.equalTo(self.textFieldCode).offset(-5);
    }];
    
    [self addSubview:self.btn];
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldCode.bottom).offset(15);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(45);
    }];
    
    self.btnCode.layer.masksToBounds = YES;
    self.btnCode.layer.cornerRadius = 8.0;
    
    self.btnCode.layer.borderColor = UIColor.themeColor.CGColor;
    self.btnCode.layer.borderWidth = kW_LayerBorder;
}


#pragma mark - - textField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
 
    
}

#pragma mark -lazy

-(UITextField *)textFieldPhone{
    if (!_textFieldPhone) {
        _textFieldPhone = ({
            UITextField * textField = [[UITextField alloc]init];
            textField.placeholder = @"  请输入手机号";
            textField.backgroundColor = UIColorHexValue(0xE9E9E9);
            textField.clearsOnBeginEditing = YES;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.delegate = self;
            textField;
        });
    }
    return _textFieldPhone;
}

-(UITextField *)textFieldCode{
    if (!_textFieldCode) {
        _textFieldCode = ({
            UITextField * textField = [[UITextField alloc]init];
            textField.placeholder = @"  请输入验证码";
            textField.backgroundColor = UIColorHexValue(0xE9E9E9);
            textField.clearsOnBeginEditing = YES;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.delegate = self;
            textField;
        });
    }
    return _textFieldCode;
}

- (UIButton *)btnCode{
    if (!_btnCode) {
        _btnCode = [UIButton createRect:CGRectZero title:@"验证码" image:nil type:@4];
    }
    return _btnCode;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton createRect:CGRectZero title:@"确定" image:nil type:@1];
    }
    return _btn;
}

@end
