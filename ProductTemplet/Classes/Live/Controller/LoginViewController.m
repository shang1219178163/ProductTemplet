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
    [self.userLoginApi requestWithSuccessBlock:^(NNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        DDLog(@"%@", responseObject);
        if (![responseObject isKindOfClass:NSDictionary.class]) {
            return ;
        }
        NSDictionary *dic = responseObject;
        [NSUserDefaults setObject:dic[@"Token"] forKey:@"token"];
        [NSUserDefaults setObject:dic[@"TokenTimeout"] forKey:@"tokenTimeout"];
        [NSUserDefaults synchronize];
        
        [SVProgressHUD dismiss];
        [self pushVC:@"DeviceListController" title:@"设备列表" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
            
        }];
    } failedBlock:^(NNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
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
        [_userLoginView.btnPwd addActionHandler:^(UIControl * _Nonnull control) {
            [self pushVC:@"ChangePwdController" title:@"修改密码" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
                
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
