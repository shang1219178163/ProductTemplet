//
//  LabelViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/8.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CycleLabelViewController.h"

#import "BNCycleView.h"
#import "UIView+Helper.h"

@interface CycleLabelViewController ()

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) BNCycleView *cycleView;

@end

@implementation CycleLabelViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataList = @[@"aaaaaaaaaaaaaaaaaaaaaaaaaaa",@"bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",@"ccccccccccccccccccccccccccc",];

    self.cycleView = [[BNCycleView alloc]initWithFrame:CGRectMake(20, 60, kScreenWidth*0.8, 40)];
    self.cycleView.list = self.dataList;
    [self.view addSubview:self.cycleView];
    [self.cycleView start];
//    [self.view getViewLayer];

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

@end
