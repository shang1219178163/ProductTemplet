//
//  BN_FirstViewController.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_FirstViewController.h"

#import "BN_SimpleDataModel.h"

#import "BN_BtnView.h"
#import "BN_MenuView.h"

#import "BN_TurnView.h"

#import "KVOController.h"
#import "SDCycleScrollView.h"

#import "NSUserDefaults+Helper.h"

#import "FactoryDetailInfoModel.h"

#import "WHKTableViewOneCell.h"
#import "WHKTableViewEightyFiveCell.h"
#import "WHKTableViewEightySixCell.h"


@interface BN_FirstViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) BN_BtnView * btnView;
@property (nonatomic, strong) BN_MenuView * menuView;
@property (nonatomic, strong) BN_TurnView * turnView;

@property (nonatomic, strong) NSArray * elementList;

@property (nonatomic, strong) NSMutableArray * imageList;

@end

@implementation BN_FirstViewController

-(BN_BtnView *)btnView{
    if (!_btnView) {
        _btnView = ({
            BN_BtnView * btnView = [[BN_BtnView alloc]initWithFrame:CGRectMake(10, 10, kScreen_width/4.0, 50)];
            btnView.imageView.image = [UIImage imageNamed:@"img_arrowDown_orange.png"];
            btnView.label.text = @"测试数据";
            btnView.type = @3;
            btnView.adjustsSizeToFitText = YES;
            
            btnView;
        });
    }
    return _btnView;
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

- (NSArray *)elementList{
    if (!_elementList) {
        _elementList = @[
                         @[@"数据录入",@"img_home_dataEntry_147",@"WHKDataEntryViewController", @"",].mutableCopy,
                         @[@"种猪管理",@"img_home_animamalOrigin_147",@"WHKAnimalOriginViewController", @"",].mutableCopy,
                         @[@"商品猪管理",@"img_home_animamalSell_147",@"WHKSelAnimalManagerController",@"",].mutableCopy,
                         @[@"提醒设定", @"img_home_remind_147",@"WHKRemindViewController",@"",].mutableCopy,
                         @[@"免疫管理",@"img_home_immune_147",@"WHKImmuneViewController",@"",].mutableCopy,
                         @[@"养猪日历",@"img_home_calendar_147",@"WHKCalendarViewController",@"",].mutableCopy,
                         @[@"生产报表",@"img_home_report_147",@"WHKReportViewController",@"",].mutableCopy,
                         @[@"存栏动态",@"img_home_currentState_147",@"WHKDynamicAnimalsViewController",@"",].mutableCopy,
                         @[@"更多功能",@"img_home_more_147",@"WHKMoreViewController",@"",].mutableCopy,
                         //                         @[@"高效录入",@"img_home_more_147",@"BN_EfficientEntryController",@"",].mutableCopy,
                         
                         ];
    }
    return _elementList;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    [self createBarBtnItemWithTitle:@"next" imageName:nil isLeft:NO isHidden:NO handler:^(id obj, id item, NSInteger idx) {
        [self goController:@"BN_MenuListController" title:@"Menu"];
        
    }];
    
    [self configureTableView];
    
    [self configureMenuList];
    
    [self registerForKVO];
    
    [self bindData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)bindData{
    
    for (NSInteger i = 0; i < 1; i++) {
        FactoryDetailInfoModel * model = [[FactoryDetailInfoModel alloc]init];
        model.title = [NSString stringWithFormat:@"随机数据随机数据%@%@",@(i),@(i)];
        model.number = [NSString getRandomStr:0 to:10];
        [self.dataList addObject:model];
    }
    
    [self.tableView reloadData];
    
}

- (void)configureTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.tableView.sectionFooterHeight = kScreen_width;
    //    self.tableView.sectionHeaderHeight = CGRectGetHeight(self.view.bounds) - self.tableView.sectionFooterHeight - self.tableView.rowHeight;
    self.tableView.sectionHeaderHeight = kScreen_height - kH_StatusBar - kH_NaviagtionBar - kH_TabBar - self.tableView.sectionFooterHeight - self.tableView.rowHeight;
    
}

- (UIView *)getViewWithHeight:(CGFloat)height isHeader:(BOOL)isHeader{
    
    NSInteger rowCount = 3;
    CGSize viewSize = CGSizeMake(kScreen_width/rowCount, kScreen_width/rowCount);
    
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width,  viewSize.height* self.elementList.count/rowCount)];
    backgroudView.backgroundColor = [UIColor whiteColor];
    
    if (isHeader == YES) {
        UIView * cycleView = [self createCycleViewWithRect:CGRectMake(0, 0, kScreen_width, height) imageNames:self.imageList];
        [backgroudView addSubview:cycleView];
        
    }else{
        CGRect rect = CGRectZero;
        //    按钮
        for (NSInteger i = 0; i < self.elementList.count; i++) {
            NSArray * array = self.elementList[i];

            CGFloat x = CGRectGetWidth(backgroudView.frame) / rowCount * ( i % rowCount);
            CGFloat y =  (i / rowCount) * viewSize.height;
            CGFloat w = CGRectGetWidth(backgroudView.frame) / rowCount;
            CGFloat h = viewSize.height;
            
            rect = CGRectMake(x, y, w, h);
            
            UIView * btnView = [UIView createBtnViewWithRect:rect imgName:array[1] imgHeight:CGRectGetHeight(rect)/2.0 title:array[0] titleColor:[UIColor blackColor] patternType:@"0"];
            btnView.tag = kTAG_VIEW+i+50;
            [backgroudView addSubview:btnView];
            
            if (i < rowCount) {
                [btnView.layer addSublayer:[btnView createLayerType:@0]];//上线条
                
            }
    
            
            [btnView.layer addSublayer:[btnView createLayerType:@2]];//上线条
            [btnView.layer addSublayer:[btnView createLayerType:@3]];//上线条
            
            [btnView addActionHandler:^(id obj, id item, NSInteger idx) {
                [self goController:array[2] title:array[0] obj:nil];
                
            }];
        }
    }
    return backgroudView;
}

- (void)configureMenuList{
    NSArray * menuList = [NSArray arrayWithItemPrefix:@"工厂_" startIndex:1 count:10 type:@0];
    
    self.navigationItem.titleView = self.btnView;
    
    self.btnView.label.text = [menuList firstObject];
    self.btnView.label.textColor = [UIColor whiteColor];
    self.btnView.block = ^(BN_BtnView *view) {
        [self handleActionBtnView:view];
        
    };
    
    BN_MenuView * menuView = [[BN_MenuView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, 0.0)];
    menuView.dataList = menuList;
    menuView.block = ^(BN_MenuView *view, NSIndexPath *indexPath) {
        
        NSString * string = menuList[indexPath.row];
        self.btnView.label.text = string;
        [self handleActionBtnView:self.btnView];
        
        [UIView animateWithDuration:kAnimationDuration_Drop animations:^{
            self.btnView.imageView.transform = view.isShow == YES ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
            
        }];
        
    };
    
    self.menuView = menuView;
    
    [self.navigationItem.titleView getViewLayer];
    
    
}

#pragma mark - -BINBtnView
- (void)handleActionBtnView:(BN_BtnView *)sender{
    self.menuView.isShow = CGAffineTransformIsIdentity(sender.imageView.transform) ? YES : NO;
    
    [UIView animateWithDuration:kAnimationDuration_Drop animations:^{
        sender.imageView.transform = CGAffineTransformIsIdentity(sender.imageView.transform) ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
        
    }];
    
}


#pragma mark - -KVO

- (void)registerForKVO{
    //监听self.tableView.frame
    [self.KVOController observe:self.btnView.imageView keyPath:@"transform" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        
        NSString *keyPath = change[FBKVONotificationKeyPathKey];
        if(object == self.btnView.imageView && [keyPath isEqualToString:@"transform"]){
            //            DDLog(@"transform_%@",@(self.btnView.imageView.transform));
            
        }
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
    return self.tableView.rowHeight;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.dataList.count > 0) {
        //        WHKTableViewOneCell * cell = [WHKTableViewOneCell cellWithTableView:tableView];
        WHKTableViewEightySixCell * cell = [WHKTableViewEightySixCell cellWithTableView:tableView];
        
        cell.cycleView.list = @[@"昨天，天津发布了新的人才引进政策——“海河英才”行动计划，新政策大幅放宽人才落户条件、自主选择落户地点、简化落户办理程序。",@"在这之前，其实天津也有人才计划，只不过门槛比较高，办理落户的手续也比较复杂，比如本科学历需要在当地缴纳半年社保等。",@"这次放开，说白了就是之前的门槛太高了，可能没有达到预期效果。所以“海河英才”计划有点像之前人才政策的升级版。",@"444444444444",@"555555555",@"西安人才计划也搞了两轮，第一轮门槛很高，第二轮低降到大学生只要学生证和身份证就能落户。后来的效果大家也看到了，西安房子供不应求，房价大涨。天津会不会成为第二个西安呢？",];
        [cell.cycleView start];
        
        [cell getViewLayer];
        return cell;
    }else{
        WHKTableViewOneCell * cell = [WHKTableViewOneCell cellWithTableView:tableView];
        
        cell.textLabel.text = @"没有符合条件的数据,去看看其他内容吧!";
        
        return cell;
    }
    return nil;
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

- (UIView *)createCycleViewWithRect:(CGRect)rect imageNames:(NSArray *)imageNames{
    
    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    
    //     本地加载 --- 创建不带标题的图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect shouldInfiniteLoop:YES imageNamesGroup:imageNames];
    cycleScrollView.delegate = self;
//    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //         --- 轮播时间间隔，默认1.0秒，可自定义
    cycleScrollView.autoScrollTimeInterval = 3.0;
    cycleScrollView.backgroundColor = UIColor.blackColor;
    
    //    cycleScrollView.layer.borderColor = [[UIColor blueColor]CGColor];
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
    [NSUserDefaults BN_setObject:obj forKey:@"FactoryDetailInfoModel"];
    [NSUserDefaults defaultsSynchronize];
    
    obj = [NSUserDefaults BN_objectForKey:@"FactoryDetailInfoModel"];
    DDLog(@"obj__%@",obj);
    
}


@end
