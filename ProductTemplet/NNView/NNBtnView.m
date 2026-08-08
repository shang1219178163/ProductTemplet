//
//  NNBtnView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/17.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NNBtnView.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"

@interface NNBtnView ()
@property (nonatomic, assign) BOOL sizeUpdateScheduled;
@end

@implementation NNBtnView

-(void)dealloc{
    [self.label removeObserver:self forKeyPath:@"text"];
    [self.imageView removeObserver:self forKeyPath:@"image"];
}

+ (UIImage *)defaultTriangleImage {
    CGSize size = CGSizeMake(10, 6);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 1)];
    [path addLineToPoint:CGPointMake(size.width, 1)];
    [path addLineToPoint:CGPointMake(size.width * 0.5, size.height)];
    [path closePath];
    [[UIColor whiteColor] setFill];
    [path fill];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _type = NNBtnViewTypeImageRight;
        _imgSize = CGSizeMake(10, 6);
        _spacing = 4.0;
        _maxWidth = 0;

        [self addSubview:self.label];
        [self addSubview:self.imageView];

        self.imageView.image = [NNBtnView defaultTriangleImage];
        self.imageView.tintColor = UIColor.orangeColor;

//        // 调试：查看标题 / 三角形布局范围
//        self.label.layer.borderWidth = 1.0;
//        self.label.layer.borderColor = UIColor.redColor.CGColor;
//        self.imageView.layer.borderWidth = 1.0;
//        self.imageView.layer.borderColor = UIColor.greenColor.CGColor;
        
        [self.label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self.imageView addObserver:self forKeyPath:@"image" options:0 context:nil];

        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hanleActionTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)hanleActionTap:(UITapGestureRecognizer *)tap{
    if (self.block) self.block(self);
    
}

- (CGFloat)resolvedMaxWidth {
    if (_maxWidth > 0) {
        return _maxWidth;
    }
    return UIScreen.mainScreen.bounds.size.width - 160.0;
}

- (CGFloat)resolvedSpacing {
    return _spacing > 0 ? _spacing : 4.0;
}

- (void)setSpacing:(CGFloat)spacing {
    if (fabs(_spacing - spacing) < 0.01) { return; }
    _spacing = spacing;
    if (self.adjustsSizeToFitText) {
        [self scheduleSizeToFitContent];
    } else {
        [self setNeedsLayout];
    }
}

- (void)setPadding:(CGFloat)padding {
    self.spacing = padding;
}

- (CGFloat)padding {
    return self.spacing;
}

- (BOOL)isHorizontalType {
    return self.type == NNBtnViewTypeImageLeft || self.type == NNBtnViewTypeImageRight;
}

- (CGSize)resolvedImageSize {
    if (!CGSizeEqualToSize(CGSizeZero, _imgSize)) {
        return _imgSize;
    }
    if ([self isHorizontalType]) {
        return CGSizeMake(10, 6);
    }
    return CGSizeMake(kH_LABEL_SMALL, kH_LABEL_SMALL);
}

- (CGFloat)textWidth {
    NSString *text = self.label.text ?: @"";
    if (text.length == 0) { return 0; }
    return ceil([self.label sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width);
}

- (CGFloat)maxLabelWidth {
    CGFloat spacing = [self resolvedSpacing];
    CGSize imgSize = [self resolvedImageSize];
    CGFloat reserve = [self isHorizontalType] ? (imgSize.width + spacing) : 0;
    return MAX(0, [self resolvedMaxWidth] - reserve);
}

- (CGSize)preferredContentSize {
    CGFloat spacing = [self resolvedSpacing];
    CGSize imgSize = [self resolvedImageSize];
    CGFloat labelW = MIN([self textWidth], [self maxLabelWidth]);
    CGFloat height = CGRectGetHeight(self.bounds) > 1.0 ? CGRectGetHeight(self.bounds) : 36.0;
    CGFloat width = [self isHorizontalType] ? (labelW + spacing + imgSize.width) : MAX(labelW, imgSize.width);
    width = MIN(width, [self resolvedMaxWidth]);
    return CGSizeMake(ceil(width), height);
}

- (void)setType:(NNBtnViewType)type {
    if (_type == type) { return; }
    _type = type;
    if (self.adjustsSizeToFitText) {
        [self scheduleSizeToFitContent];
    } else {
        [self setNeedsLayout];
    }
}

- (void)sizeToFitContent {
    if (!self.adjustsSizeToFitText) { return; }
    CGSize size = [self preferredContentSize];
    if (fabs(CGRectGetWidth(self.bounds) - size.width) < 0.5 &&
        fabs(CGRectGetHeight(self.bounds) - size.height) < 0.5) {
        [self setNeedsLayout];
        return;
    }
    // titleView 以 frame 为准，必须写入尺寸；勿在导航栏 layout 同步链路里连环改，由外层/异步调用
    self.bounds = CGRectMake(0, 0, size.width, size.height);
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)scheduleSizeToFitContent {
    if (!self.adjustsSizeToFitText || self.sizeUpdateScheduled) { return; }
    self.sizeUpdateScheduled = YES;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) self = weakSelf;
        if (!self) { return; }
        self.sizeUpdateScheduled = NO;
        [self sizeToFitContent];
    });
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat spacing = [self resolvedSpacing];
    
    CGSize imgSize = [self resolvedImageSize];
    _imgSize = imgSize;

    if (!self.imageView.image) {
        self.imageView.image = [NNBtnView defaultTriangleImage];
        if (!self.imageView.tintColor) {
            self.imageView.tintColor = UIColor.orangeColor;
        }
    }

    // 以 maxWidth 为上限；bounds 已由 sizeToFitContent 按内容撑开
    CGFloat labelW = MIN([self textWidth], [self maxLabelWidth]);
    if ([self isHorizontalType]) {
        labelW = MIN(labelW, MAX(0, width - imgSize.width - spacing));
    } else {
        labelW = MIN(labelW, MAX(0, width));
    }

    CGFloat labelH = MAX(ceil(self.label.font.lineHeight), kH_LABEL_SMALL);
    self.label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    switch (self.type) {
        case NNBtnViewTypeImageTop:
        {
            self.imageView.frame = CGRectMake((width - imgSize.width)/2.0, spacing, imgSize.width, imgSize.height);
            self.label.frame = CGRectMake((width - labelW)/2.0, CGRectGetMaxY(self.imageView.frame) + spacing, labelW, labelH);
        }
            break;
        case NNBtnViewTypeImageLeft:
        {
            CGFloat contentW = imgSize.width + spacing + labelW;
            CGFloat startX = (width - contentW) / 2.0;
            self.imageView.frame = CGRectMake(startX, (height - imgSize.height)/2.0, imgSize.width, imgSize.height);
            self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + spacing, (height - labelH)/2.0, labelW, labelH);
        }
            break;        
        case NNBtnViewTypeImageBottom:
        {
            self.label.frame = CGRectMake((width - labelW)/2.0, spacing, labelW, labelH);
            self.imageView.frame = CGRectMake((width - imgSize.width)/2.0, CGRectGetMaxY(self.label.frame) + spacing, imgSize.width, imgSize.height);
        }
            break;
        case NNBtnViewTypeImageRight:
        {
            CGFloat contentW = labelW + spacing + imgSize.width;
            CGFloat startX = (width - contentW) / 2.0;
            self.label.frame = CGRectMake(startX, (height - labelH)/2.0, labelW, labelH);
            self.imageView.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + spacing, (height - imgSize.height)/2.0, imgSize.width, imgSize.height);
        }
            break;
        default:
        {
            self.imageView.frame = CGRectMake((width - imgSize.width)/2.0, spacing, imgSize.width, imgSize.height);
            self.label.frame = CGRectMake((width - labelW)/2.0, CGRectGetMaxY(self.imageView.frame) + spacing, labelW, labelH);
        }
            break;
    }
}

#pragma mark - -KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"] || [keyPath isEqualToString:@"image"]) {
        // 导航栏 layout 同步链路里改 frame 会炸；丢到下一圈 runloop
        [self scheduleSizeToFitContent];
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize preferred = [self preferredContentSize];
    if (size.width > 0) {
        preferred.width = MIN(preferred.width, size.width);
    }
    if (size.height > 0) {
        preferred.height = MIN(preferred.height, size.height);
    }
    return preferred;
}

- (CGSize)intrinsicContentSize {
    if (!self.adjustsSizeToFitText) {
        return [super intrinsicContentSize];
    }
    return [self preferredContentSize];
}

#pragma mark - -layz

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * lab = [[UILabel alloc]init];
            lab.numberOfLines = 1;
            lab.font = [UIFont systemFontOfSize:17];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.lineBreakMode = NSLineBreakByTruncatingTail;
            lab;
        });
    }
    return _label;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = ({
            UIImageView * imgView = [[UIImageView alloc]init];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView.userInteractionEnabled = YES;

            imgView;
        });
    }
    return _imageView;
}


@end
