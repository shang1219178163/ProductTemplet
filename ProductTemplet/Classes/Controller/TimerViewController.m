//
//  TimerViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/7.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "TimerViewController.h"
#import <NNCategoryPro/NNCategoryPro.h>


@interface TimerViewController ()

@property (nonatomic, strong) UISwitch * switchCtl;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation TimerViewController

-(void)dealloc{
    [_timer destroy];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.switchCtl];
    [self.view addSubview:self.switchCtl];
    
    
    __block NSInteger i = 0;
    _timer = [NSTimer scheduledTimer:1 block:^(NSTimer *timer) {
        i++;
        DDLog(@"__%@",@(i));
    } repeats:YES];
    
    [NSTimer createGCDTimer:1 repeats:true block:^{
        i++;
        DDLog(@"%@",@(i));
    }];
    
    DDLog(@"___%@",@(i));
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UISwitch *)switchCtl{
    if (!_switchCtl) {
        _switchCtl = ({
            UISwitch *view = [[UISwitch alloc]init];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.on = false;
            view.onTintColor = UIColor.randomColor;
            view.tintColor = UIColor.randomColor;
            view.thumbTintColor = UIColor.randomColor;
            [view addActionHandler:^(UISwitch * _Nonnull sender) {
                DDLog(@"开关状态_%@", @(sender.isOn));
                
            } forControlEvents:UIControlEventValueChanged];
            view;
        });
    }
    return _switchCtl;
}

@end
