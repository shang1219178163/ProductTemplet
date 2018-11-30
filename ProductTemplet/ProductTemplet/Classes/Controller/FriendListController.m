//
//  FriendListController.m
//  ProductTemplet
//
//  Created by hsf on 2018/4/24.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "FriendListController.h"

#import "BN_SimpleDataModel.h"


@interface FriendListController ()

@end

@implementation FriendListController

-(instancetype)init{
    self = [super init];
    if (self) {
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
        BN_FoldSectionModel * foldModel = [[BN_FoldSectionModel alloc] init];
        foldModel.title = array[i];
        foldModel.isOpen = NO;
        foldModel.image = @"bug.png";
        
        for (NSInteger j = 0; j <= i; j++) {
            NSString * modelString = [NSString stringWithFormat:@"%@_%@",foldModel.title,@(j)];
            [foldModel.dataList addObject:modelString];
            
        }
        [self.dataList addObject:foldModel];
    }
    
}

- (BN_FoldSectionModel *)itemAtSection:(NSInteger)section{
    BN_FoldSectionModel * foldModel = self.dataList[section];
    return foldModel;
}

#pragma mark -- talbeView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BN_FoldSectionModel * foldModel = [self itemAtSection:section];
    NSInteger count = foldModel.isOpen == YES ? foldModel.dataList.count : 0;
    return count;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BN_FoldSectionModel * foldModel = [self itemAtSection:indexPath.section];
    id obj = foldModel.dataList[indexPath.row];
    
    NSString * title = [obj isKindOfClass:[NSArray class]] ? [obj firstObject] : obj;
    NSString * textSub = [@(foldModel.dataList.count) stringValue];;
    
    
    UITableViewElevenCell * cell = [UITableViewElevenCell cellWithTableView:tableView];
    
    cell.labelLeft.text = title;
    cell.labelRight.text = textSub;
    
    [cell getViewLayer];
    return cell;
    
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    BN_FoldSectionModel * foldModel = [self itemAtSection:indexPath.section];
//    id obj = foldModel.dataList[indexPath.row];
//
//    NSString * title = [obj isKindOfClass:[NSArray class]] ? [obj firstObject] : obj;
//    NSString * textSub = [@(foldModel.dataList.count) stringValue];;
//
//
//    UITableViewSixtyFiveCell * cell = [UITableViewSixtyFiveCell cellWithTableView:tableView];
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
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BN_FoldSectionModel * foldModel = [self itemAtSection:section];
    
//    WHKHeaderFooterViewZero * foldHeaderView = [WHKHeaderFooterViewZero viewWithTableView:tableView];
    UITableHeaderFooterViewOne * foldHeaderView = [UITableHeaderFooterViewOne viewWithTableView:tableView];

    foldHeaderView.isCanOPen = YES;
    foldHeaderView.isOpen = foldModel.isOpen;
    foldHeaderView.labelLeft.text = foldModel.title;
    foldHeaderView.labelLeft.textColor = UIColor.themeColor;
    foldHeaderView.labelLeftSub.text = [@(foldModel.dataList.count) stringValue];
    foldHeaderView.labelLeftSub.textColor = UIColor.themeColor;
    foldHeaderView.imgViewLeft.image = [UIImage imageNamed:foldModel.image];
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



@end
