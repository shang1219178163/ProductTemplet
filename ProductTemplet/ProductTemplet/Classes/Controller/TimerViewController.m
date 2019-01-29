//
//  TimerViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "TimerViewController.h"


#import "BNGCD.h"

@interface TimerViewController ()

@property (nonatomic, strong) NSTimer * timer;

@end

@implementation TimerViewController

-(void)dealloc{
    [NSTimer stopTimer:_timer];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __block NSInteger i = 0;
    _timer = [NSTimer BNtimeInterval:1 block:^(NSTimer *timer) {
        i++;
        DDLog(@"__%@",@(i));
    } repeats:YES];
      
    BNdispatchTimer(self, 1, ^(dispatch_source_t timer) {
        i++;
        DDLog(@"%@",@(i));
    });
    DDLog(@"___%@",@(i));
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
