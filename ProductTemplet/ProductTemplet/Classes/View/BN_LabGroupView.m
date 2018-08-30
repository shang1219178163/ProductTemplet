//
//  BN_LabGroupView.m
//  ChildViewControllers
//
//  Created by hsf on 2018/4/11.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "BN_LabGroupView.h"

@interface BN_LabGroupView()

@property (nonatomic, assign) CGFloat widthMax;
@property (nonatomic, assign) CGFloat heightMax;
@property (nonatomic, assign) CGFloat W_item;
@property (nonatomic, assign) CGFloat H_item;

@property (nonatomic, assign) CGFloat padding;

@end

@implementation BN_LabGroupView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        
        _itemSize = CGSizeMake(80, 50);
        _padding = 5;
        _style = @1;
    }
    return self;
}

-(void)createItemView{
    if (!_titleList) return;
    
    for (NSInteger i = 0; i < _titleList.count; i++) {
        UILabel * label = [UIView createLabelWithRect:CGRectZero text:_titleList[i] textColor:nil tag:kTAG_LABEL+i patternType:@"0" font:15 backgroudColor:[UIColor randomColor] alignment:NSTextAlignmentCenter];
//        label.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionSender:)];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
        [self addSubview:label];
        
    }
}

- (void)handleActionSender:(UITapGestureRecognizer *)sender{
    UILabel * label = (UILabel *)sender.view;
    if (self.block) {
        self.block(self, label, [self.titleList indexOfObject:label.text]);
    }
    
}

-(void)setTitleList:(NSArray *)titleList{
    _titleList = titleList;
    if (self.subviews.count > 0) return;
//    DDLog(@"%@",@(self.subviews.count));
    [self createItemView];
    
}

-(void)setItemSize:(CGSize)itemSize{
    _itemSize = itemSize;
    
    if ([_style isEqualToNumber:@0]) {
        __block CGRect rect = CGRectZero;
        [self.subviews enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                rect = CGRectMake(CGRectGetMaxX(rect), _padding, self.W_item, self.H_item);
    
            }else{
                rect = CGRectMake(CGRectGetMaxX(rect)+_padding, _padding, self.W_item, self.H_item);
            
            }
            obj.frame = rect;
            obj.text = self.titleList[idx];
            
        }];
    }
    else{
        __block CGRect rect = CGRectZero;
        [self.subviews enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            rect = CGRectMake(CGRectGetMaxX(rect)+_padding, _padding, self.W_item, self.H_item);
            
            obj.frame = rect;
            obj.text = self.titleList[idx];
            
        }];
    }
    
 
}

//-(void)setItemSize:(CGSize)itemSize{
//    _itemSize = itemSize;
//
//    CGFloat widthMax = (CGRectGetWidth(self.frame) - (self.titleList.count - 1)*_padding)/self.titleList.count;
//    CGFloat heightMax = CGRectGetHeight(self.frame) - _padding*2;
//
//    CGFloat w_item =  MIN(_itemSize.width, widthMax);
//    CGFloat H_item =  MIN(_itemSize.height, heightMax);
//
//    __block CGRect rect = CGRectZero;
//    [self.subviews enumerateObjectsUsingBlock:^(UILabel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (idx == 0) {
//            rect = CGRectMake(CGRectGetMaxX(rect), _padding, w_item, H_item);
//
//        }else{
//            rect = CGRectMake(CGRectGetMaxX(rect)+_padding, _padding, w_item, H_item);
//
//        }
//        obj.frame = rect;
//        obj.text = self.titleList[idx];
//
//    }];
//}

#pragma mark - -layz

-(CGFloat)widthMax{
    if (!_widthMax) {
        if ([_style isEqualToNumber:@0]) {
            _widthMax = (CGRectGetWidth(self.frame) - (self.titleList.count - 1)*_padding)/self.titleList.count;

        }else{
            _widthMax = (CGRectGetWidth(self.frame) - (self.titleList.count + 1)*_padding)/self.titleList.count;

        }
    }
    return _widthMax;
}

-(CGFloat)heightMax{
    if (!_heightMax) {
        _heightMax = CGRectGetHeight(self.frame) - _padding*2;
    }
    return _heightMax;
}

-(CGFloat)W_item{
    if (!_W_item) {
        _W_item = MIN(self.itemSize.width, self.widthMax);
    }
    return _W_item;
}

-(CGFloat)H_item{
    if (!_H_item) {
        _H_item = MIN(self.itemSize.height, self.heightMax);
    }
    return _H_item;
}

@end
