//
//  BN_RadioView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const kRadio_title = @"kRadio_title";
static NSString *const kRadio_textColorH = @"kRadio_textColorH";
static NSString *const kRadio_textColorN = @"kRadio_textColorN";

static NSString *const kRadio_imageH = @"kRadio_imageH";
static NSString *const kRadio_imageN = @"kRadio_imageN";


@interface BN_RadioView : UIView

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UILabel * label;

@property (nonatomic, assign) BOOL isSelected;
/**
 地图上方视图添加手势,有时会与地图手势冲突,所以单独做了处理,地图上使用此控件只需 onTheMap置位YES即可
 */
@property (nonatomic, assign) BOOL onTheMap;

@property (nonatomic, copy) void(^block)(BN_RadioView *radioView, UIView *itemView, BOOL isSelected);

-(instancetype)initWithFrame:(CGRect)frame attDict:(NSDictionary *)attDict isSelected:(BOOL)isSelected;


@end
