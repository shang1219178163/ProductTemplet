//
//  LiveLikeController.m
//  HuiZhuBang
//
//  Created by hsf on 2018/9/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "LiveLikeController.h"

#import "NNEmitterView.h"

@interface LiveLikeController ()

@property (nonatomic, strong) NNEmitterView *emitterVeiw;

@end

@implementation LiveLikeController

-(NNEmitterView *)emitterVeiw{
    if (!_emitterVeiw) {
        _emitterVeiw = [[NNEmitterView alloc] initWithFrame:CGRectMake(300, 667.0 - 60 - 400, 80, 400)];
        
    }
    return _emitterVeiw;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = self.vcName;
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backView"]];
    backImage.frame = self.view.bounds;
    [self.view addSubview:backImage];
    UIButton * btn = ({
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(300, 667.0 - 75, 40, 40);
        button.tag = 100;

        [button setTitle:@"like" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(handActionSender:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"click"] forState:UIControlStateNormal];
        button;
    });
    
    [self.view addSubview:btn];
    
    [self.view addSubview:self.emitterVeiw];
    
    [self.view getViewLayer];
}

- (void)handActionSender:(UIButton *)sender{
    [self.emitterVeiw sendUpEmitter];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
}

@end
