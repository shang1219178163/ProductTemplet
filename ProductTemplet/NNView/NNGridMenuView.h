//
//  NNGridMenuView.h
//  ProductTemplet
//
//  Created by BIN on 2026/8/8.
//  Copyright © 2026 BN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class NNGridMenuView;

/// item 格式: @[title, imageName, ...]，至少包含标题与图片名
typedef void(^NNGridMenuViewBlock)(NNGridMenuView *view, NSInteger index, NSArray *item);

@interface NNGridMenuView : UIView

/// @[ @[title, imageName, ...], ... ]
@property (nonatomic, copy) NSArray<NSArray *> *items;
/// 默认 3
@property (nonatomic, assign) NSInteger numberOfColumn;
@property (nonatomic, copy, nullable) NNGridMenuViewBlock block;

+ (CGFloat)heightWithItemCount:(NSInteger)count
                         width:(CGFloat)width
               numberOfColumn:(NSInteger)numberOfColumn;

@end

NS_ASSUME_NONNULL_END
