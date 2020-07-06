//
//  NNFourthViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NNFourthViewController.h"

#import "ZYSliderViewController.h"

#import <YYImage/YYImage.h>

#import "BNSliderControlView.h"
#import "NNPickerView.h"

#import <YYModel/YYModel.h>
#import "NNCheckVersApi.h"
#import "NNRootAppInfoModel.h"

@interface NNFourthViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UITabBarItem *tabBarItem;
@property (nonatomic, strong) NNSegmentView * segmentView;
@property (nonatomic, strong) BNSliderControlView * sliderControlView;
@property (nonatomic, strong) NNPickerView * pickerView;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong)  NNCheckVersApi *api;

@end

@implementation NNFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self addControllerName:@"FontListController"];
//    [self addControllerName:@"FriendListController"];
    [self createBarItemTitle:nil imgName:@"Item_fourth_H" isLeft:NO isHidden:NO handler:^(id obj, UIButton *item, NSInteger idx) {
        [self.pickerView show];

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
        
        
//        UITabBarItem *tabBarItem = [UITabBarItem createItem:@"title" image:@"Item_third_H" selectedImage:@"Item_first_H"];
//        tabBarController.viewControllers.firstObject.tabBarItem = tabBarItem;

        NSArray *list = @[@[@"NNFirstViewController",@"首页",@"Item_third_N",@"Item_third_H",@"0",],
                          @[@"NNSecondViewController",@"圈子",@"Item_second_N",@"Item_second_H",@"11",],
                          @[@"NNCenterViewController",@"总览",@"Item_center_N",@"Item_center_H",@"10",],
                          @[@"NNThirdViewController",@"消息",@"Item_third_N",@"Item_third_H",@"12",],
                          @[@"NNFourthViewController",@"我的",@"Item_fourth_N",@"Item_fourth_H",@"13",],
                          
                          ];
        [tabBarController reloadTabarItems:list];
        self.sliderView.backgroundColor = UIColor.themeColor;
    }];
//    self.imgView.image = [self.imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    [self.imgView addGestureTap:^(UIGestureRecognizer *sender) {
        [sender.view imageToSavedPhotosAlbum:^(NSError *error) {
            if (error) {
                DDLog(@"%@",error.description);
            }
            DDLog(@"保存图像成功!");
        }];
    }];
    
    [self.view addSubview:self.sliderView];
    self.sliderView.layer.borderColor = UIColor.blueColor.CGColor;
    self.sliderView.layer.borderWidth = 1.0;
    
    CGRect rect = CGRectMake(UIScreen.width/2.0, 20, 100, 100);
    UIImageView *imgView = ({
        UIImageView *view = [UIImageView createRect:rect type:@0];
        view.image = [UIImage imageNamed:@"Item_first_N"];
        view.tag = 100;
        view;
    });
    
    [self.view addSubview:imgView];
    
    imgView.tintColor = UIColor.themeColor;

    CGRect rect1 = CGRectMake(UIScreen.width/2.0 + 120, 20, 100, 100);
    UIImageView *imgView1 = ({
        UIImageView *view = [UIImageView createRect:rect1 type:@0];
        view.image = [UIImage imageNamed:@"Item_first_H"];
        view.tag = 101;
        view;
    });
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
    
    self.label.text = @"滑动开始运客";
    self.label.frame = CGRectMake(kX_GAP, CGRectGetMaxY(self.segmentView.frame)+kY_GAP, kScreenWidth - kX_GAP*2, 30);
    [self.view addSubview:self.label];
    
    [self.label sizeToFit];
    [self flashAnimationMask:self.label];

    self.sliderControlView.frame = CGRectMake(kX_GAP, CGRectGetMaxY(self.label.frame), kScreenWidth - kX_GAP*2, 40);
    [self.view addSubview:self.sliderControlView];
    
//    [self.view getViewLayer];
    
    [NSUserDefaults.standardUserDefaults setObject:@"nil" forKey:@"1111"];
    [NSUserDefaults.standardUserDefaults setObject:nil forKey:@"1111"];

//    DDLog(@"%@", NSHomeDirectory())
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIImage *image = [YYImage imageNamed:@"loading.gif"];
    UIImageView *imgView = [[YYAnimatedImageView alloc] initWithImage:image];
    imgView.frame = CGRectMake(10, 10, 40, 40);
    [self.view addSubview:imgView];
    
    [self.api requestWithSuccessBlock:^(NNRequstManager * _Nonnull manager, id responseObject, NSError * _Nullable error) {
        DDLog(@"%@",responseObject);
        NNRootAppInfoModel *model = [NNRootAppInfoModel yy_modelWithJSON:responseObject];

        [NNCacheManager.shared setObject:model forKey:kCacheKeyUserModel];
        NNRootAppInfoModel *userModel = [NNCacheManager.shared objectForKey:kCacheKeyUserModel];
        DDLog(userModel.description);
    } failedBlock:^(NNRequstManager * _Nonnull manager, id _Nullable responseObject, NSError * _Nullable error) {
        DDLog(@"%@",error.message);

    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)flashAnimationMask:(UILabel *)label{
    CAGradientLayer *graLayer = CAGradientLayer.layer;
    graLayer.frame = label.bounds;
    graLayer.colors = @[(__bridge id)[UIColor.greenColor colorWithAlphaComponent:0.3].CGColor,
                        (__bridge id)UIColor.yellowColor.CGColor,
                        (__bridge id)[UIColor.yellowColor colorWithAlphaComponent:0.3].CGColor];

    graLayer.startPoint = CGPointMake(0, 0);//设置渐变方向起点
    graLayer.endPoint = CGPointMake(1, 0);  //设置渐变方向终点
    graLayer.locations = @[@(0.0), @(0.0), @(0.1)]; //colors中各颜色对应的初始渐变点

    // 第二步：通过设置颜色渐变点(locations)动画，达到预期效果
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"locations"];
    anim.duration = 3.0f;
    anim.toValue = @[@(0.9), @(1.0), @(1.0)];
    anim.removedOnCompletion = NO;
    anim.repeatCount = HUGE_VALF;
    anim.fillMode = kCAFillModeForwards;
    [graLayer addAnimation:anim forKey:@"xindong"];
    
    label.layer.mask = graLayer;
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
            
            UISlider *slider = [UISlider createRect:CGRectMake(0, 0, CGRectGetWidth(view.frame) - CGRectGetWidth(label.frame), CGRectGetHeight(view.frame)) value:70 minValue:10 maxValue:110];
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

-(NNSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[NNSegmentView alloc]initWithFrame: CGRectZero];
        _segmentView.segmentCtl.items = @[@"one",@"two",@"three",@"four"];
        _segmentView.indicatorHeight = 1;
        _segmentView.type = 2;
        
    }
    return _segmentView;
}

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:17];
            //            label.textColor = UIColor.grayColor;
            label.textAlignment = NSTextAlignmentLeft;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
            label;
        });
    }
    return _label;
}

-(BNSliderControlView *)sliderControlView{
    if (!_sliderControlView) {
        _sliderControlView = [[BNSliderControlView alloc]initWithFrame:CGRectZero];
        _sliderControlView.text = @"滑动开始运客";
        _sliderControlView.textFinish = @"操作成功!";
        _sliderControlView.thumbImage = [UIImage imageNamed:@"icon_operation_busy"];
        _sliderControlView.thumbFinishImage = [UIImage imageNamed:@"icon_oprationSuccess"];
    }
    return _sliderControlView;
}

-(NNPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[NNPickerView alloc]initWithFrame:CGRectZero];
        _pickerView.block = ^(UIPickerView *pickerView, NSInteger btnIndex) {
            NSString * info = [NSString stringWithFormat:@"%@-%@-%@", @([pickerView selectedRowInComponent:0]), @([pickerView selectedRowInComponent:1]), @([pickerView selectedRowInComponent:2])];
            DDLog(@"_%@_:%@",@(btnIndex),info);

        };
    }
    return _pickerView;
}


-( NNCheckVersApi *)api{
    if (!_api) {
        _api = [[ NNCheckVersApi alloc]init];
    }
    return _api;
}


@end
