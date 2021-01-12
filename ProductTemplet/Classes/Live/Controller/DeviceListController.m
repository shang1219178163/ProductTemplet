//
//  DeviceListController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import "DeviceListController.h"
#import <SVProgressHUD.h>

#import <YYModel/YYModel.h>
#import "PKDeviceListRootModel.h"
#import "PKSeverinfoModel.h"

#import "BNUserInfoApi.h"
#import "BNDeviceListApi.h"
#import "BNUserLogoutApi.h"
#import "ChannleListController.h"

@interface DeviceListController ()

@property(nonatomic, strong) NNTablePlainView * plainView;
@property(nonatomic, strong) BNDeviceListApi * deviceListApi;
@property(nonatomic, strong) BNUserLogoutApi * userLogoutApi;

@property(nonatomic, strong) BNUserInfoApi * userInfoApi;

@end

@implementation DeviceListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备列表";
    
    self.plainView.frame = self.view.bounds;
    [self.view addSubview:self.plainView];
    
    [self createBarItem:@"注销" isLeft:true handler:^(id obj, UIView *item, NSInteger idx) {
        [self requestLogout];
        
    }];
    
    [self createBarItem:@"用户信息" isLeft:false handler:^(id obj, UIView *item, NSInteger idx) {
        [self requestSeverinfo];
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestDeviceList];
}

#pragma mark -funtions

- (void)requestDeviceList{
    
    [SVProgressHUD showWithStatus:kNetWorkRequesting];
    [self.deviceListApi requestWithSuccess:^(NNRequstManager * _Nonnull manager, NSDictionary * _Nonnull jsonData) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            PKDeviceListRootModel *rootModel = [PKDeviceListRootModel yy_modelWithJSON:jsonData];
            self.plainView.list = [rootModel.DeviceList mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.plainView.tableView reloadData];
            });
        });
    } fail:^(NNRequstManager * _Nonnull manager, NSError * _Nonnull error) {
        DDLog(@"%@", error);

    }];
}

- (void)requestLogout{
    [SVProgressHUD showWithStatus:kNetWorkRequesting];
    [self.userLogoutApi requestWithSuccess:^(NNRequstManager * _Nonnull manager, NSDictionary * _Nonnull jsonData) {
        DDLog(@"%@", jsonData);
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:true];
        
    } fail:^(NNRequstManager * _Nonnull manager, NSError * _Nonnull error) {
        DDLog(@"%@", error);
    }];
}

- (void)requestSeverinfo{
    
    [SVProgressHUD showWithStatus:kNetWorkRequesting];

    [self.userInfoApi requestWithSuccess:^(NNRequstManager * _Nonnull manager, NSDictionary * _Nonnull jsonData) {
            
        } fail:^(NNRequstManager * _Nonnull manager, NSError * _Nonnull error) {
            
        }];
}


#pragma mark -lazy

- (NNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[NNTablePlainView alloc]init];
        _plainView.tableView.rowHeight = 70;
        
        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            static NSString * identifier = @"cell";
            UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];
            
            PKDeviceInfoModel * model = self.plainView.list[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = model.Name;
            cell.detailTextLabel.text = model.CreatedAt;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        };
        
        _plainView.blockDidSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            PKDeviceInfoModel * model = self.plainView.list[indexPath.row];
            ChannleListController *controller = [[ChannleListController alloc]init];
            controller.deviceModel = model;
            [self.navigationController pushViewController:controller animated:true];
        };
    }
    return _plainView;
}

-(BNDeviceListApi *)deviceListApi{
    if (!_deviceListApi) {
        _deviceListApi = [[BNDeviceListApi alloc]init];
        _deviceListApi.limit = 10;
        _deviceListApi.online = true;
    }
    return _deviceListApi;
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

@end
