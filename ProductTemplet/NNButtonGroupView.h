//
//  NNButtonGroupView.h
//  ProductTemplet
//
//  Created by Bin Shang on 2021/1/22.
//  Copyright © 2021 BN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NNGloble/NNGloble.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NNButtonShowStyle) {
    NNButtonShowStyleTopLeftToRight,
    NNButtonShowStyleTopRightToLeft,
    NNButtonShowStyleBottomLeftToRight,
    NNButtonShowStyleBottomRightToLeft
};

@interface NNButtonGroupView : UIView

@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, assign) CGFloat fontSize;

@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat padding;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIImage *backgroudImage;
@property (nonatomic, strong) UIColor *backgroudColor;
@property (nonatomic, strong) UIColor *selectedLineColor;
@property (nonatomic, strong) UIColor *selectedTitleColor;
@property (nonatomic, strong) UIImage *selectedBackgroudImage;
@property (nonatomic, strong) UIColor *selectedBackgroudColor;
@property (nonatomic, assign) CGSize iconSize;

@property (nonatomic, assign) NNButtonShowStyle showStyle;
@property (nonatomic, assign) NNButtonLocation iconLocation;

@property (nonatomic, assign) bool hasLessOne;
@property (nonatomic, assign) bool isMutiChoose;
@property (nonatomic, assign) bool hideImage;

@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, strong) NSArray<NSNumber *> *selectedIdxList;
@property (nonatomic, strong, readonly) NSArray<NNButton *> *selectedList;

@end

NS_ASSUME_NONNULL_END
