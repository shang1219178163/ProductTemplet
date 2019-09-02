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
#import "BNDeviceListApi.h"
#import "BNChannelListApi.h"
#import "BNChannelstreamApi.h"

#import <YYModel/YYModel.h>
#import "PKSeverinfoModel.h"
#import "PKDeviceListRootModel.h"

@interface LiveViewController ()

@property(nonatomic, strong) NNItemsView * itemsView;

@property(nonatomic, strong) BNUserLoginApi * userLoginApi;
@property(nonatomic, strong) BNUserLogoutApi * userLogoutApi;

@property(nonatomic, strong) BNMoidyPwdApi * moidyPwdApi;
@property(nonatomic, strong) BNRestartApi * restartApi;

@property(nonatomic, strong) BNUserInfoApi * userInfoApi;
@property(nonatomic, strong) BNServerinfoApi * serverinfoApi;

@property(nonatomic, strong) BNDeviceListApi * deviceListApi;
@property(nonatomic, strong) BNChannelListApi * channelListApi;
@property(nonatomic, strong) BNChannelstreamApi * channelstreamApi;

@property(nonatomic, strong) PKDeviceListRootModel *devicesRootModel;

@end

@implementation LiveViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Live";
    
    [self.view addSubview:self.itemsView];

    [self createBarItem:@"登录" isLeft:true handler:^(id obj, UIView *item, NSInteger idx) {
        [self.userLoginApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", responseObject);
            if (![responseObject isKindOfClass:NSDictionary.class]) {
                return ;
            }
            NSDictionary *dic = responseObject;
            [NSUserDefaults setObject:dic[@"Token"] forKey:@"token"];
            [NSUserDefaults setObject:dic[@"TokenTimeout"] forKey:@"tokenTimeout"];
            [NSUserDefaults synchronize];
            
        } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            
        }];
        
    }];
    
    [self createBarItem:@"注销" isLeft:false handler:^(id obj, UIView *item, NSInteger idx) {

        [self.userLogoutApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", responseObject);

        } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", error);

        }];
    }];
    
    [self.view getViewLayer];
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
            DDLog(@"%@", model);

        } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
            DDLog(@"%@", error);
            
        }];

    } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        DDLog(@"%@", error);

    }];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.itemsView.frame = CGRectMake(10, 20, kScreenWidth, kScreenWidth);

}

#pragma mark -funtions

- (void)getInfoWithIndex:(NSInteger)index{
    DDLog(@"%@", @(index));
    switch (index) {
        case 0:
        {

            [self.moidyPwdApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id  _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@",responseObject);
                
            } failedBlock:^(BNRequstManager * _Nonnull manager, id  _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", error);
                
            }];
        }
            break;
        case 1:
        {
            [self.restartApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id  _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@",responseObject);
                
            } failedBlock:^(BNRequstManager * _Nonnull manager, id  _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", error);
                
            }];
        }
            break;
        case 2:
        {
            [self.userInfoApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", responseObject);
                
            } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", error);
                
            }];
        }
            break;
        case 3:
        {
            [self.deviceListApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", [(NSDictionary *)responseObject jsonString]);
                PKDeviceListRootModel *model = [PKDeviceListRootModel yy_modelWithJSON:responseObject];
                DDLog(@"%@", model);
                self.devicesRootModel = model;
                [self goController:@"DeviceListController" title:@"设备列表" obj:model];
                
            } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", error);
                
            }];
        }
            break;
        case 4:
        {
            [self.channelListApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", responseObject);
                
            } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", error);
                
            }];
        }
            break;
        case 5:
        {
            [self.channelstreamApi requestWithSuccessBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", responseObject);
                
            } failedBlock:^(BNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
                DDLog(@"%@", error);
                
            }];
        }
            break;
        default:
            break;
    }
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

-(BNDeviceListApi *)deviceListApi{
    if (!_deviceListApi) {
        _deviceListApi = [[BNDeviceListApi alloc]init];
        _deviceListApi.limit = 10;
        _deviceListApi.online = true;
    }
    return _deviceListApi;
}

-(BNChannelListApi *)channelListApi{
    if (!_channelListApi) {
        _channelListApi = [[BNChannelListApi alloc]init];
        _channelListApi.limit = 12;
        _channelListApi.start = 0;

    }
    return _channelListApi;
}

- (BNChannelstreamApi *)channelstreamApi{
    if (!_channelstreamApi) {
        _channelstreamApi = [[BNChannelstreamApi alloc]init];
        _channelstreamApi.protocol = @"FLV";
        _channelstreamApi.channel = 1;
    }
    return _channelstreamApi;
}

-(NNItemsView *)itemsView{
    if (!_itemsView) {
        _itemsView = [[NNItemsView alloc]init];
        _itemsView.backgroundColor = UIColor.greenColor;
        _itemsView.numberOfRow = 4;
        NSArray * items = @[@"修改密码",@"重启服务",@"用户信息",@"设备列表",@"通道列表",@"通道流",];
        _itemsView.items = items;
        _itemsView.block = ^(NNItemsView * _Nonnull itemsView, UIButton * _Nonnull btn) {
            [self getInfoWithIndex:btn.tag];
            
        };
    }
    return _itemsView;
}

@end
