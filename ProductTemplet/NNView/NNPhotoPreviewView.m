//
//  NNPhotoPreviewView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/10/19.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NNPhotoPreviewView.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"
#import "SDCycleScrollView.h"
#import "SDCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NNPhotoPreviewView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) UIView *maskBgView;
//@property (nonatomic, strong) UIView *containView;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UILabel *indexLabel;

@end

@implementation NNPhotoPreviewView

-(instancetype)initWithImages:(NSArray *)images{
    self = [super init];
    if (self) {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        self.frame = CGRectMake(0, 0, CGRectGetWidth(window.frame), CGRectGetHeight(window.frame));
        self.backgroundColor = UIColor.blackColor;

        self.maskBgView = [[UIView alloc] initWithFrame:window.bounds];
        self.maskBgView.backgroundColor = UIColor.blackColor;
//        self.maskBgView.alpha = 0.5;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];

        [self.maskBgView addGestureRecognizer:tap];

        CGFloat height = CGRectGetWidth(window.frame)/kRatio_IDCard;
        CGFloat YGap = (CGRectGetHeight(window.frame) - height)/2.0;

        CGRect imgViewRect = CGRectMake(0, YGap, CGRectGetWidth(window.frame), height);
        imgViewRect = self.frame;

        UIImage * imageDefault = UIImage.img_failedDefault;
        // 网络加载 --- 创建带标题的图片轮播器(1. SDCycleScrollView的backgroundImageView需要隐藏(圆角图片会出现bug) self.backgroundImageView.hidden = YES;2.    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;)
        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:imgViewRect delegate:self placeholderImage:imageDefault];
        cycleScrollView.backgroundColor = UIColor.blackColor;
        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;

        //        cycleScrollView2.titlesGroup = titles;
        cycleScrollView.showPageControl = NO; // 不显示底部指示器
        cycleScrollView.autoScroll = NO; // 预览器图片不自动滚动
        cycleScrollView.imageURLStringsGroup = images;
        [self.maskBgView addSubview:cycleScrollView];

        [self addSubview:self.maskBgView];

        self.indexLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = UIColor.whiteColor;
            label.font = [UIFont systemFontOfSize:15];
            label.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
            label.text = @"1/1";
            [label sizeToFit];
            CGFloat w = CGRectGetWidth(label.frame) + 24;
            CGFloat h = 30;
            label.frame = CGRectMake((CGRectGetWidth(window.frame) - w) / 2.0, 88, w, h);
            label.layer.cornerRadius = h / 2.0;
            label.layer.masksToBounds = YES;
            label;
        });
        [self addSubview:self.indexLabel];

        self.cycleScrollView = cycleScrollView;
    }
    return self;
}

#pragma mark - SDCycleScrollViewDelegate

/// 使用默认 cell 但自定义图片背景为黑色
- (Class)customCollectionViewCellClassForCycleScrollView:(SDCycleScrollView *)view {
    return SDCollectionViewCell.class;
}

- (void)setupCustomCell:(UICollectionViewCell *)cell forIndex:(NSInteger)index cycleScrollView:(SDCycleScrollView *)view {
    SDCollectionViewCell *cycleCell = (SDCollectionViewCell *)cell;
    cycleCell.imageView.backgroundColor = UIColor.blackColor;
    cycleCell.imageView.contentMode = UIViewContentModeScaleAspectFit;

    NSString *imagePath = self.cycleScrollView.imageURLStringsGroup[index];
    if ([imagePath hasPrefix:@"http"]) {
        [cycleCell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:UIImage.img_failedDefault];
    } else {
        cycleCell.imageView.image = [UIImage imageNamed:imagePath];
    }
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    self.indexLabel.text = [NSString stringWithFormat:@"%ld/%lu", (long)(index + 1), (unsigned long)self.cycleScrollView.imageURLStringsGroup.count];
    // 椭圆宽度随内容自适应并保持水平居中
    [self.indexLabel sizeToFit];
    CGFloat h = 30;
    CGFloat w = CGRectGetWidth(self.indexLabel.frame) + 24;
    self.indexLabel.frame = CGRectMake((CGRectGetWidth(self.frame) - w) / 2.0, 88, w, h);
    self.indexLabel.layer.cornerRadius = h / 2.0;
    self.indexLabel.layer.masksToBounds = YES;
}

- (void)onTap:(UITapGestureRecognizer *)tap{
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
    // 等布局完成后再滚动到指定索引（init 阶段 totalItemsCount 为 0，调用无效）
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.index > 0) {
            [self.cycleScrollView makeScrollViewScrollToIndex:self.index];
        }
        [self cycleScrollView:self.cycleScrollView didScrollToIndex:self.index];
    });
}

-(void)dismiss{
    [self removeFromSuperview];
}

@end
