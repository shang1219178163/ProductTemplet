

//
//  AnimationListController.m
//  NNAnimation
//
//  Created by hsf on 2018/9/25.
//  Copyright © 2018年 whkj. All rights reserved.
//

#import "AnimationListController.h"

@interface AnimationListController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation AnimationListController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.title = @"Main";
    
    [self.view addSubview:self.tbView];
    
    self.dataList = @[
                      @[@"AnimationController1", @"ViewController1",],
                      @[@"AnimationController2", @"ViewController1",],
                      @[@"AnimationController3", @"ViewController1",],
                      @[@"AnimationController4", @"ViewController1",],
                      @[@"AnimationController5", @"登录动画",],
                      @[@"AnimationController6", @"ViewController1",],
                      @[@"AnimationController7", @"app安装动画背景",],
                      @[@"ViewController8", @"layer基础动画",],
                      @[@"AnimationController9", @"翻转动画",],
                      @[@"AnimationController10", @"基础动画",],
                      @[@"AnimationController11", @"加载动画",],
                      @[@"AnimationController12", @"雷达动画",],
                      @[@"AnimationController13", @"弹性按钮",],
                      @[@"AnimationController14", @"圆圈动画",],
                      @[@"AnimationController15", @"11111",],
                      @[@"AnimationController16", @"金额跳动动画",],
                      @[@"AnimationController17", @"transitionWithView/transitionFromView动画",],
                      @[@"AnimationController18", @"圆形扩散动画",],
                      @[@"NNAnimationController", @"购物车动画",],
                      @[@"LiveLikeController", @"点赞动画",],
                      @[@"DriftAnimationController", @"红包雨动画",],
                      @[@"EmitterViewController", @"粒子动画",],
                      @[@"CommonAnimationController", @"动画",],
                      @[@"UIViewPropertyAnimatorController", @"UIViewPropertyAnimator(iOS10)",],
                      @[@"WaveController", @"波浪动画",],
                      
                      ].mutableCopy;
    
}


-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    self.tbView.frame = self.view.bounds;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell) cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    
    cell.textLabel.text = [self.dataList[indexPath.row] firstObject];
    cell.textLabel.textColor = UIColor.themeColor;
    
    cell.detailTextLabel.text = [self.dataList[indexPath.row] lastObject];
    cell.detailTextLabel.textColor = UIColor.grayColor;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcName = [self.dataList[indexPath.row] firstObject];
    UIViewController *vc = [NSClassFromString(vcName) new];
    vc.title = vcName;
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -lazy
- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
