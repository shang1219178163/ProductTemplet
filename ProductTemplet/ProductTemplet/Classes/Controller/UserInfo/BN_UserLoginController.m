//
//  BN_UserLoginController.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/4.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_UserLoginController.h"

#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import "UIViewController+Helper.h"

@interface BN_UserLoginController ()

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UITextField * textFieldName;
@property (nonatomic, strong) UITextField * textFieldPwd;
@property (nonatomic, strong) UIButton * btnPwd;
@property (nonatomic, strong) UIButton * btnLogin;
@property (nonatomic, strong) UIButton * btnRegister;

@end

@implementation BN_UserLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"登录";
    
    [self createControls];
    
    [self.view getViewLayer];
}

- (void)createControls{
    
    CGFloat padding = 20;
    CGSize imgViewSize = CGSizeMake(65, 65);
    CGSize btnPwdSize = CGSizeMake(90, 30);
    CGFloat height = 35;
    
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(40);
        make.centerX.equalTo(self.view.mas_centerX);
        
        make.size.equalTo(imgViewSize);
    }];
    
    [self.view addSubview:self.textFieldName];
    [self.textFieldName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        
        make.width.height.equalTo(height);
        
    }];
    
    [self.view addSubview:self.textFieldPwd];
    [self.textFieldPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldName.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-(padding*2 + btnPwdSize.width));
        
        make.height.equalTo(height);
    }];
    
    [self.view addSubview:self.btnPwd];
    [self.btnPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPwd).offset(0);
        make.left.equalTo(self.textFieldPwd.right).offset(padding);
        make.right.equalTo(self.textFieldName).offset(0);
        
        make.size.equalTo(btnPwdSize);
    }];
    
    [self.view addSubview:self.btnLogin];
    [self.btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPwd.bottom).offset(padding);
        make.left.right.equalTo(self.textFieldName).offset(0);
        
        make.height.equalTo(height);
    }];
    
    [self.view addSubview:self.btnRegister];
    [self.btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnLogin.bottom).offset(padding);
        make.left.right.equalTo(self.textFieldName).offset(0);
        
        make.height.equalTo(height);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - layz

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView * imgView = [[UIImageView alloc]init];
            imgView.backgroundColor = UIColor.randomColor;
            
            imgView;
        });
    }
    return _imgView;
}

-(UITextField *)textFieldName{
    if (!_textFieldName) {
        _textFieldName = ({
            UITextField * textField = [[UITextField alloc]init];
            textField.placeholder = @"请输入手机号";
            textField.backgroundColor = UIColor.backgroudColor;

            textField;
        });
    }
    return _textFieldName;
}

-(UITextField *)textFieldPwd{
    if (!_textFieldPwd) {
        _textFieldPwd = ({
            UITextField * textField = [[UITextField alloc]init];
            textField.placeholder = @"请输入密码";
            textField.backgroundColor = UIColor.backgroudColor;
            
            textField;
        });
    }
    return _textFieldPwd;
}

-(UIButton *)btnLogin{
    if (!_btnLogin) {
        _btnLogin = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageFromColor(UIColor.themeColor) forState:UIControlStateNormal];
            [btn addActionHandler:^(id obj, id item, NSInteger idx) {

                
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
            [btn addActionHandler:^(id obj, id item, NSInteger idx) {
                [self goController:@"BN_UserPwdChangeController" title:@"修改密码"];
                
            }];
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
            [btn addActionHandler:^(id obj, id item, NSInteger idx) {
                [self goController:@"BN_UserRegisterController" title:@"注册"];

            }];

            btn;
        });
    }
    return _btnRegister;
}


@end
