//
//  SliderTabBarController.m
//  ProductTemplet
//
//  Created by hsf on 2018/4/24.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "SliderTabBarController.h"

#import "BN_Globle.h"
#import "BN_TabBarViewZero.h"

#import "BN_Noti.h"


@interface SliderTabBarController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray * itemList;
@property (nonatomic, strong) BN_TabBarViewZero * tabBarView;

@end

@implementation SliderTabBarController

-(BN_TabBarViewZero *)tabBarView{
    if (!_tabBarView) {
        _tabBarView = [BN_TabBarViewZero viewWithRect:self.view.bounds items:self.itemList];
    }
    return _tabBarView;
}

-(NSArray *)itemList{
    if (!_itemList) {
        
        NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i < 20; i++) {
            [marr addObject:[NSString stringWithFormat:@"item%@",@(i)]];
        }
        _itemList = marr.copy;
    }
    return _itemList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self createBarItemTitle:@"right" imageName:nil isLeft:NO isHidden:NO handler:^(id obj, id item, NSInteger idx) {
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedToView:nil animated:NO];
//        [hud hideAnimated:YES afterDelay:1];
//
//        [hud getViewLayer];
//    }];
    
    [self.view addSubview:self.tabBarView];
   
    self.tabBarView.block = ^(BN_TabBarViewZero *view, UITableView *tableView, NSInteger idx) {
        
        DDLog(@"%@_%@_%@",view,tableView,@(idx));

    };
    
    for (NSInteger i = 0; i < self.tabBarView.items.count; i++) {
        
        NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
        [marr addObject:[NSString stringWithFormat:@"item___%@",@(i)]];
        [marr addObject:[NSString stringWithFormat:@"item___%@",@(i)]];
        [marr addObject:[NSString stringWithFormat:@"item___%@",@(i)]];
        [self.dataList addObject:marr.copy];
    }
    
    
    for (NSInteger i = 0; i < self.tabBarView.scrollTableViews.count; i++) {
        UITableView * tableView = self.tabBarView.scrollTableViews[i];
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- talbeView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *tempArray = self.dataList[self.tabBarView.currentPage];
    return tempArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {

        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //    cell.backgroundColor = UIColor.orangeColor;

    if ([tableView isEqual:self.tabBarView.scrollTableViews[self.tabBarView.currentPage%2]]) {
        cell.textLabel.text = self.dataList[self.tabBarView.currentPage][indexPath.row];
    }else{
        cell.textLabel.text = @"111111";
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 2 == 0) {
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotiPost_logOut object:@"aaa"];

    }else{
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotiPost_backgroudUploadLocation object:@"bbb"];

    }
    
}

@end
