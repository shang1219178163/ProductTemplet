//
//  ZYRightViewController.m
//  ZYSliderViewController
//
//  Created by zY on 16/11/11.
//  Copyright © 2016年 zY. All rights reserved.
//

#import "BNRightViewController.h"

@interface BNRightViewController ()

@end

@implementation BNRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createControls];
}

- (void)createControls{
    UIImageView *backImgView = [[UIImageView alloc] init];
    backImgView.image = [UIImage imageNamed:@"right_slider_back"];
    backImgView.frame = self.view.bounds;
    [self.view addSubview:backImgView];
    
}

@end
