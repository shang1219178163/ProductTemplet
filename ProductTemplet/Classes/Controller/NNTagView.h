//
//  NNTagView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2020/1/15.
//  Copyright © 2020 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNTagView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

// 标签数组
@property (nonatomic, strong) NSArray* tagArray;

// 选中标签文字颜色
@property (nonatomic, strong) UIColor* textColorSelected;
// 默认标签文字颜色
@property (nonatomic, strong) UIColor* textColorNormal;

// 选中标签背景颜色
@property (nonatomic, strong) UIColor* backgroundColorSelected;
// 默认标签背景颜色
@property (nonatomic, strong) UIColor* backgroundColorNormal;

@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, assign) BOOL hasDefaultIndex;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL canSelectedIndex;

@end

NS_ASSUME_NONNULL_END
