//
//  LoginViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import "LoginViewController.h"
#import "BNUserLoginApi.h"
#import <SVProgressHUD.h>

#import "BNUserLoginView.h"


@interface LoginViewController ()

@property(nonatomic, strong) BNUserLoginApi * userLoginApi;
@property(nonatomic, strong) BNUserLoginView * userLoginView;

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";

    [[SVProgressHUD appearance] setDefaultStyle:SVProgressHUDStyleDark];
    [[SVProgressHUD appearance] setMaximumDismissTimeInterval:1.0];

//    [self requestLogin];
    
    
    [self.view addSubview:self.userLoginView];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


#pragma mark -funtions

- (void)requestLogin{

    [SVProgressHUD showWithStatus:kNetWorkRequesting];
    [self.userLoginApi requestWithSuccess:^(NNRequstManager * _Nonnull manager, NSDictionary * _Nonnull jsonData) {
        NSDictionary *dic = jsonData;
        [NSUserDefaults setObject:dic[@"Token"] forKey:@"token"];
        [NSUserDefaults setObject:dic[@"TokenTimeout"] forKey:@"tokenTimeout"];
        [NSUserDefaults synchronize];
        
        [SVProgressHUD dismiss];
        [self.navigationController pushVC:@"DeviceListController" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
            vc.title = @"设备列表";

        }];
    } fail:^(NNRequstManager * _Nonnull manager, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:error.description];
    }];
}

#pragma mark -lazy

-(BNUserLoginApi *)userLoginApi{
    if (!_userLoginApi) {
        _userLoginApi = [[BNUserLoginApi alloc]init];
        _userLoginApi.name = @"admin";
        _userLoginApi.password = @"admin";
    }
    return _userLoginApi;
}

-(BNUserLoginView *)userLoginView{
    if (!_userLoginView) {
        _userLoginView = [[BNUserLoginView alloc]initWithFrame:self.view.bounds];
        [_userLoginView.btnPwd addActionHandler:^(UIButton * _Nonnull control) {
            [self.navigationController pushVC:@"ChangePwdController" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
                vc.title = @"修改密码";
            }];
            
        } forControlEvents:UIControlEventTouchUpInside];
        _userLoginView.block = ^(BNUserLoginView * _Nonnull view) {
            DDLog(@"登录!");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                view.btnLogin.hidden = false;

            });
        };
    }
    return _userLoginView;
}


@end
