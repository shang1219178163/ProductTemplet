
//
//  NNGView.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/29.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NNGView.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"

NSString * const kGviewItems         = @"kGview_items";
NSString * const kGviewNumberOfRow   = @"kGview_numberOfRow";
NSString * const kGviewItemHeight    = @"kGview_itemHeight";
NSString * const kGviewPadding       = @"kGview_padding";
NSString * const kGviewType          = @"kGview_type";
NSString * const kGviewIsSingle      = @"kGview_isSingle";
NSString * const kGviewItemsSelected = @"kGview_itemsSelected";

@interface NNGView ()

@property (nonatomic, strong) NSMutableArray * viewList;

@end

@implementation NNGView

+ (instancetype)viewRect:(CGRect)rect params:(NSDictionary *)params{
    NNGView * view = [[self alloc]initWithFrame:rect];
    view.params = params;
    return view;
}

-(void)setParams:(NSDictionary *)params{
    _params = params;
    
    NSParameterAssert([params.allKeys containsObject:kGviewItems]);
    NSParameterAssert([params.allKeys containsObject:kGviewNumberOfRow]);
    
    self.isSingle = YES;
    self.items = params[kGviewItems];
    self.numberOfRow = [params[kGviewNumberOfRow] integerValue];
    if ([params.allKeys containsObject:kGviewIsSingle]) self.isSingle = [params[kGviewIsSingle] boolValue];
    if ([params.allKeys containsObject:kGviewPadding]) self.padding = [params[kGviewPadding] floatValue];
    if ([params.allKeys containsObject:kGviewItemHeight]) self.itemHeight = [params[kGviewItemHeight] floatValue];
    if ([params.allKeys containsObject:kGviewItemsSelected]) self.selectedList = params[kGviewItemsSelected];

    NSInteger rowCount = self.items.count % self.numberOfRow == 0 ? self.items.count/self.numberOfRow : self.items.count/self.numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(self.frame) - (self.numberOfRow - 1)*self.padding)/self.numberOfRow;
    self.itemHeight = self.itemHeight == 0.0 ? itemWidth : self.itemHeight;
    CGFloat height = rowCount * self.itemHeight + (rowCount - 1) * self.padding;
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), height);
    
    self.itemSize = CGSizeMake(itemWidth, self.itemHeight);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor = UIColor.whiteColor;
    self.viewList = [NSMutableArray arrayWithCapacity:0];
    
    for (NSInteger i = 0; i< _items.count; i++) {
        CGFloat w = self.itemSize.width;
        CGFloat h = self.itemSize.height;
        CGFloat x = (i % _numberOfRow) * (w + _padding);
        CGFloat y = (i / _numberOfRow) * (h + _padding);
        
        NSString *title = _items[i];
        CGRect itemRect = CGRectMake(x, y, w, h);
        
        UIButton *sender = [UIButton createRect:itemRect title:title type:NNButtonTypeTitleWhiteAndBackgroudTheme];
        sender.titleLabel.font = [UIFont systemFontOfSize:15];
        sender.tag = kTAG_VIEW+i;

        BOOL isSelected = [_selectedList[sender.tag - kTAG_VIEW] boolValue];
        sender.selected = isSelected;
        
        @weakify(self);
        [sender addActionHandler:^(UIButton * _Nonnull sender) {
            @strongify(self)
            sender.selected = !sender.selected;
            [self.selectedList replaceObjectAtIndex:sender.tag withObject:@(sender.selected)];
            [self hanleActionView:sender isSingle:self.isSingle];
            //传递数据
            if (self.block) {
                self.block(self, sender, sender.tag);
            }
        } forControlEvents:UIControlEventTouchUpInside];
                
//        view.backgroundColor = UIColor.randomColor;
        [self addSubview:sender];
        [self.viewList addObject:sender];
    }
}

- (void)hanleActionView:(UIView *)view isSingle:(BOOL)isSingle{
    if (isSingle == NO) {
        return;
    }
    
    if (self.viewList.count == 1) {
        UIButton *sender = [self.viewList firstObject];
        [_selectedList replaceObjectAtIndex:0 withObject:@(sender.selected)];
        return;
    }

    for (NSInteger i = 0; i < self.viewList.count; i++) {
        UIButton *sender = self.viewList[i];
        if (sender.tag == view.tag) {
            [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
            continue;
        }
        sender.selected = NO;
        [_selectedList replaceObjectAtIndex:i withObject:@(sender.selected)];
    }
}

@end
