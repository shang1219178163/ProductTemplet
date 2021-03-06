//
//  NNSliderView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNSliderView.h"

#import <NNGloble/NNGloble.h>
#import "UIView+Helper.h"
#import "UISlider+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation NNSliderView

- (void)dealloc{
    [self.sliderCtl removeObserver:self forKeyPath:@"value"];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labelLeft];
        [self addSubview:self.labelRight];
        [self addSubview:self.sliderCtl];
        
        self.labelRight.text = [NSString stringWithFormat:@"%.2f",self.sliderCtl.value];
        self.ctlAlignment = NSTextAlignmentCenter;

        [self.sliderCtl addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"value"]) {
        if ([object isKindOfClass:UISlider.class]) {
            UISlider * slider = (UISlider *)object;
            self.labelRight.text = [NSString stringWithFormat:@"%.2f",slider.value];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];
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
            [self.sliderCtl makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self.labelLeft.right).offset(kPadding);
                make.width.equalTo(ctlWidth);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
            
        case NSTextAlignmentRight:
        {
            [self.sliderCtl makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).offset(-kX_GAP);
                make.width.equalTo(ctlWidth);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
            
        case NSTextAlignmentJustified:
        {
            [self.sliderCtl makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self.labelLeft.right).offset(kPadding);
                make.right.equalTo(self).offset(-kX_GAP);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
            
        default:
        {
            [self.sliderCtl makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.greaterThanOrEqualTo(self.labelLeft.right).offset((width - ctlWidth)*0.5);
                make.width.greaterThanOrEqualTo(ctlWidth);
                make.height.equalTo(self.labelLeft);
            }];
        }
            break;
    }
    
    [self.labelRight makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.greaterThanOrEqualTo(self.sliderCtl.right).offset(kPadding);
        make.right.equalTo(self).offset(-kX_GAP);
        make.height.equalTo(25);
    }];
}

#pragma mark - lazy

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [self createLabelRect:CGRectZero text:@"数值选择:" tag:0];
    }
    return _labelLeft;
}

- (UILabel *)labelRight{
    if (!_labelRight) {
        _labelRight = [self createLabelRect:CGRectZero text:@"单位" tag:kTAG_LABEL];
   
    }
    return _labelRight;
}

- (UISlider *)sliderCtl{
    if (!_sliderCtl) {
        _sliderCtl = [UISlider createRect:CGRectZero minValue:0 maxValue:100];
        _sliderCtl.value = 50;
    }
    return _sliderCtl;
}

- (UILabel *)createLabelRect:(CGRect)rect text:(NSString *)text tag:(NSInteger)tag{
    UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.font = [UIFont systemFontOfSize:16];
    view.textAlignment = NSTextAlignmentCenter;
    view.userInteractionEnabled = true;
    view.numberOfLines = 1;
    view.lineBreakMode = NSLineBreakByTruncatingTail;
    view.adjustsFontSizeToFitWidth = YES;
    //        label.backgroundColor = UIColor.greenColor;
    
    view.text = text;
    view.tag = tag;
    return view;
}

@end
