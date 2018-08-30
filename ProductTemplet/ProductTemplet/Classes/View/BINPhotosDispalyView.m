//
//  BINPhotosDispalyView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/10/19.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINPhotosDispalyView.h"
#import "SDCycleScrollView.h"

@interface BINPhotosDispalyView ()

@property (nonatomic, strong) UIView *maskView;
//@property (nonatomic, strong) UIView *containView;

@property (nonatomic, assign) NSInteger index;

@end

@implementation BINPhotosDispalyView

-(instancetype)initWithImages:(NSArray *)images{
    self = [super init];
    if (self) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        self.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
        self.backgroundColor = [UIColor blackColor];
                                
        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
//        self.maskView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionTap:)];
        
        [self.maskView addGestureRecognizer:tap];
        
        CGFloat height = CGRectGetWidth(window.frame)/kRatio_IDCard;
        CGFloat YGap = (CGRectGetHeight(window.frame) - height)/2.0;
        
        CGRect imgViewRect = CGRectMake(0, YGap, CGRectGetWidth(window.frame), height);
        imgViewRect = self.frame;

        // 网络加载 --- 创建带标题的图片轮播器(1. SDCycleScrollView的backgroundImageView需要隐藏(圆角图片会出现bug) self.backgroundImageView.hidden = YES;2.    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;)
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:imgViewRect delegate:nil placeholderImage:[UIImage imageNamed:kIMAGE_default_failed]];
        cycleScrollView.backgroundColor = [UIColor blackColor];
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;

        //        cycleScrollView2.titlesGroup = titles;
        cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        cycleScrollView.imageURLStringsGroup = images;
        [self.maskView addSubview:cycleScrollView];
        
        [self addSubview:self.maskView];
    }
    return self;
}

- (void)handleActionTap:(UITapGestureRecognizer *)tap{
    [self dismiss];

}

-(void)show{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
//    self.transform = CGAffineTransformMakeScale(2.01, 2.01);
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);

//    UIViewAnimationOptionCurveEaseIn从外往里,UIViewAnimationOptionCurveEaseOut从里往外
    [UIView animateWithDuration:0.15 delay:0.0 options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.transform = CGAffineTransformIdentity;
                         [window addSubview:self];

                     }
                     completion:NULL
     ];

}

-(void)dismiss{
    [self removeFromSuperview];
}

//
//-(instancetype)init{
//    self = [super init];
//    if (self) {
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//
//        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
//        self.maskView.backgroundColor = [UIColor blackColor];
//        self.maskView.alpha = 0.5;
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionTap:)];
//        [self.maskView addGestureRecognizer:tap];
//
//        CGFloat height = CGRectGetWidth(window.frame)/kRatio_IDCard;
//        CGFloat YGap = (CGRectGetHeight(window.frame) - height)/2.0;
//
//        self.containView = [[UIView alloc] initWithFrame:CGRectMake(0, YGap, CGRectGetWidth(window.frame), height)];
//        self.containView.backgroundColor = [UIColor lightGrayColor];
//
//        // 网络加载 --- 创建带标题的图片轮播器
//        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.containView.frame), CGRectGetHeight(self.containView.frame)) delegate:nil placeholderImage:[UIImage imageNamed:kIMAGE_default]];
//
//        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
////        cycleScrollView2.titlesGroup = titles;
//        cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
//        [self.containView addSubview:cycleScrollView2];
//
////        cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
//
//
//    }
//    return self;
//
//}

@end
