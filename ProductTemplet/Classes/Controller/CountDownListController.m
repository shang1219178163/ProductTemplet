//
//  CountDownListController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/12.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "CountDownListController.h"
#import "CounterListController.h"
#import "CounterListGroupController.h"

@interface CountDownListController ()

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation CountDownListController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    self.dataList = @[@"不分组",@"分组",@"时间 -"].mutableCopy;
    
    for (NSInteger i = 0; i < self.dataList.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 200, 50);
        button.center = CGPointMake(self.view.frame.size.width / 2, i * 60 + 160);
        button.tag = i;
        [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [button setTitle:self.dataList[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    [self.view getViewLayer];
    
}

- (void)tap:(UIButton *)sender {
    NSString *title = sender.titleLabel.text;

    switch (sender.tag) {
        case 0:
        {
            UIViewController *vc = [[NSClassFromString(@"CounterListController") alloc]init];
            vc.title = @"CounterList";
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 1:
        {
            UIViewController *vc = [[NSClassFromString(@"CounterListGroupController") alloc]init];
            vc.title = @"CounterList";
            [self.navigationController pushViewController:vc animated:true];
        }
            break;
        case 2:
        {
            self.isPlusTime = !self.isPlusTime;
            NSString *title = self.isPlusTime  ? @"时间 +" : @"时间 -";
            [sender setTitle:title forState:UIControlStateNormal];
        }
            break;
        default:
            break;
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
