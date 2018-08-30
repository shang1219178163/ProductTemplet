//
//  FriendListController.m
//  ProductTemplet
//
//  Created by hsf on 2018/4/24.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FriendListController.h"

#import "GlobleConst.h"

#import "BN_SimpleDataModel.h"

#import "BN_TabBarView.h"
//#import "BN_SegmentView.h"

#import "BINImgLabelView.h"

#import "BN_FoldHeaderFooterView.h"
#import "WHKHeaderFooterViewZero.h"

#import "WHKTableViewOneCell.h"
#import "WHKTableViewElevenCell.h"

#import "WHKTableViewFiftyTwoCell.h"

#import "WHKTableViewSixtyFiveCell.h"

@interface FriendListController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FriendListController


-(instancetype)init{
    self = [super init];
    if (self) {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDataSource];
}


-(void)initDataSource{
    
    //操作记录
    NSArray * array = @[@"分组0",@"分组1",@"分组2",@"分组3",@"分组4",@"分组5",@"分组6",@"分组7",@"分组8",@"分组9"];
    for (NSInteger i = 0; i < array.count; i++) {
        FoldSectionModel * foldModel = [[FoldSectionModel alloc] init];
        foldModel.title = array[i];
        foldModel.isOpen = NO;
        foldModel.image = @"img_vehicleTypeSedan_color.png";
        
        for (NSInteger j = 0; j <= i; j++) {
            NSString * modelString = [NSString stringWithFormat:@"%@_%@",foldModel.title,@(j)];
            [foldModel.dataList addObject:modelString];
            
        }
        [self.dataList addObject:foldModel];
    }
    
}

- (FoldSectionModel *)itemAtSection:(NSInteger)section{
    FoldSectionModel * foldModel = self.dataList[section];
    return foldModel;
}

#pragma mark -- talbeView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    FoldSectionModel * foldModel = [self itemAtSection:section];
    NSInteger count = foldModel.isOpen == YES ? foldModel.dataList.count : 0;
    return count;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FoldSectionModel * foldModel = [self itemAtSection:indexPath.section];
    id obj = foldModel.dataList[indexPath.row];
    
    NSString * title = [obj isKindOfClass:[NSArray class]] ? [obj firstObject] : obj;
    NSString * textSub = [@(foldModel.dataList.count) stringValue];;
    
    
    WHKTableViewElevenCell * cell = [WHKTableViewElevenCell cellWithTableView:tableView];
    
    cell.labelLeft.text = title;
    cell.labelRight.text = textSub;
    
    [cell getViewLayer];
    return cell;
    
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    FoldSectionModel * foldModel = [self itemAtSection:indexPath.section];
//    id obj = foldModel.dataList[indexPath.row];
//
//    NSString * title = [obj isKindOfClass:[NSArray class]] ? [obj firstObject] : obj;
//    NSString * textSub = [@(foldModel.dataList.count) stringValue];;
//
//
//    WHKTableViewSixtyFiveCell * cell = [WHKTableViewSixtyFiveCell cellWithTableView:tableView];
//
//    cell.labelLeft.text = title;
//    cell.labelRight.text = textSub;
//
//    [cell getViewLayer];
//    return cell;
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * msg = NSStringFromIndexPath(indexPath);
    [self showBINAlertTitle:@"提示信息" msg:msg image:@"bug.png"];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    FoldSectionModel * foldModel = [self itemAtSection:section];
    
    WHKHeaderFooterViewZero * foldHeaderView = [WHKHeaderFooterViewZero viewWithTableView:tableView];
    
    foldHeaderView.isCanOPen = YES;
    foldHeaderView.isOpen = foldModel.isOpen;
    foldHeaderView.labelLeft.text = foldModel.title;
    foldHeaderView.labelLeft.textColor = kC_ThemeCOLOR;
    foldHeaderView.labelLeftSub.text = [@(foldModel.dataList.count) stringValue];
    foldHeaderView.labelLeftSub.textColor = kC_ThemeCOLOR;
    //    foldHeaderView.imgViewLeft.image = [UIImage imageNamed:foldModel.image];
    //    foldHeaderView.blockView = ^(BN_HeaderFooterView *foldView, NSInteger index) {
    foldHeaderView.blockView = ^(UITableViewHeaderFooterView *foldView, NSInteger index) {
        foldModel.isOpen = !foldModel.isOpen;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        
    };
    return foldHeaderView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - - alertView

- (void)showBINAlertTitle:(NSString *)title msg:(NSString *)msg image:(NSString *)image{
    UIView* view = [self createCustomeViewWithImage:image msg:msg];
    
    BN_AlertViewZero * alertView = [BN_AlertViewZero alertViewWithTitle:title message:nil customView:view btnTitles:@[@"取消",@"确认"]];
    [alertView show];
    alertView.block = ^(BN_AlertViewZero *alertView, NSInteger btnIndex) {
        NSLog(@"%@====%@",alertView,@(btnIndex));
        
        if ([image isEqualToString:kIMAGE_update] && btnIndex == 1) {
            DDLog(@"种猪录入数据");
            
        }
        else if ([image isEqualToString:kIMAGE_inquiry]){
            DDLog(@"种猪删除数据");
            
        }
        else if ([title isEqualToString:kRemark]){
            
        }
        
    };
    [alertView getViewLayer];

}

- (UIView *)createCustomeViewWithImage:(NSString *)image msg:(NSString *)msg{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth_customView, 200)];
    view.backgroundColor = [UIColor cyanColor];
    
    UIImageView * imgView = [UIView createImageViewWithRect:CGRectMake(0, 0, CGRectGetWidth(view.frame), 40) image:image tag:300 patternType:@"0"];
    [view addSubview:imgView];
    
    NSString * text = msg;
    CGSize size = [self sizeWithText:text font:@15 width:CGRectGetWidth(view.frame)];
    
    CGRect rect = CGRectMake(0, CGRectGetMaxY(imgView.frame)+kY_GAP, CGRectGetWidth(view.frame), size.height);
    UILabel * label = [UIView createLabelWithRect:rect text:text textColor:nil tag:kTAG_LABEL patternType:@"0" font:15 backgroudColor:[UIColor greenColor] alignment:NSTextAlignmentCenter];
    [view addSubview:label];
    
    [view setHeight:(CGRectGetHeight(label.frame) + CGRectGetHeight(imgView.frame) + kY_GAP*2)];
    
    return view;
    
}


@end