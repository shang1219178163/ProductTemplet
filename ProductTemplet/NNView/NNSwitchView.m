//
//  NNSwitchView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNSwitchView.h"

#import <NNGloble/NNGloble.h>
#import "UIView+Helper.h"
#import "UISwitch+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation NNSwitchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labelLeft];
        [self addSubview:self.switchCtl];
        
        self.ctlAlignment = NSTextAlignmentRight;
        [self setupConstraint];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [self setupConstraint];
}

- (void)setupConstraint{
    CGSize labelLeftSize = [self.labelLeft sizeThatFits:CGSizeMake(CGFLOAT_MAX, 35)];
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kX_GAP);
        make.size.equalTo(labelLeftSize);
    }];
    
    CGFloat width = self.sizeWidth - self.labelLeft.maxX - kX_GAP;
    CGFloat ctlWidth = width*0.7;
    switch (self.ctlAlignment) {
        case NSTextAlignmentLeft:
        {
            [self.switchCtl makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self.labelLeft.right).offset((width - ctlWidth)*0.5);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
        default:
        {
            [self.switchCtl makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-kX_GAP);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
    }
    
}

#pragma mark - lazy

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [self createLabelRect:CGRectZero];
        _labelLeft.text = @"是否确认:";
    }
    return _labelLeft;
}


- (UISwitch *)switchCtl{
    if (!_switchCtl) {
        _switchCtl = [[UISwitch alloc]init];
        _switchCtl.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _switchCtl.on = false;
    }
    return _switchCtl;
}

- (UILabel *)createLabelRect:(CGRect)rect{
    UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.font = [UIFont systemFontOfSize:16];
    view.textAlignment = NSTextAlignmentCenter;
    view.userInteractionEnabled = true;
    view.numberOfLines = 1;
    view.lineBreakMode = NSLineBreakByTruncatingTail;
    view.adjustsFontSizeToFitWidth = YES;
    return view;
}


@end
