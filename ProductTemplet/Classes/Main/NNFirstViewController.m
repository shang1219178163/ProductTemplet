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
            btnView.label.text = @"测试数据";
            btnView.adjustsSizeToFitText = YES;
            // 默认右侧小三角；导航栏标题用白色
            btnView.imageView.tintColor = UIColor.whiteColor;
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
                         @[@"宠物管理",@"img_home_animamalOrigin_147",@"WHKAnimalOriginViewController", @"",].mutableCopy,
                         @[@"优宠物管理",@"img_home_animamalSell_147",@"WHKSelAnimalManagerController",@"",].mutableCopy,
                         @[@"提醒设定", @"img_home_remind_147",@"WHKRemindViewController",@"",].mutableCopy,
                         @[@"免疫管理",@"img_home_immune_147",@"WHKImmuneViewController",@"",].mutableCopy,
                         @[@"养猪日历",@"img_home_calendar_147",@"WHKCalendarViewController",@"",].mutableCopy,
                         @[@"生产报表",@"img_home_report_147",@"WHKReportViewController",@"",].mutableCopy,
                         @[@"宠物动态",@"img_home_currentState_147",@"WHKDynamicAnimalsViewController",@"",].mutableCopy,
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
    ZYSliderViewController *slider = [self sliderViewController];
    if (!slider) {
        DDLog(@"sliderViewController is nil — root must be ZYSliderViewController");
        return;
    }
    [slider showLeft];
}

- (void)showRightAction{
    ZYSliderViewController *slider = [self sliderViewController];
    if (!slider) {
        DDLog(@"sliderViewController is nil — root must be ZYSliderViewController");
        return;
    }
    [slider showRight];
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
    self.tbView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.tbView.contentInset = UIEdgeInsetsZero;
    self.tbView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.tbView.backgroundColor = UIColor.whiteColor;
    if (@available(iOS 15.0, *)) {
        // iOS 15+ 默认给 section header 顶部加约 22pt 空白
        self.tbView.sectionHeaderTopPadding = 0;
    }

    // Banner 用 tableHeaderView，避免 sectionHeader 顶部空隙
    CGFloat bannerH = 160;
    self.tbView.tableHeaderView = [self createCycleViewRect:CGRectMake(0, 0, kScreenWidth, bannerH) imageNames:self.imageList];
    self.tbView.sectionHeaderHeight = CGFLOAT_MIN;

    self.tbView.sectionFooterHeight = [NNGridMenuView heightWithItemCount:self.elements.count
                                                                    width:kScreenWidth
                                                           numberOfColumn:3];
    [self.tbView reloadData];
}

- (void)configureMenuList{
    NSArray *menuList = [NSArray arrayWithCount:9 generator:^id _Nonnull(NSUInteger idx) {
        // idx 为 n（0 基）时，拼 (n+1) 个「选项」
        NSUInteger n = idx + 1;
        NSMutableString *text = [NSMutableString string];
        for (NSUInteger i = 0; i < n; i++) {
            [text appendString:@"选项"];
        }
        return text.copy;
    }];

    self.btnView.label.textColor = UIColor.whiteColor;
    self.btnView.label.text = [menuList firstObject];
    [self.btnView sizeToFitContent];
    self.navigationItem.titleView = self.btnView;

    @weakify(self);
    self.btnView.block = ^(NNBtnView *view) {
        @strongify(self);
        [self onBtnView:view];
    };
    
    NNMenuView *menuView = [[NNMenuView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0)];
    CGFloat navBottom = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    menuView.offset = navBottom > 0 ? navBottom : (kStatusBarHeight + kNaviBarHeight);
    menuView.dataList = menuList;
    menuView.block = ^(NNMenuView *view, NSIndexPath *indexPath) {
        @strongify(self);
        NSString * string = menuList[indexPath.row];
        self.btnView.label.text = string;
        [self.btnView sizeToFitContent];
        // 导航栏 titleView 以 frame 为准，重设一次才能吃到新宽度
        self.navigationItem.titleView = nil;
        self.navigationItem.titleView = self.btnView;
        [self onBtnView:self.btnView];
        
        [UIView animateWithDuration:kDurationDrop animations:^{
            self.btnView.imageView.transform = view.isShow  ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
            
        }];
        
    };
    
    self.menuView = menuView;
}

#pragma mark - -BINBtnView
- (void)onBtnView:(NNBtnView *)sender{
    CGFloat navBottom = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    if (navBottom > 0) {
        self.menuView.offset = navBottom;
    }
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
    if (self.dataList.count == 0) {
        UITableViewOneCell *cell = [UITableViewOneCell cellWithTableView:tableView];
        cell.textLabel.text = @"没有符合条件的数据,去看看其他内容吧!";
        return cell;
    }

    UITableViewCycleViewCell *cell = [UITableViewCycleViewCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cycleView.list = @[
        @"昨天，天津发布了新的人才引进政策——“海河英才”行动计划，新政策大幅放宽人才落户条件、自主选择落户地点、简化落户办理程序。",
        @"在这之前，其实天津也有人才计划，只不过门槛比较高，办理落户的手续也比较复杂，比如本科学历需要在当地缴纳半年社保等。",
        @"这次放开，说白了就是之前的门槛太高了，可能没有达到预期效果。所以“海河英才”计划有点像之前人才政策的升级版。",
        @"西安人才计划也搞了两轮，第一轮门槛很高，第二轮降到大学生只要学生证和身份证就能落户。",
    ];
    // start after layout; NNCycleView will auto-start when bounds are ready
    [cell.cycleView start];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return tableView.sectionFooterHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NNGridMenuView *view = [[NNGridMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tableView.sectionFooterHeight)];
    view.numberOfColumn = 3;
    view.items = self.elements;
    @weakify(self);
    view.block = ^(NNGridMenuView *grid, NSInteger index, NSArray *item) {
        @strongify(self);
        if (item.count < 3) { return; }
        UIViewController *vc = [[NSClassFromString(item[2]) alloc] init];
        if (!vc) { return; }
        vc.title = item[0];
        [self.navigationController pushViewController:vc animated:YES];
    };
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createCycleViewRect:(CGRect)rect imageNames:(NSArray *)imageNames{
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
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.clipsToBounds = YES;
    return cycleScrollView;
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
