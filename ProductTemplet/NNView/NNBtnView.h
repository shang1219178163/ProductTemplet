//
//  NNBtnView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/5/17.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//
/**
 图片与文字
 type：图相对文字的位置（上/左/下/右）
 adjustsSizeToFitText = yes; 视图随标题长度调整宽度
 默认右侧小三角（未设置 imageView.image 时自动使用）
 */

 
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NNBtnViewType) {
    NNBtnViewTypeImageTop = 0,    ///< 图上字下
    NNBtnViewTypeImageLeft = 1,   ///< 图左字右
    NNBtnViewTypeImageBottom = 2, ///< 图下字上
    NNBtnViewTypeImageRight = 3,  ///< 图右字左（默认）
};

@interface NNBtnView : UIView

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UIImageView * imageView;

/// 标题与三角形间距，默认 4；也可通过 padding 设置（同义）
@property (nonatomic, assign) CGFloat spacing;
/// 同 spacing（兼容旧代码）
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, assign) CGSize imgSize;
@property (nonatomic, assign) NNBtnViewType type;
@property (nonatomic, assign) BOOL adjustsSizeToFitText;
/// 整体最大宽度；<=0 时默认屏宽-160（给导航栏左右按钮留空）。label 最大宽 = maxWidth - 图标 - spacing
@property (nonatomic, assign) CGFloat maxWidth;

@property (nonatomic, copy) void(^block)(NNBtnView *view);

/// 默认下拉小三角（AlwaysTemplate，可用 imageView.tintColor 着色）
+ (UIImage *)defaultTriangleImage;

/// 按文字 + 图标重算并写入 bounds/frame（titleView 必须调这个，导航栏不认 intrinsicContentSize）
- (void)sizeToFitContent;

-(instancetype)initWithFrame:(CGRect)frame;

@end
