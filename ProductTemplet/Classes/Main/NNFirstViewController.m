//
//  NNFirstViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NNFirstViewController.h"
#import <YYCategories.h>

#import "UIViewController+ZYSliderViewController.h"
#import "ZYSliderViewController.h"

#import "NNSimpleDataModel.h"

#import "SDCycleScrollView.h"

#import "FactoryDetailInfoModel.h"

@interface NNFirstViewController ()<UITableViewDataSource, UITableViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) NNBtnView * btnView;
@property (nonatomic, strong) NNMenuView * menuView;
@property (nonatomic, strong) NNTurnView * turnView;

@property (nonatomic, strong) NSArray * elements;

@property (nonatomic, strong) NSMutableArray * imageList;
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation NNFirstViewController

-(NNBtnView *)btnView{
    if (!_btnView) {
        _btnView = ({
            NNBtnView * btnView = [[NNBtnView alloc]initWithFrame:CGRectMake(0, 0, 120, 36)];
            btnView.imageView.image = [UIImage imageNamed:@"img_arrowDown_orange.png"];
            btnView.label.text = @"测试数据";
            btnView.type = @3;
            btnView.adjustsSizeToFitText = YES;
            btnView;
        });
    }
    return _btnView;
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

-(NSMutableArray *)imageList{
    if (!_imageList) {
        _imageList = [NSMutableArray arrayWithCapacity:0];
        _imageList = @[
                       @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                       @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                       @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                       ].mutableCopy;
    }
    return _imageList;
}

- (NSArray *)elements{
    if (!_elements) {
        _elements = @[
                         @[@"数据录入",@"img_home_dataEntry_147",@"WHKDataEntryViewController", @"",].mutableCopy,
                         @[@"种猪管理",@"img_home_animamalOrigin_147",@"WHKAnimalOriginViewController", @"",].mutableCopy,
                         @[@"商品猪管理",@"img_home_animamalSell_147",@"WHKSelAnimalManagerController",@"",].mutableCopy,
                         @[@"提醒设定", @"img_home_remind_147",@"WHKRemindViewController",@"",].mutableCopy,
                         @[@"免疫管理",@"img_home_immune_147",@"WHKImmuneViewController",@"",].mutableCopy,
                         @[@"养猪日历",@"img_home_calendar_147",@"WHKCalendarViewController",@"",].mutableCopy,
                         @[@"生产报表",@"img_home_report_147",@"WHKReportViewController",@"",].mutableCopy,
                         @[@"存栏动态",@"img_home_currentState_147",@"WHKDynamicAnimalsViewController",@"",].mutableCopy,
                         @[@"更多功能",@"img_home_more_147",@"WHKMoreViewController",@"",].mutableCopy,
                         //                         @[@"高效录入",@"img_home_more_147",@"BNEfficientEntryController",@"",].mutableCopy,
                         
                         ];
    }
    return _elements;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    self.view.backgroundColor = UIColor.whiteColor;

    
    [self configureTableView];
    
    [self configureMenuList];
    
    [self registerForKVO];
    
    [self bindData];
    
    // Use customView items — system UIBarButtonItem + UIButton appearance proxies
    // can infinite-loop in UINavigationBar Auto Layout on iOS 15+.
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem customViewWithButton:@"＋"
                                                                          handler:^(UIButton * _Nonnull sender) {
        [self showLeftAction];
    }];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem customViewWithButton:@"更多"
                                                                            handler:^(UIButton * _Nonnull sender) {
        [self showRightAction];
    }];
}

- (void)showLeftAction{
    [[self sliderViewController] showLeft];
}

- (void)showRightAction{
    [[self sliderViewController] showRight];
    
    DDLog(@"_cmd: %@", NSStringFromSelector(_cmd));
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tbView.frame = self.view.bounds;
}

- (void)bindData{
    for (NSInteger i = 0; i < 1; i++) {
        FactoryDetailInfoModel * model = [[FactoryDetailInfoModel alloc]init];
        model.title = [NSString stringWithFormat:@"随机数据随机数据%@%@",@(i),@(i)];
        model.number = [@(RandomInteger(0, 20)) stringValue];
        [self.dataList addObject:model];
    }
    
    [self.tbView reloadData];
    
}

- (void)configureTableView{
    [self.view addSubview:self.tbView];
    self.tbView.rowHeight = 60;

    // Banner + notice row + function grid should fit on screen (old formula made a huge empty header).
    CGFloat itemSide = floor(kScreenWidth / 3.0);
    NSInteger gridRows = (self.elements.count + 2) / 3;
    self.tbView.sectionHeaderHeight = 160;
    self.tbView.sectionFooterHeight = itemSide * gridRows;
    [self.tbView reloadData];
}

- (UIView *)getViewWithHeight:(CGFloat)height isHeader:(BOOL)isHeader{
    NSInteger colCount = 3;
    CGFloat itemSide = floor(kScreenWidth / colCount);
    NSInteger gridRows = (self.elements.count + colCount - 1) / colCount;

    if (isHeader) {
        UIView *backgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
        backgroudView.backgroundColor = UIColor.whiteColor;
        UIView *cycleView = [self createCycleViewRect:backgroudView.bounds imageNames:self.imageList];
        [backgroudView addSubview:cycleView];
        return backgroudView;
    }

    UIView *backgroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, itemSide * gridRows)];
    backgroudView.backgroundColor = UIColor.whiteColor;

    for (NSInteger i = 0; i < self.elements.count; i++) {
        NSArray *array = self.elements[i];
        CGFloat x = itemSide * (i % colCount);
        CGFloat y = itemSide * (i / colCount);

        UIView *sender = [[UIView alloc] initWithFrame:CGRectMake(x, y, itemSide, itemSide)];
        sender.tag = kTAG_VIEW + i + 50;
        sender.layer.borderWidth = 0.5;
        sender.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;

        CGFloat iconSide = 48;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((itemSide - iconSide) / 2.0, 18, iconSide, iconSide)];
        icon.image = [UIImage imageNamed:array[1]];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [sender addSubview:icon];

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(icon.frame) + 8, itemSide - 8, 20)];
        lab.text = array[0];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = UIColor.darkTextColor;
        lab.adjustsFontSizeToFitWidth = YES;
        [sender addSubview:lab];

        [sender addGestureTap:^(UITapGestureRecognizer * _Nonnull reco) {
            UIViewController *vc = [[NSClassFromString(array[2]) alloc] init];
            if (!vc) { return; }
            vc.title = array[0];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [backgroudView addSubview:sender];
    }
    return backgroudView;
}

- (void)configureMenuList{
    NSArray *menuList = [NSArray arrayWithCount:9 generator:^id _Nonnull(NSUInteger idx) {
        return [NSString stringWithFormat:@"工厂_%@", @(idx + 1)];
    }];

    self.navigationItem.titleView = self.btnView;
    
    self.btnView.label.text = [menuList firstObject];
    self.btnView.label.textColor = UIColor.whiteColor;
    @weakify(self);
    self.btnView.block = ^(NNBtnView *view) {
        @strongify(self);
        [self handleActionBtnView:view];
    };
    
    NNMenuView * menuView = [[NNMenuView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0)];
    menuView.dataList = menuList;
    menuView.block = ^(NNMenuView *view, NSIndexPath *indexPath) {
        
        NSString * string = menuList[indexPath.row];
        self.btnView.label.text = string;
        [self handleActionBtnView:self.btnView];
        
        [UIView animateWithDuration:kDurationDrop animations:^{
            self.btnView.imageView.transform = view.isShow  ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
            
        }];
        
    };
    
    self.menuView = menuView;
    [self.btnView invalidateIntrinsicContentSize];
}

#pragma mark - -BINBtnView
- (void)handleActionBtnView:(NNBtnView *)sender{
    self.menuView.isShow = CGAffineTransformIsIdentity(sender.imageView.transform) ? YES : NO;
    
    [UIView animateWithDuration:kDurationDrop animations:^{
        sender.imageView.transform = CGAffineTransformIsIdentity(sender.imageView.transform) ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
        
    }];
    
}


#pragma mark - -KVO

- (void)registerForKVO{
    //监听self.tableView.frame
    [self.btnView.imageView addObserverBlockForKeyPath:@"transform" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
        DDLog(@"%@_%@_%@", obj, oldVal, newVal);
    }];
}

#pragma mark - -tableview

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.dataList.count > 0 ? self.dataList.count : 1;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return tableView.rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"HomeNoticeCell";
    UITableViewCell *cell = [UITableViewCell cellWithTableView:tableView identifier:identifier style:UITableViewCellStyleSubtitle];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:@"img_notice_One.png"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = UIColor.darkTextColor;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = UIColor.grayColor;

    if (self.dataList.count > 0) {
        FactoryDetailInfoModel *model = self.dataList[indexPath.row];
        cell.textLabel.text = model.title ?: @"通知";
        cell.detailTextLabel.text = model.number.length ? [NSString stringWithFormat:@"数量 %@", model.number] : @"暂无更多信息";
    } else {
        cell.textLabel.text = @"没有符合条件的数据,去看看其他内容吧!";
        cell.detailTextLabel.text = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return tableView.sectionHeaderHeight;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [self getViewWithHeight:tableView.sectionHeaderHeight isHeader:YES];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return tableView.sectionFooterHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [self getViewWithHeight:tableView.sectionFooterHeight isHeader:NO];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createCycleViewRect:(CGRect)rect imageNames:(NSArray *)imageNames{
    UIView *backgroudView = [[UIView alloc]initWithFrame:rect];
    
    // Remote URLs must use imageURLStringsGroup (imageNamesGroup is for local asset names).
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect
                                                                              delegate:self
                                                                      placeholderImage:nil];
    cycleScrollView.infiniteLoop = YES;
    cycleScrollView.imageURLStringsGroup = imageNames;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.autoScrollTimeInterval = 3.0;
    cycleScrollView.backgroundColor = UIColor.blackColor;
    
    //    cycleScrollView.layer.borderColor = UIColor.blueColor.CGColor;
    //    cycleScrollView.layer.borderWidth = 1;
    [backgroudView addSubview:cycleScrollView];
    return backgroudView;
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //    NSLog(@"---点击了第%ld张图片", (long)index);
    
}

// 滚动到第几张图回调
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    //     NSLog(@">>>>>> 滚动到第%ld张图", (long)index);
}


- (void)aboutUserDeaults:(id)obj{
    [NSUserDefaults setObject:obj forKey:@"FactoryDetailInfoModel"];
    [NSUserDefaults synchronize];
    
    obj = [NSUserDefaults objectForKey:@"FactoryDetailInfoModel"];
    DDLog(@"obj__%@",obj);
    
}


@end
