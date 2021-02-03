//
//  NNButtonGroupView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2021/1/22.
//  Copyright © 2021 BN. All rights reserved.
//

#import "NNButtonGroupView.h"


@interface NNButtonGroupView()

@property (nonatomic, strong, readwrite) NSMutableArray<UIButton *> *itemList;
@property (nonatomic, strong, readwrite) NSMutableArray<NNButton *> *selectedList;

@end

@implementation NNButtonGroupView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cornerRadius = 5;
        _borderWidth = 0.5;
        _fontSize = 15;
        
        _numberOfRow = 4;
        _padding = 5;
        _lineColor = UIColor.lineColor;
        _titleColor = UIColor.grayColor;
        _backgroudColor = UIColor.whiteColor;
        _backgroudImage = UIImageColor(UIColor.whiteColor);
        
        _selectedLineColor = UIColor.systemBlueColor;
        _selectedTitleColor = UIColor.systemBlueColor;
        _selectedBackgroudColor = UIColor.whiteColor;
        _selectedBackgroudImage = UIImageColor(UIColor.whiteColor);
        
        _iconSize = CGSizeMake(35, 14);
        
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat originX = CGRectGetMinX(self.bounds);
    CGFloat originY = CGRectGetMinY(self.bounds);
    
    if (width <= 10 || height <= 10) {
        return;
    }

    NSInteger rowCount = self.itemList.count % self.numberOfRow == 0 ? self.itemList.count/self.numberOfRow : self.itemList.count/self.numberOfRow + 1;
    CGFloat itemWidth = (width - (self.numberOfRow - 1)*self.padding)/(self.numberOfRow);
    CGFloat itemHeight = (height - (rowCount - 1)*self.padding)/(rowCount);
    
    [self.itemList enumerateObjectsUsingBlock:^(UIButton * _Nonnull sender, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = (idx % self.numberOfRow) * (itemWidth + self.padding);
        CGFloat y = (idx / self.numberOfRow) * (itemHeight + self.padding);
        CGRect rect = CGRectMake(x, y, itemWidth, itemHeight);
        
        switch (self.showStyle) {
            case NNButtonShowStyleTopRightToLeft:
            {
                rect = CGRectMake(width - originX - itemWidth,
                                  originY,
                                  itemWidth,
                                  itemHeight);
            }
                break;
            case NNButtonShowStyleBottomLeftToRight:
            {
                rect = CGRectMake(originX,
                                  height - originY - itemHeight,
                                  itemWidth,
                                  itemHeight);
            }
                break;
            case NNButtonShowStyleBottomRightToLeft:
            {
                rect = CGRectMake(width - originX - itemWidth,
                                  height - originY - itemHeight,
                                  itemWidth,
                                  itemHeight);
            }
                break;
            default:
                break;
        }
        
        sender.frame = rect;
        if (self.cornerRadius > 0) {
            sender.layer.cornerRadius = self.cornerRadius;
            sender.layer.masksToBounds = true;
        }
        
        sender.layer.borderWidth = self.borderWidth;
        sender.layer.borderColor = sender.isSelected ? self.selectedLineColor.CGColor : self.lineColor.CGColor;
    }];

}

#pragma mark -get,set

- (void)setItems:(NSArray<NSString *> *)items{
    _items = items;
    
    [self.itemList removeAllObjects];
    [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NNButton *sender = [NNButton buttonWithType:UIButtonTypeCustom];
        [sender setTitle:obj forState:UIControlStateNormal];
        [sender setTitleColor:self.titleColor forState:UIControlStateNormal];
        [sender setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        
        [sender setBackgroundImage:self.backgroudImage forState:UIControlStateNormal];
        [sender setBackgroundImage:self.selectedBackgroudImage forState:UIControlStateSelected];
        sender.adjustsImageWhenHighlighted = true;
        
        sender.titleLabel.font = [UIFont systemFontOfSize:self.fontSize];
        [sender addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
        
        sender.iconSize = self.iconSize;
        sender.iconLocation = self.iconLocation;

        [self.itemList addObject:sender];
    }];
}

- (NSArray<NNButton *> *)selectedList{
    __block NSMutableArray *marr = [NSMutableArray array];
    [self.itemList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected) {
            [marr addObject:obj];
        }
    }];
    return marr.copy;
}

- (void)setSelectedIdxList:(NSArray<NSNumber *> *)selectedIdxList{
    [self.itemList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = [selectedIdxList containsObject:@(obj.tag)];
        obj.layer.borderColor = obj.isSelected ? self.selectedLineColor.CGColor : self.lineColor.CGColor;
    }];
}

- (NSArray<NSNumber *> *)selectedIdxList{
    __block NSMutableArray *marr = [NSMutableArray array];
    [self.selectedList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [marr addObject:@(obj.tag)];
    }];
    return marr.copy;
}


#pragma mark -funtions

- (void)handleAction:(UIButton *)sender {
    bool invalid = self.hasLessOne && sender.isSelected;
    if (invalid) {
        DDLog(@"%@", @"最少选择一个");
        return;
    }
    
    sender.selected = !sender.isSelected;
    sender.layer.borderColor = sender.isSelected ? self.selectedLineColor.CGColor : self.lineColor.CGColor;

    if (sender.isSelected) {
        if (self.isMutiChoose) {
            for (NNButton *sender in self.selectedList) {
                sender.selected = false;
                sender.layer.borderColor = sender.isSelected ? self.selectedLineColor.CGColor : self.lineColor.CGColor;
            }
            [self.itemList enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.selected = false;
            }];
        }
    }
    
}

@end
