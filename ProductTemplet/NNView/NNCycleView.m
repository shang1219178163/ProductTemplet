//
//  NNCycleView.m
//  ProductTemplet
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NNCycleView.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"

static NSTimeInterval kDurationCycle = 8;

@interface NNCycleView ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) BOOL needsStart;

@end

@implementation NNCycleView

-(void)dealloc{
    [_timer destroy];
    [self.label removeObserver:self forKeyPath:@"text"];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = UIColor.whiteColor;

        _list = @[@"111111", @"2222222", @"333333"];
        _index = 0;
        _needsStart = YES;

        [self addSubview:self.imgView];
        [self addSubview:self.label];

        [self.label addObserver:self forKeyPath:@"text" options:0 context:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    if (height < 1 || width < 1) { return; }

    CGFloat iconSide = MIN(height, 36);
    self.imgView.frame = CGRectMake(8, (height - iconSide) / 2.0, iconSide, iconSide);

    CGFloat labelH = height;
    CGFloat labelW = MAX(CGRectGetWidth(self.label.bounds), 1);
    if (self.label.text.length) {
        labelW = [self sizeWithText:self.label.text font:self.label.font width:CGFLOAT_MAX].width;
    }
    CGFloat labelY = (height - labelH) / 2.0;
    // Keep current x during animation; only fix y/height when not mid-flight origin reset.
    CGRect labelFrame = self.label.frame;
    labelFrame.origin.y = labelY;
    labelFrame.size.height = labelH;
    labelFrame.size.width = labelW;
    if (CGRectGetWidth(labelFrame) < 1) {
        labelFrame.origin.x = CGRectGetMaxX(self.imgView.frame) + 8;
    }
    self.label.frame = labelFrame;

    if (_needsStart && self.list.count > 0) {
        _needsStart = NO;
        [self start];
    }
}

- (void)setList:(NSArray *)list {
    _list = list;
    _index = 0;
    _needsStart = YES;
    [self setNeedsLayout];
}

#pragma mark - -KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"text"]) {
        CGSize size = [self sizeWithText:self.label.text font:self.label.font width:CGFLOAT_MAX];
        CGRect rectLab = self.label.frame;
        rectLab.size.width = MAX(size.width, 1);
        self.label.frame = rectLab;
    }
}

- (void)start{
    if (self.list.count == 0) { return; }
    if (CGRectGetWidth(self.bounds) < 1) {
        _needsStart = YES;
        [self setNeedsLayout];
        return;
    }

    // Already running — don't restart on every layout pass.
    if (_timer && _timer.isValid && !_needsStart) { return; }
    _needsStart = NO;

    [self handleActionTimer];

    [_timer destroy];
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer scheduledTimer:kDurationCycle block:^(NSTimer *timer) {
        [weakSelf handleActionTimer];
    } repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)handleActionTimer{
    if (self.list.count == 0 || CGRectGetWidth(self.bounds) < 1) { return; }

    _index = _index >= (NSInteger)self.list.count ? 0 : _index;
    self.label.text = self.list[_index];
    _index++;

    CGFloat textWidth = [self sizeWithText:self.label.text font:self.label.font width:CGFLOAT_MAX].width;
    CGFloat startX = CGRectGetWidth(self.bounds);
    CGFloat endX = CGRectGetMaxX(self.imgView.frame) + 8 - textWidth;

    CGRect rect = self.label.frame;
    rect.size.width = textWidth;
    rect.origin.x = startX;
    self.label.frame = rect;

    [UIView animateWithDuration:kDurationCycle
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
        CGRect to = self.label.frame;
        to.origin.x = endX;
        self.label.frame = to;
    } completion:nil];
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
            imgView.userInteractionEnabled = YES;
            imgView.backgroundColor = UIColor.whiteColor;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.image = [UIImage imageNamed:@"img_notice_One.png"] ?: [UIImage imageNamed:@"img_notice"];
            imgView;
        });
    }
    return _imgView;
}

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, 100, 36)];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = UIColor.darkTextColor;
            label.numberOfLines = 1;
            label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            label;
        });
    }
    return _label;
    
}

@end
