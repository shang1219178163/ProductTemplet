//
//  CardView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/9/4.
//  Copyright © 2019 BN. All rights reserved.
//

#import "CardView.h"


@interface CardView ()

@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UIView * rightView;


@end

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
        
        _leftView.backgroundColor = UIColor.greenColor;
        _rightView.backgroundColor = UIColor.yellowColor;

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    NSArray *list = @[self.leftView, self.rightView];
    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    [list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@20);
        make.height.equalTo(@100);
    }];
}

- (void)setLeftColor:(UIColor *)leftColor {
    _leftColor = leftColor;
    self.leftView.backgroundColor = _leftColor;
}

- (void)setRightColor:(UIColor *)rightColor {
    _rightColor = rightColor;
    self.rightView.backgroundColor = _rightColor;
}

- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [[UIView alloc]init];
    }
    return _leftView;
}

- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [[UIView alloc]init];
    }
    return _rightView;
}

@end
