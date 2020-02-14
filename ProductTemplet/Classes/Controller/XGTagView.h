//
//  XGTagView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2020/1/15.
//  Copyright © 2020 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XGTagView : UIView

/**
 *  初始化
 *
 *  @param frame    frame
 *  @param tagArray 标签数组
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame tagArray:(NSMutableArray*)tagArray;

// 标签数组
@property (nonatomic,retain) NSArray* tagArray;

// 选中标签文字颜色
@property (nonatomic,retain) UIColor* textColorSelected;
// 默认标签文字颜色
@property (nonatomic,retain) UIColor* textColorNormal;

// 选中标签背景颜色
@property (nonatomic,retain) UIColor* backgroundColorSelected;
// 默认标签背景颜色
@property (nonatomic,retain) UIColor* backgroundColorNormal;


@end

NS_ASSUME_NONNULL_END
