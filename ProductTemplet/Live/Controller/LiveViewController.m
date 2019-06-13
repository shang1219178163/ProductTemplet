//
//  LiveViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 BN. All rights reserved.
//

#import "LiveViewController.h"
#import "BNAPIConfi.h"

#import "BNUserLoginApi.h"
#import "BNUserLogoutApi.h"
#import "BNMoidyPwdApi.h"
#import "BNRestartApi.h"

#import "BNUserInfoApi.h"
#import "BNServerinfoApi.h"


#import <YYModel/YYModel.h>
#import "PKSeverinfoModel.h"

@interface LiveViewController ()

@property(nonatomic, strong) BNUserLoginApi * userLoginApi;
@property(nonatomic, strong) BNUserLogoutApi * userLogoutApi;

@property(nonatomic, strong) BNMoidyPwdApi * moidyPwdApi;
@property(nonatomic, strong) BNRestartApi * restartApi;

@property(nonatomic, strong) BNUserInfoApi * userInfoApi;
@property(nonatomic, strong) BNServerinfoApi * serverinfoApi;

@property(nonatomic, strong) UISegmentedControl * segmentCtl;

@end

@implementation LiveViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Live";
    
    [self.view addSubview:self.segmentCtl];
    
    [self createBarItem:@"登录" isLeft:true handler:^(id obj, UIView *item, NSInteger idx) {
    
        
    }];
    
    [self createBarItem:@"注销" isLeft:false handler:^(id obj, UIView *item, NSInteger idx) {

        [self.userLogoutApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", responseObject);

        } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", error);

        }];
    }];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.userLoginApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        DDLog(@"%@", responseObject);
        if (![responseObject isKindOfClass:NSDictionary.class]) {
            return ;
        }        
        NSDictionary *dic = responseObject;
        [NSUserDefaults setObject:dic[@"Token"] forKey:@"token"];
        [NSUserDefaults setObject:dic[@"TokenTimeout"] forKey:@"tokenTimeout"];
        [NSUserDefaults synchronize];
        
        [self.userInfoApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", responseObject);

        } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", error);
            
        }];
        
        [self.serverinfoApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", responseObject);
            PKSeverinfoModel *model = [PKSeverinfoModel yy_modelWithJSON:responseObject];
            DDLog(@"%@", model.description);

        } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", error);
            
        }];

    } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        DDLog(@"%@", error);

    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.segmentCtl.frame = CGRectMake(0, 20, kScreenWidth, 50);

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

-(BNUserLogoutApi *)userLogoutApi{
    if (!_userLogoutApi) {
        _userLogoutApi = [[BNUserLogoutApi alloc]init];
    }
    return _userLogoutApi;
}

-(BNUserInfoApi *)userInfoApi{
    if (!_userInfoApi) {
        _userInfoApi = [[BNUserInfoApi alloc]init];
    }
    return _userInfoApi;
}

-(BNServerinfoApi *)serverinfoApi{
    if (!_serverinfoApi) {
        _serverinfoApi = [[BNServerinfoApi alloc]init];
    }
    return _serverinfoApi;
}

-(BNMoidyPwdApi *)moidyPwdApi{
    if (!_moidyPwdApi) {
        _moidyPwdApi = [[BNMoidyPwdApi alloc]init];
        _moidyPwdApi.oldpassword = @"shang";
        _moidyPwdApi.newpassword = @"shang";

    }
    return _moidyPwdApi;
}

-(BNRestartApi *)restartApi{
    if (!_restartApi) {
        _restartApi = [[BNRestartApi alloc]init];
    }
    return _restartApi;
}

-(UISegmentedControl *)segmentCtl{
    if (!_segmentCtl) {
        NSArray * items = @[@"修改密码",@"重启服务",@"111",@"111",@"111",];
        _segmentCtl = [UIView createSegmentRect:CGRectZero items:items selectedIndex:0 type:@1];
        [_segmentCtl addActionHandler:^(UIControl * _Nonnull control) {
            UISegmentedControl *sender = control;
            switch (sender.selectedSegmentIndex) {
                case 0:
                {
                    NSString * url = [BNAPIConfi.serviceUrl stringByAppendingPathComponent:self.moidyPwdApi.requestURI];
                    [APIRequestURL requestUrl:url method:kHTTPMethodGET completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        DDLog(@"%@",string);
                    }];
                }
                    break;
                case 1:
                {
                    NSString * url = [BNAPIConfi.serviceUrl stringByAppendingPathComponent:self.restartApi.requestURI];
                    [APIRequestURL requestUrl:url method:kHTTPMethodGET completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                        DDLog(@"%@",string);
                    }];
                }
                    break;
                case 2:
                {
                    
                }
                    break;
                default:
                    break;
            }
            
        } forControlEvents:UIControlEventValueChanged];
    }
    return _segmentCtl;
}

@end
