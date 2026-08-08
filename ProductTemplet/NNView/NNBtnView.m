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

@implementation NNBtnView

-(void)dealloc{
    [self.label removeObserver:self forKeyPath:@"text"];
    
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
        _type = @3;
        _imgSize = CGSizeMake(10, 6);
        _padding = 3.0;

        [self addSubview:self.label];
        [self addSubview:self.imageView];

        self.imageView.image = [NNBtnView defaultTriangleImage];
        self.imageView.tintColor = UIColor.orangeColor;
        
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

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    CGFloat height = CGRectGetHeight(frame);
    CGFloat width = CGRectGetWidth(frame);
    
    if (_padding == 0.0) _padding = 3.0;
    
    
    CGFloat kH_label = kH_LABEL_SMALL;
    if (CGSizeEqualToSize(CGSizeZero, _imgSize)) {
        NSInteger t = [_type integerValue];
        if (t == 1 || t == 3) {
            // 水平图文：默认小三角尺寸
            _imgSize = CGSizeMake(10, 6);
        } else {
            _imgSize = CGSizeMake(kH_label, kH_label);
        }
    }
    //图文水平
    CGFloat kW_label_Hor = CGRectGetWidth(frame) - self.imgSize.width - _padding*3;
    //图文垂直
    CGFloat kW_label_Ver = CGRectGetWidth(frame) - _padding*2;
    
    if (!self.imageView.image) {
        self.imageView.image = [NNBtnView defaultTriangleImage];
        if (!self.imageView.tintColor) {
            self.imageView.tintColor = UIColor.orangeColor;
        }
    }
    
    switch ([self.type integerValue]) {
        case 0://图上字下
        {
            self.imageView.frame = CGRectMake((width - _imgSize.width)/2.0, _padding, _imgSize.width, _imgSize.height);
            self.label.frame = CGRectMake(_padding, CGRectGetMaxY(self.imageView.frame) + _padding, kW_label_Ver, kH_label);
            
        }
            break;
        case 1://图左字右
        {
            self.imageView.frame = CGRectMake(_padding, (height - _imgSize.height)/2.0, _imgSize.width, _imgSize.height);
            self.label.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + _padding, (height - kH_label)/2.0, kW_label_Hor, kH_label);
            
        }
            break;        
        case 2://图下字上
        {
            self.label.frame = CGRectMake(_padding, _padding, kW_label_Ver, kH_label);
            self.imageView.frame = CGRectMake((width - _imgSize.width)/2.0, CGRectGetMaxY(self.label.frame) + _padding, _imgSize.width, _imgSize.height);
            
        }
            break;
        case 3://图右字左
        {
            self.label.frame = CGRectMake(_padding, (height - kH_label)/2.0, kW_label_Hor, kH_label);
            self.imageView.frame = CGRectMake(CGRectGetMaxX(self.label.frame) + _padding, (height - _imgSize.height)/2.0, _imgSize.width, _imgSize.height);
            
        }
            break;
        default:
        {
            //图上字下
            self.imageView.frame = CGRectMake((width - _imgSize.width)/2.0, _padding, _imgSize.width, _imgSize.height);
            self.label.frame = CGRectMake(_padding, CGRectGetMaxY(self.imageView.frame) + _padding, kW_label_Ver, kH_label);
        }
            break;
    }
}

#pragma mark - -KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        // Avoid mutating frame while embedded in UINavigationBar (causes Auto Layout storms on iOS 15+).
        if (!self.adjustsSizeToFitText) { return; }
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }
}

- (CGSize)intrinsicContentSize {
    if (!self.adjustsSizeToFitText) {
        return [super intrinsicContentSize];
    }
    CGFloat height = CGRectGetHeight(self.bounds) > 1.0 ? CGRectGetHeight(self.bounds) : 36.0;
    CGSize textSize = [self sizeWithText:self.label.text ?: @"" font:self.label.font width:CGFLOAT_MAX];
    CGFloat padding = _padding > 0 ? _padding : 3.0;
    BOOL hasImage = self.imageView.image != nil;
    CGFloat imageWidth = hasImage ? (CGSizeEqualToSize(CGSizeZero, _imgSize) ? 10.0 : _imgSize.width) : 0;
    CGFloat width = textSize.width + imageWidth + padding * (hasImage ? 3.0 : 2.0);
    return CGSizeMake(ceil(width), height);
}

#pragma mark - -layz

-(UILabel *)label{
    if (!_label) {
        _label = ({
            UILabel * lab = [[UILabel alloc]init];
            lab.numberOfLines = 1;
            lab.font = [UIFont systemFontOfSize:17];
            lab.textAlignment = NSTextAlignmentCenter;
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
