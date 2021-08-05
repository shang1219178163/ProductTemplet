//
//  NNFourthViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NNFourthViewController.h"
#import <Masonry/Masonry.h>
#import <YYImage/YYImage.h>
#import <YYModel/YYModel.h>

#import "ZYSliderViewController.h"

#import "NNSliderControlView.h"
#import "NNPickerView.h"
#import "NNCheckVersApi.h"
#import "NNRootAppInfoModel.h"

@interface NNFourthViewController ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *sliderView;
@property (nonatomic, strong) UITabBarItem *tabBarItem;
@property (nonatomic, strong) NNSegmentView * segmentView;
@property (nonatomic, strong) NNSliderControlView * sliderControlView;
@property (nonatomic, strong) NNPickerView * pickerView;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NNCheckVersApi *api;

@end

@implementation NNFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
//    [self addControllerName:@"FontListController"];
//    [self addControllerName:@"FriendListController"];
    
    [self createBarItem:@"Show" isLeft:NO handler:^(UIButton *sender) {
        [self.pickerView show];

    }];
    
    

    
//    @weakify(self)
//    [self.imgView addGestureTap:^(UITapGestureRecognizer * _Nonnull reco) {
//        @strongify(self)
//        self.imgView.tintColor = UIColor.randomColor;
//        self.imgView.image = [self.imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//
//        UIColor.themeColor = self.imgView.tintColor;
//
//        ZYSliderViewController *rootVC = UIApplication.rootController;
//        UITabBarController *tabBarController = rootVC.mainViewController;
//        tabBarController.tabBar.tintColor = UIColor.themeColor;
//
//
////        UITabBarItem *tabBarItem = [UITabBarItem createItem:@"title" image:@"Item_third_H" selectedImage:@"Item_first_H"];
////        tabBarController.viewControllers.firstObject.tabBarItem = tabBarItem;
//
//        NSArray *list = @[@[@"NNFirstViewController",@"首页",@"Item_third_N",@"Item_third_H",@"0",],
//                          @[@"NNSecondViewController",@"圈子",@"Item_second_N",@"Item_second_H",@"11",],
//                          @[@"NNCenterViewController",@"总览",@"Item_center_N",@"Item_center_H",@"10",],
//                          @[@"NNThirdViewController",@"消息",@"Item_third_N",@"Item_third_H",@"12",],
//                          @[@"NNFourthViewController",@"我的",@"Item_fourth_N",@"Item_fourth_H",@"13",],
//
//                          ];
//        [tabBarController reloadTabarItems:list];
//        self.sliderView.backgroundColor = UIColor.themeColor;
//    }];
//    self.imgView.image = [self.imgView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    
    [self.view addSubview:self.sliderView];
    self.sliderView.layer.borderColor = UIColor.blueColor.CGColor;
    self.sliderView.layer.borderWidth = 1.0;
    
    CGRect rect = CGRectMake(UIScreen.width/2.0, 20, 100, 100);
    UIImageView *imgView = ({
        UIImageView *view = [UIImageView createRect:rect];
        view.image = [UIImage imageNamed:@"Item_first_N"];
        view.tag = 100;
        view;
    });
    imgView.tintColor = UIColor.themeColor;
    [self.view addSubview:imgView];
    

    CGRect rect1 = CGRectMake(UIScreen.width/2.0 + 120, 20, 100, 100);
    UIImageView *imgView1 = ({
        UIImageView *view = [UIImageView createRect:rect1];
        view.image = [UIImage imageNamed:@"Item_first_H"];
        view.tag = 101;
        view;
    });
    [self.view addSubview:imgView1];
    
//    imgView1.tintColor = UIColor.grayColor;
    imgView1.tintColor = UIColor.themeColor;
//    imgView1.image = [imgView1.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, CGRectGetMaxY(self.imgView.frame) + 20, 150, 100);
    
//    [btn setBackgroundImage:UIImageNamed(@"Item_first_N") forState:UIControlStateNormal];
//    [btn setBackgroundImage:UIImageNamed(@"Item_first_H") forState:UIControlStateHighlighted];
    [btn setTitle:@"按钮点击事件" forState:UIControlStateNormal];
    [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 0;
    [btn addActionHandler:^(UIButton * _Nonnull sender) {
        DDLog(@"name: %@", sender.titleLabel.text);
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
        
    
    NSMutableAttributedString *attStrN = @"正常显示"
    .matt
    .color(UIColor.systemBlueColor);
    
    NSMutableAttributedString *attStrH = @"高亮显示"
    .matt
    .color(UIColor.systemRedColor)
    .bgColor(UIColor.systemOrangeColor)
    .underline(NSUnderlineStyleSingle, UIColor.systemGreenColor);
    
    [btn setAttributedTitle:attStrN forState:UIControlStateNormal];
    [btn setAttributedTitle:attStrH forState:UIControlStateHighlighted];
    
    UILabel *label = [[UILabel alloc]init];
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
    
    
    UIImage *image = [YYImage imageNamed:@"loading.gif"];
    UIImageView *imgViewLoading = [[YYAnimatedImageView alloc] initWithImage:image];
    imgViewLoading.frame = CGRectMake(10, 10, 40, 40);
    [self.view addSubview:imgViewLoading];
    
//    [self.view getViewLayer];
    [NSUserDefaults.standardUserDefaults setObject:@"nil" forKey:@"1111"];
    [NSUserDefaults.standardUserDefaults setObject:nil forKey:@"1111"];

//    DDLog(@"%@", NSHomeDirectory())
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self test];
//    [self requestCheck];

    [self testAtt];
    
    [self testChain];
    
    asyncUI(^id _Nonnull{
        NSString *value = @"111";
        return value;
    }, ^(id value) {
        DDLog(@"value: %@", value);
    });
    
    dispatch_queue_t queue = dispatch_queue_create("me.tutuge.test.gcd", DISPATCH_QUEUE_SERIAL);
    dispatch_apply(3, queue, ^(size_t i) {
        DDLog(@"size_t: %@", @(i));
    });
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -funtions
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

- (void)test {
    NSDictionary *dic = @{
        @"1": @"微信",
        @"2": @"支付宝",
        @"3": @"银商",
    };
    
    NSString *result = [@"1,2,3" mapBySeparator:@"," transform:^NSString *(NSString *obj) {
        return dic[obj];
    }];
    
    NSString *result1 = [@"1,2,3" mapBySeparator:@"," transform:^NSString *(NSString *obj) {
        return [@(obj.integerValue + 10) stringValue];
    }];
    DDLog(@"%@_%@", result, result1);


    id obj = @"3,1,9,6,7,4,5".separatedBy(@",").sorted(@selector(compare:)).reversed.joinedBy(@"|");
    DDLog(@"%@", obj);
    
    id obj1 = @"3,1,9,6,7,4,5".separatedBy(@",").append(@[@"qq", @"ww", @"eee"]).sorted(@selector(compare:)).joinedBy(@"|");
    DDLog(@"%@", obj1);
    
//    NSString *bTime = @"2020-01-13 09:43:50";
//    NSString *eTime = @"2020-02-13 09:43:50";
//    
//    NSDate *startDate = [NSDateFormatter dateFromString:bTime fmt:kDateFormatDay];
//    NSDate *endDate = [NSDateFormatter dateFromString:eTime fmt:kDateFormatDay];
//    NSArray *days = [NSDateFormatter betweenDaysWithDate:startDate toDate:endDate block:^(NSDateComponents * _Nonnull comps, NSDate * _Nonnull date) {
////        DDLog(@"%@", date);
//    }];
//    DDLog(@"%@", days);
}

- (void)testAtt {
    [UIView animateWithDuration:0 animations:^{
            
    }];
    
}

- (void)testChain {
    NSMutableDictionary *mdic = @{
        @"1" : @"a",
        @"2" : @"b",
        @"3" : @"c",
        @"4" : @"d",
        @"5" : @"e",
        @"6" : @"f",
        @"7" : @"g",
        @"8" : @"h",
        
    }.mutableCopy;
    
    NSMutableDictionary *tmp = mdic.addEntries(@{@"111": @"zzz"});
    NSMutableDictionary *tmp1 = mdic.setObjectForKey(@"1", @"aaa");
    NSMutableDictionary *tmp2 = mdic.removeObjectForKey(@"2");
    NSMutableDictionary *tmp3 = mdic.removeObjectsForKeys(@[@"3", @"4", @"5",]);
    DDLog(@"tmp: %@", tmp);
    DDLog(@"tmp1: %@", tmp1);
    DDLog(@"tmp2: %@", tmp2);
    DDLog(@"tmp3: %@", tmp3);
}


- (void)requestCheck {
    [self.api requestWithSuccess:^(NNRequstManager * _Nonnull manager, NSDictionary * _Nonnull jsonData) {
        DDLog(@"%@", jsonData);
        NNRootAppInfoModel *model = [NNRootAppInfoModel yy_modelWithJSON:jsonData];

        [NNCacheManager.shared setObject:model forKey:kCacheKeyUserModel];
        NNRootAppInfoModel *userModel = [NNCacheManager.shared objectForKey:kCacheKeyUserModel];
        DDLog(@"userModel.description: %@", userModel.description);
    } fail:^(NNRequstManager * _Nonnull manager, NSError * _Nonnull error) {
        DDLog(@"%@", error.message);
    }];
}

#pragma mark -lazy
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
            view.image = [UIImage imageNamed:@"bug.png"];
            view;
        });
        [_imgView addGestureTap:^(UIGestureRecognizer *sender) {
            UIImageView *imgView = (UIImageView *)sender.view;
            [imgView.image saveImageToPhotosAlbum:^(NSError *error) {
                if (error) {
                    DDLog(@"%@",error.description);
                }
                DDLog(@"保存图像成功!");
            }];
        }];
    }
    return _imgView;
}

-(UIView *)sliderView{
    if (!_sliderView) {
        _sliderView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(20, 240, CGRectGetWidth(self.view.frame) - 40, 50)];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(view.frame) - 80, 0, 80, CGRectGetHeight(view.frame))];
            label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            label.text = @"个数";
            [view addSubview:label];
            
            UISlider *slider = [UISlider createRect:CGRectMake(0, 0, CGRectGetWidth(view.frame) - CGRectGetWidth(label.frame), CGRectGetHeight(view.frame)) minValue:10 maxValue:110];
            slider.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            [slider addActionHandler:^(UISlider * _Nonnull sender) {
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

-(NNSliderControlView *)sliderControlView{
    if (!_sliderControlView) {
        _sliderControlView = [[NNSliderControlView alloc]initWithFrame:CGRectZero];
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
        _api = [[NNCheckVersApi alloc]init];
    }
    return _api;
}



@end
