//
//  LiveLikeController.m
//  
//
//  Created by BIN on 2018/9/18.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "LiveLikeController.h"

#import "UIView+Helper.h"
#import "UIViewController+Helper.h"

#import "BNEmitterView.h"

@interface LiveLikeController ()

@property (nonatomic, strong) BNEmitterView *emitterVeiw;

@end

@implementation LiveLikeController

-(BNEmitterView *)emitterVeiw{
    if (!_emitterVeiw) {
        _emitterVeiw = [[BNEmitterView alloc] initWithFrame:CGRectMake(300, 667.0 - 60 - 400, 80, 400)];
        
    }
    return _emitterVeiw;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = self.controllerName;
    
    UIImageView *backImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backView"]];
    backImage.frame = self.view.bounds;
    [self.view addSubview:backImage];
    
    UIButton * btn = [UIButton createBtnRect:CGRectMake(300, 667.0 - 75, 40, 40) title:@"like" image:@"click" type:@0];
    btn.tag = 100;
    [btn addTarget:self action:@selector(handActionSender:) forControlEvents:UIControlEventTouchUpInside];
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
