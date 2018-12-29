//
//  BN_FourthViewController.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_FourthViewController.h"

#import <FLAnimatedImage/FLAnimatedImage.h>

@interface BN_FourthViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation BN_FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//    [self addChildControllerView:@"FontListController"];
//    [self addChildControllerView:@"FriendListController"];
    
    
    [self.view addSubview:self.imgView];
    
    [self.imgView addActionHandler:^(id obj, id item, NSInteger idx) {
       
        self.imgView.tintColor = UIColor.randomColor;
    }];
//    self.imgView.image = [self.imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 240, self.view.frame.size.width-100, 100)];
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width - 100, 100)];
    //    slider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    //    slider.maximumValue = 100;
    //    slider.minimumValue = 10;
    //    //    slider.themeMap = @{kThemeMapKeyMinTrackTintColorName : @"slider_min",
    //    //                        kThemeMapKeyMaxTrackTintColorName : @"slider_max",};
    //    slider.minimumTrackTintColor = UIColor.greenColor;
    //    slider.maximumTrackTintColor = UIColor.redColor;
    //    slider.thumbTintColor = UIColor.yellowColor;
    
    slider = [UIView createSliderRect:CGRectMake(0, 0, headerView.frame.size.width - 100, 100) value:70 minValue:10 maxValue:110];
    [headerView addSubview:slider];
    [self.view addSubview:headerView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString  *filePath = [[NSBundle bundleWithPath:[NSBundle.mainBundle bundlePath]]pathForResource:@"loading" ofType:@"gif"];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfFile:filePath]];
    FLAnimatedImageView *imgView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    imgView.animatedImage = image;
    
//    imgView.animationDuration = 0.8;
//    imgView.animationRepeatCount = 0;
//    [imgView startAnimating];
    
    imgView.backgroundColor = UIColor.redColor;
    
    [self.view addSubview:imgView];
    
    DDLog(@"%.2f,%.2f,%.2f,%.2f,",imgView.x,imgView.y,imgView.width,imgView.height);
    DDLog(@"%.2f,%.2f,%.2f,%.2f,",imgView.minY,imgView.minX,imgView.maxY,imgView.maxX);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
            view.image = [UIImage imageNamed:@"bug1"];
            view;
        });
    }
    return _imgView;
}

@end
