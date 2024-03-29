//
//  ChannleListController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/13.
//  Copyright © 2019 BN. All rights reserved.
//

#import "ChannleListController.h"
#import <SVProgressHUD.h>

#import <SDWebImage.h>

#import <YYModel/YYModel.h>
#import "PKDeviceListRootModel.h"
#import "PKChannelListRootModel.h"

#import "ChannelSteamController.h"
#import "BNChannelListApi.h"

@interface ChannleListController ()

@property(nonatomic, strong) NNTablePlainView * plainView;
@property(nonatomic, strong) BNChannelListApi * channelListApi;

@end

@implementation ChannleListController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    self.plainView.frame = self.view.bounds;
    [self.view addSubview:self.plainView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self requestChannelList];
    
}

#pragma mark -funtions

- (void)requestChannelList{
    [SVProgressHUD showWithStatus:kNetWorkRequesting];

    self.channelListApi.ID = self.deviceModel.ID;
    [self.channelListApi requestWithSuccess:^(NNRequstManager * _Nonnull manager, NSDictionary * _Nonnull jsonData) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            PKChannelListRootModel *rootModel = [PKChannelListRootModel yy_modelWithJSON:jsonData];
            self.plainView.list = rootModel.EasyDarwin.Body.Channels.mutableCopy;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.plainView.tableView reloadData];
            });
        });
    } fail:^(NNRequstManager * _Nonnull manager, NSError * _Nonnull error) {
        DDLog(@"%@", error);
    }];
}

#pragma mark -lazy
- (NNTablePlainView *)plainView{
    if (!_plainView) {
        _plainView = [[NNTablePlainView alloc]init];
        _plainView.tableView.rowHeight = 80;
        
        @weakify(self);
        _plainView.blockCellForRow = ^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            static NSString * identifier = @"cell";
            UITableViewCell * cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];
            
            PKChannelInfoModel * model = self.plainView.list[indexPath.row];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.SnapURL] placeholderImage:[UIImage imageNamed:@"bug.png"]];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = model.Name;
            cell.detailTextLabel.text = model.SnapURL;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        };
        
        _plainView.blockDidSelectRow = ^(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            PKChannelInfoModel * model = self.plainView.list[indexPath.row];
            ChannelSteamController *controller = [[ChannelSteamController alloc]init];
            controller.channelModel = model;
//            controller.deviceModel = model;

            [self.navigationController pushViewController:controller animated:true];
        };
    }
    return _plainView;
}

-(BNChannelListApi *)channelListApi{
    if (!_channelListApi) {
        _channelListApi = [[BNChannelListApi alloc]init];
        _channelListApi.limit = 12;
        _channelListApi.start = 0;
    }
    return _channelListApi;
}

@end
