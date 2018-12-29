//
//  LabelViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/8.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CycleLabelViewController.h"

#import "BN_CycleView.h"
#import "UIView+Helper.h"

@interface CycleLabelViewController ()

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) BN_CycleView *cycleView;

@end

@implementation CycleLabelViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataList = @[@"aaaaaaaaaaaaaaaaaaaaaaaaaaa",@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",@"ccccccccccccccccccccccccccc",];

    self.cycleView = [[BN_CycleView alloc]initWithFrame:CGRectMake(20, 60, kScreen_width*0.8, 40)];
    self.cycleView.list = self.dataList;
    [self.view addSubview:self.cycleView];
    [self.cycleView start];
//    [self.view getViewLayer];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

@end
