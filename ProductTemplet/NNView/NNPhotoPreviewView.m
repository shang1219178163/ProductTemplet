//
//  NNPhotosView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/10/19.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NNPhotosView.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"
#import "SDCycleScrollView.h"

@interface NNPhotosView ()

@property (nonatomic, strong) UIView *maskView;
//@property (nonatomic, strong) UIView *containView;

@property (nonatomic, assign) NSInteger index;

@end

@implementation NNPhotosView

-(instancetype)initWithImages:(NSArray *)images{
    self = [super init];
    if (self) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        self.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
        self.backgroundColor = UIColor.blackColor;
                                
        self.maskView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskView.backgroundColor = UIColor.blackColor;
//        self.maskView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionTap:)];
        
        [self.maskView addGestureRecognizer:tap];
        
        CGFloat height = CGRectGetWidth(window.frame)/kRatio_IDCard;
        CGFloat YGap = (CGRectGetHeight(window.frame) - height)/2.0;
        
        CGRect imgViewRect = CGRectMake(0, YGap, CGRectGetWidth(window.frame), height);
        imgViewRect = self.frame;

        UIImage * imageDefault = UIImage.img_failedDefault;
        // 网络加载 --- 创建带标题的图片轮播器(1. SDCycleScrollView的backgroundImageView需要隐藏(圆角图片会出现bug) self.backgroundImageView.hidden = YES;2.    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;)
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:imgViewRect delegate:nil placeholderImage:imageDefault];
        cycleScrollView.backgroundColor = UIColor.blackColor;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;

        //        cycleScrollView2.titlesGroup = titles;
        cycleScrollView.currentPageDotColor = UIColor.whiteColor; // 自定义分页控件小圆标颜色
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
    UIWindow *window = UIApplication.sharedApplication.keyWindow;
    
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

@end
