//
//  StrategyViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "StrategyViewController.h"

#import "StrategyFinancy.h"
#import "CustomTextField.h"

@interface StrategyViewController ()

@end

@implementation StrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    id<StrategyFinancyProtocal> alipayFinancy = [[StrategyFinancyAlipay alloc] init];
    StrategyFinancy* context = [[StrategyFinancy alloc] initWithFinancy:alipayFinancy];
    NSInteger money = [context financyWithMonth:6 money:10000];
    NSLog(@"Alipay money = %@", @(money));
    
    id<StrategyFinancyProtocal> ylFinancy = [[StrategyFinancyYouLi alloc] init];
    context.financy = ylFinancy;
    money = [context financyWithMonth:6 money:10000];
    NSLog(@"YouLi money = %@", @(money));
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
