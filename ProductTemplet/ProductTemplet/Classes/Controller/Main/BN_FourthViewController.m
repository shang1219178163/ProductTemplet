//
//  BN_FourthViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "BN_FourthViewController.h"

#import <FLAnimatedImage/FLAnimatedImage.h>

#import "BN_Category.h"

@interface BN_FourthViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UITabBarItem *tabBarItem;

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
        
        UIColor.themeColor = self.imgView.tintColor;
        
        self.sliderView.backgroundColor = UIColor.themeColor;
    }];
//    self.imgView.image = [self.imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    
    [self.view addSubview:self.sliderView];
    self.sliderView.layer.borderColor = UIColor.blueColor.CGColor;
    self.sliderView.layer.borderWidth = 1.0;
    
    CGRect rect = CGRectMake(UIScreen.width/2.0, 20, 100, 100);
    UIImageView *imgView = [UIView createImgViewRect:rect image:@"Item_first_N" tag:100 type:@0];
    [self.view addSubview:imgView];
    
    imgView.backgroundColor = UIColor.randomColor;
    imgView.tintColor = UIColor.whiteColor;
    imgView.image = [imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, CGRectGetMaxY(self.imgView.frame) + 20, 100, 100);
    
    [btn setBackgroundImage:UIImageFromName(@"Item_first_N") forState:UIControlStateNormal];
    [btn setBackgroundImage:UIImageFromName(@"Item_first_H") forState:UIControlStateHighlighted];
    [self.view addSubview:btn];
    
    
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

    [self.view getViewLayer];
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


-(UIView *)sliderView{
    if (!_sliderView) {
        _sliderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 240, CGRectGetWidth(self.view.frame), 100)];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(view.frame) - 80, 0, 80, CGRectGetHeight(view.frame))];
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            label.text = @"个数";
            [view addSubview:label];
            
            UISlider *slider = [UIView createSliderRect:CGRectMake(0, 0, CGRectGetWidth(view.frame) - CGRectGetWidth(label.frame), CGRectGetHeight(view.frame)) value:70 minValue:10 maxValue:110];
            slider.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            [slider addActionHandler:^(UIControl * _Nonnull obj) {
                UISlider * sender = (UISlider *)obj;
                label.text = [@"个数" stringByAppendingFormat:@"(%@)",@(sender.value)];
                
            } forControlEvents:UIControlEventValueChanged];
            [view addSubview:slider];
            view;
        });
    }
    return _sliderView;
}


@end
