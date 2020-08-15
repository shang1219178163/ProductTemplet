//
//  BNUserLoginView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/14.
//  Copyright © 2019 BN. All rights reserved.
//

#import "BNUserLoginView.h"

@implementation BNUserLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createControls];
    
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imgView.layer.cornerRadius = CGRectGetHeight(self.imgView.bounds)*0.5;
    self.imgView.layer.masksToBounds = true;
}

- (void)createControls{
    
    CGFloat padding = 20;
    CGFloat height = 40;
    
    CGSize imgViewSize = CGSizeMake(75, 75);
    CGSize btnPwdSize = CGSizeMake(70, height);
    
    [self addSubview:self.imgView];
    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(40);
        make.centerX.equalTo(self.centerX);
        make.size.equalTo(imgViewSize);
    }];
    
    [self addSubview:self.textFieldName];
    [self.textFieldName makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.bottom).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.equalTo(height);
    }];
    
    [self addSubview:self.textFieldPwd];
    [self.textFieldPwd makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldName.bottom).offset(15);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-(padding*2 + btnPwdSize.width));
        make.height.equalTo(height);
    }];
    
    [self addSubview:self.btnPwd];
    [self.btnPwd makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPwd).offset(0);
        make.left.equalTo(self.textFieldPwd.right).offset(padding);
        make.right.equalTo(self.textFieldName).offset(0);
        make.size.equalTo(btnPwdSize);
    }];
    
    [self addSubview:self.btnLogin];
    [self.btnLogin makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPwd.bottom).offset(padding);
        make.left.right.equalTo(self.textFieldName).offset(0);
        make.height.equalTo(height);
    }];
    
    [self addSubview:self.btnRegister];
    [self.btnRegister makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnLogin.bottom).offset(padding);
        make.left.right.equalTo(self.textFieldName).offset(0);
        make.height.equalTo(height);
    }];
    
    [self addSubview:self.labEULA];
    [self.labEULA makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textFieldName).offset(0);
        make.height.equalTo(height);
        make.bottom.equalTo(self).offset( -kY_GAP);
    }];
    
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    [[[self superview] superview] endEditing:YES];
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSArray * array = @[self.textFieldName, self.textFieldPwd,];
    [array[textField.tag - kTAG_TEXTFIELD] setValue:textField.text forKey:@"text"];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self endEditing:YES];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (self.textFieldName == textField) {
        //只有手机号需要空格(需求调整,支持汉字)
        //       return [textField handlePhoneWithReplacementString:string];
        
    }
    
    if (self.textFieldPwd == textField) {
        return [textField backToEmptyWithReplacementString:string];
        
    }
    return YES;
}

#pragma mark -lazy

- (void)startAnimationWithSender:(UIButton *)sender {
    
    CALayer *layer0 = [sender.layer addAnimMask:@"mask"];
    CAAnimation * anim0 = [layer0 animationForKey:@"mask"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim0.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [layer0 removeFromSuperlayer];
        
        CALayer *layer1 = [sender.layer addAnimPackup:@"Packup"];
        CAAnimation * anim1 = [layer1 animationForKey:@"Packup"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(anim1.duration* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [layer1 removeFromSuperlayer];
            sender.hidden = YES;
            
            if (self.block) {
                self.block(self);
            }
        });
    });
}

#pragma mark - layz

//-(UIImageView *)imgView{
//    if (!_imgView) {
//        _imgView = ({
//            UIImageView * imgView = [[UIImageView alloc]init];
//            imgView.image = [UIImage imageNamed:@"img_logo"];
////            imgView.backgroundColor = [UIColor randomColor];
//            imgView.tag = kTAG_IMGVIEW;
//            imgView;
//        });
//    }
//    return _imgView;
//}

-(NNRotationView *)imgView{
    if (!_imgView) {
        _imgView = [[NNRotationView alloc]init];
        _imgView.imgView.image = UIApplication.appIcon;
        _imgView.isColorFollow = NO;
        _imgView.layerFront.strokeColor = UIColor.themeColor.CGColor;
        _imgView.tag = kTAG_IMGVIEW;
        
    }
    return _imgView;
}

-(UITextField *)textFieldName{
    if (!_textFieldName) {
        _textFieldName = ({
            UITextField * textField = [[UITextField alloc]init];
            textField.tag = kTAG_TEXTFIELD;
            textField.placeholder = @"  请输入手机号";
            textField.backgroundColor = UIColorHexValue(0xE9E9E9);
            textField.clearsOnBeginEditing = YES;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.font = [UIFont systemFontOfSize:13];

            textField.delegate = self;
            textField;
        });
    }
    return _textFieldName;
}

-(UITextField *)textFieldPwd{
    if (!_textFieldPwd) {
        _textFieldPwd = ({
            UITextField * textField = [[UITextField alloc]init];
            textField.tag = kTAG_TEXTFIELD+1;
            textField.placeholder = @"  请输入密码";
            textField.backgroundColor = UIColorHexValue(0xE9E9E9);
            textField.clearsOnBeginEditing = YES;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.font = [UIFont systemFontOfSize:13];
            textField.secureTextEntry = YES;
            textField.delegate = self;
            
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
            imgView.image = [UIImage imageNamed:self.pwdImagList[0]];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            
            UIImage * image = [UIImage imageNamed:self.pwdImagList[0]];
            UIImage * imageSelected = [UIImage imageNamed:self.pwdImagList[1]];
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 40, 40);
            [btn setBackgroundImage:image forState:UIControlStateNormal];
            [btn setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addActionHandler:^(id obj, id item, NSInteger idx) {
                UIButton * sender = obj;
                sender.selected = !sender.selected;
                
                if (sender.selected == YES) { // 按下去了就是明文
                    [sender setBackgroundImage:imageSelected forState:UIControlStateNormal];
                    
                    NSString *tempPwdStr = textField.text;
                    textField.text = @""; // 这句代码可以防止切换的时候光标偏移
                    textField.secureTextEntry = NO;
                    textField.text = tempPwdStr;
                    
                } else { // 暗文
                    [sender setBackgroundImage:image forState:UIControlStateNormal];
                    
                    NSString *tempPwdStr = textField.text;
                    textField.text = @"";
                    textField.secureTextEntry = YES;
                    textField.text = tempPwdStr;
                }
                
            }];
            
            textField.rightView = btn;
            textField.rightViewMode = UITextFieldViewModeAlways;
            textField;
        });
    }
    return _textFieldPwd;
}

-(UIButton *)btnLogin{
    if (!_btnLogin) {
        _btnLogin = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageWithColor:UIColor.themeColor] forState:UIControlStateNormal];
            [btn addActionHandler:^(id obj, id item, NSInteger idx) {
                [self endEditing:YES];
                [self startAnimationWithSender:item];
                
            }];
            
            btn;
        });
    }
    return _btnLogin;
}

-(UIButton *)btnPwd{
    if (!_btnPwd) {
        _btnPwd = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"忘记密码?" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];

            btn;
        });
    }
    return _btnPwd;
}

-(UIButton *)btnRegister{
    if (!_btnRegister) {
        _btnRegister = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"新用户?点击注册" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];

            btn;
        });
    }
    return _btnRegister;
}

-(UILabel *)labEULA{
    if (!_labEULA) {
        _labEULA = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.text = @"用户协议、隐私条款";
            label.textColor = UIColor.themeColor;
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentRight;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = [UIColor greenColor];          
            label.tag = kTAG_LABEL;

            label;
        });
    }
    return _labEULA;
}

@end

