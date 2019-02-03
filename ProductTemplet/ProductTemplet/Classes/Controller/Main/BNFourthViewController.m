//
//  BNFourthViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "BNFourthViewController.h"

#import "ZYSliderViewController.h"

#import <FLAnimatedImage/FLAnimatedImage.h>

@interface BNFourthViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UITabBarItem *tabBarItem;
@property (nonatomic, strong) BNSegmentView * segmentView;

@end

@implementation BNFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

//    [self addChildControllerView:@"FontListController"];
//    [self addChildControllerView:@"FriendListController"];
    [self createBarItemTitle:nil imgName:@"Item_fourth_H" isLeft:NO isHidden:NO handler:^(id obj, UIButton *item, NSInteger idx) {
        DDLog(@"%@",item);
    }];
    
    
    [self.view addSubview:self.imgView];
    
    @weakify(self)
    [self.imgView addActionHandler:^(id obj, id item, NSInteger idx) {
        @strongify(self)
        self.imgView.tintColor = UIColor.randomColor;
        self.imgView.image = [self.imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        UIColor.themeColor = self.imgView.tintColor;
        
        ZYSliderViewController * rootVC = UIApplication.rootController;
        UITabBarController * tabBarController = rootVC.mainViewController;
        tabBarController.tabBar.tintColor = UIColor.themeColor;
        
        
//        UITabBarItem *tabBarItem = [UIView createTabBarItem:@"title" image:@"Item_third_H" selectedImage:@"Item_first_H"];
//        tabBarController.viewControllers.firstObject.tabBarItem = tabBarItem;

        NSArray *list = @[@[@"BNFirstViewController",@"首页",@"Item_third_N",@"Item_third_H",@"0",],
                          @[@"BNSecondViewController",@"圈子",@"Item_second_N",@"Item_second_H",@"11",],
                          @[@"BNCenterViewController",@"总览",@"Item_center_N",@"Item_center_H",@"10",],
                          @[@"BNThirdViewController",@"消息",@"Item_third_N",@"Item_third_H",@"12",],
                          @[@"BNFourthViewController",@"我的",@"Item_fourth_N",@"Item_fourth_H",@"13",],
                          
                          ];
        [tabBarController reloadTabarItems:list];
        self.sliderView.backgroundColor = UIColor.themeColor;
    }];
//    self.imgView.image = [self.imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    
    [self.view addSubview:self.sliderView];
    self.sliderView.layer.borderColor = UIColor.blueColor.CGColor;
    self.sliderView.layer.borderWidth = 1.0;
    
    CGRect rect = CGRectMake(UIScreen.width/2.0, 20, 100, 100);
    UIImageView *imgView = [UIView createImgViewRect:rect image:@"Item_first_N" tag:100 type:@0];
    [self.view addSubview:imgView];
    
    imgView.tintColor = UIColor.themeColor;

    CGRect rect1 = CGRectMake(UIScreen.width/2.0 + 120, 20, 100, 100);
    UIImageView *imgView1 = [UIView createImgViewRect:rect1 image:@"Item_first_H" tag:101 type:@0];
    [self.view addSubview:imgView1];
    
//    imgView1.tintColor = UIColor.grayColor;
    imgView1.tintColor = UIColor.themeColor;
//    imgView1.image = [imgView1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, CGRectGetMaxY(self.imgView.frame) + 20, 150, 100);
    
//    [btn setBackgroundImage:UIImageNamed(@"Item_first_N") forState:UIControlStateNormal];
//    [btn setBackgroundImage:UIImageNamed(@"Item_first_H") forState:UIControlStateHighlighted];
    [btn setTitle:@"按钮点击事件" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addActionHandler:^(UIControl * _Nonnull obj) {
        DDLog(btn.titleLabel.text)
        
    } forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.numberOfLines = 0;

    
    NSMutableAttributedString * attStr_N = [btn.titleLabel setContent:@"钮点击事" attDic:AttributeDict(@5)];
    NSMutableAttributedString * attStr_H = [btn.titleLabel setContent:@"钮点击事" attDic:AttributeDict(@2)];
    [btn setAttributedTitle:attStr_N forState:UIControlStateNormal];
    [btn setAttributedTitle:attStr_H forState:UIControlStateHighlighted];
    
    UILabel * label = [[UILabel alloc]init];
    label.frame = CGRectMake(btn.maxX+20, btn.minY, 100, 100);
    label.text = @"这是一串富文本";
//    label.numberOfLines = label.text.length;
    [self.view addSubview:label];
    
//    [label setContent:label.text attDic:dic];

    //
    self.segmentView.frame = CGRectMake(20, self.sliderView.maxY + 20, kScreenWidth - 40, 40);
    [self.view addSubview:self.segmentView];
    self.segmentView.layer.borderWidth = kW_LayerBorder;
    self.segmentView.layer.borderColor = UIColor.blueColor.CGColor;
    
//    [self.view getViewLayer];
    
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
    
    DDLog(@"%.2f,%.2f,%.2f,%.2f,",imgView.minY,imgView.minX,imgView.maxY,imgView.maxX);

    [self.view getViewLayer];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self goController:@"CustomViewController" title:@"Custom"];
//    [self goController:@"EntryViewController" title:@"录入界面封装"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
            view.image = [UIImage imageNamed:@"bug.png"];
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

-(BNSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[BNSegmentView alloc]initWithFrame: CGRectZero];
        _segmentView.segmentCtl.itemList = @[@"one",@"two",@"three",@"four"];
        _segmentView.indicatorHeight = 1;
        _segmentView.type = 2;
        
    }
    return _segmentView;
}

@end
