//
//  BNThirdViewController.m
//
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NNThirdViewController.h"
#import "NNCheckVersApi.h"

@interface NNThirdViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSDictionary *> *dataList;

@end

@implementation NNThirdViewController

+ (void)initialize{
    if (self == [self class]) {
        DDLog(@"%@", @"NNThirdViewController");
    }
}

+ (void)load{
    DDLog(@"%@", @"NNThirdViewController");
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationItem.title = @"消息";

    [self.view addSubview:self.tbView];
    self.tbView.rowHeight = 64;
    self.tbView.tableFooterView = [UIView new];
    [self loadMessageList];
    [self.tbView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tbView.frame = self.view.bounds;
}

- (void)loadMessageList {
    self.dataList = @[
        @{@"title": @"系统通知", @"detail": @"欢迎使用 ProductTemplet", @"time": @"刚刚", @"badge": @"2"},
        @{@"title": @"活动助手", @"detail": @"本周有 3 场新活动待查看", @"time": @"10:20", @"badge": @"1"},
        @{@"title": @"订单消息", @"detail": @"你有一笔订单状态已更新", @"time": @"昨天", @"badge": @"0"},
        @{@"title": @"好友申请", @"detail": @"用户 A 请求添加你为好友", @"time": @"周一", @"badge": @"5"},
        @{@"title": @"客服中心", @"detail": @"您的反馈已收到，我们会尽快处理", @"time": @"03-12", @"badge": @"0"},
        @{@"title": @"安全提醒", @"detail": @"检测到新设备登录，请确认是否本人操作", @"time": @"03-10", @"badge": @"1"},
        @{@"title": @"圈子动态", @"detail": @"你关注的内容有 8 条新回复", @"time": @"03-08", @"badge": @"8"},
        @{@"title": @"版本更新", @"detail": @"发现新版本，点击查看更新内容", @"time": @"03-01", @"badge": @"0"},
    ].mutableCopy;
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MessageListCell";
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.textColor = UIColor.grayColor;
    cell.detailTextLabel.numberOfLines = 1;

    NSDictionary *item = self.dataList[indexPath.row];
    NSString *badge = item[@"badge"];
    NSString *title = item[@"title"];
    if (badge.integerValue > 0) {
        title = [NSString stringWithFormat:@"%@（%@）", title, badge];
    }
    cell.textLabel.text = title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  ·  %@", item[@"detail"], item[@"time"]];
    cell.imageView.image = [UIImage imageNamed:@"Item_third_H"] ?: [UIImage imageNamed:@"Item_third_N"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *item = self.dataList[indexPath.row];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = UIColor.whiteColor;
    vc.title = item[@"title"];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, CGRectGetWidth(self.view.bounds) - 40, 80)];
    label.numberOfLines = 0;
    label.textColor = UIColor.darkTextColor;
    label.text = item[@"detail"];
    [vc.view addSubview:label];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - lazy

- (NSMutableArray<NSDictionary *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
