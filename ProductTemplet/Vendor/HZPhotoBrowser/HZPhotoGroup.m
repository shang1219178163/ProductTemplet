//
//  HZPhotoGroup.m
//  HZPhotoBrowser
//
//  Created by aier on 15-2-4.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "HZPhotoGroup.h"
//#import "HZPhotoItem.h"
#import "UIButton+WebCache.h"
#import "HZPhotoBrowser.h"

#import "HZPhotoBrowserConfig.h"

#define HZPhotoGroupImageMargin 15

@interface HZPhotoGroup () <HZPhotoBrowserDelegate>

@end

@implementation HZPhotoGroup 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 清除图片缓存，便于测试
        [[SDWebImageManager sharedManager].imageCache clearMemory];
        
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}


- (void)setPhotoItemArray:(NSArray *)photoItemArray
{
    _photoItemArray = photoItemArray;
    [photoItemArray enumerateObjectsUsingBlock:^(HZPhotoItem *obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc] init];
        
        //让图片不变形，以适应按钮宽高，按钮中图片部分内容可能看不到
        btn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        btn.clipsToBounds = YES;
        
        [btn sd_setImageWithURL:[NSURL URLWithString:obj.thumbnail_pic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"whiteplaceholder"]];
        btn.tag = idx;
        
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    long imageCount = self.photoItemArray.count;
    int perRowImageCount = ((imageCount == 4) ? 2 : 3);
    perRowImageCount = 4;
    CGFloat perRowImageCountF = (CGFloat)perRowImageCount;
    int totalRowCount = ceil(imageCount / perRowImageCountF); // ((imageCount + perRowImageCount - 1) / perRowImageCount)
    CGFloat w = 80;
    CGFloat h = 80;
    
    if (!CGSizeEqualToSize(self.photoItemSize, CGSizeZero)) {
        w = self.photoItemSize.width;
        h = self.photoItemSize.height;
        
    }
    
    CGFloat padding = (CGRectGetWidth(self.frame) - w * perRowImageCount) / (perRowImageCount - 1);
    [self.subviews enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        
        long rowIndex = idx / perRowImageCount;
        NSInteger columnIndex = idx % perRowImageCount;
        CGFloat x = columnIndex * (w + padding);
        CGFloat y = rowIndex * (h + padding);
        btn.frame = CGRectMake(x, y, w, h);
    }];

    CGRect rect = self.frame;
    rect.size.width = w * perRowImageCount + padding * (perRowImageCount - 1);
    rect.size.height = totalRowCount * (padding + h);
    self.frame = rect;
//    self.frame = CGRectMake(0, 0, kScreenWidth, totalRowCount * (padding + h));
}

- (void)buttonClick:(UIButton *)button
{
    //启动图片浏览器
    HZPhotoBrowser *browser = [[HZPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.photoItemArray.count; // 图片总数
    browser.currentImageIndex = (int)button.tag;
    browser.delegate = self;
    [browser show];
    
}

#pragma mark - photobrowser代理方法

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(HZPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [self.subviews[index] currentImage];
}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(HZPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSString *urlStr = [self.photoItemArray[index] highQuality_pic];
    return [NSURL URLWithString:urlStr];
}

@end
