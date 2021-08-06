//
//  NNSliderControlView.m
//  HXPhotoSlideUnlock
//
//  Created by Bin Shang on 2019/2/26.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "NNSliderControlView.h"

@implementation NNSliderControlView

- (void)dealloc{
    [self.imgView removeObserver:self forKeyPath:@"center"];
    [self removeObserver:self forKeyPath:@"frame"];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.insets = UIEdgeInsetsZero;
        self.clipsToBounds = true;
        
        [self addSubview:self.labFront];
        [self addSubview:self.labBack];
        [self addSubview:self.imgView];
        
        [self.imgView addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];

        self.text = @"👉向右滑动";
        self.labBack.textAlignment = NSTextAlignmentCenter;
        self.labFront.backgroundColor = UIColor.greenColor;
        self.labBack.backgroundColor = UIColor.orangeColor;
        
        self.imgView.frame = CGRectMake(0, 0, CGRectGetHeight(frame)+15, CGRectGetHeight(frame));
        self.labFront.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        self.labBack.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(self.imgView.frame));
        self.cornerRadius = CGRectGetHeight(frame)/2.0;
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //手势也会触发此方法
}

- (void)setText:(NSString *)text{
    _text = text;
    self.labBack.text = text;
}

- (void)setTextFinish:(NSString *)textFinish{
    _textFinish = textFinish;
    self.labFront.text = textFinish;
}

- (void)setThumbImage:(UIImage *)thumbImage{
    _thumbImage = thumbImage;
    self.imgView.image = thumbImage;
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = cornerRadius;
    for (UIView * view in self.subviews) {
        view.layer.borderWidth = 0.5;
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = true;
        
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"center"]) {
        CGPoint point = [change[NSKeyValueChangeNewKey] CGPointValue];
        CGFloat halfWidth = CGRectGetWidth(self.imgView.frame)/2.0;
        
        CGRect rectBack = self.labBack.frame;
        rectBack.origin.x = point.x - halfWidth;
        rectBack.size.width = CGRectGetWidth(self.frame) - rectBack.origin.x + halfWidth;
        self.labBack.frame = rectBack;
        
//        NSLog(@"_%@_%@_",change[NSKeyValueChangeNewKey], @(self.labBack.frame));
        if (point.x > CGRectGetWidth(self.imgView.frame)/2.0) {
            self.labBack.text = @"";
            self.labFront.text = self.imgView.image == self.thumbFinishImage ? self.textFinish : @"";

        } else {
            self.labBack.text = self.text;

        }
    } else if ([keyPath isEqualToString:@"frame"]) {
        CGRect frame = [change[NSKeyValueChangeNewKey] CGRectValue];
//        NSLog(NSStringFromSelector(_cmd),change[NSKeyValueChangeNewKey]);
        self.imgView.frame = CGRectMake(0, 0, CGRectGetHeight(frame)+15, CGRectGetHeight(frame));
        self.labFront.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        self.labBack.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(self.imgView.frame));
        self.cornerRadius = CGRectGetHeight(frame)/2.0;
    }
}

- (void)handleActionPan:(UIPanGestureRecognizer *)recognizer{
    if (_isLock) { return; }
    CGPoint translation = [recognizer translationInView:recognizer.view.superview];
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.imgView.image = self.thumbImage;

            break;
        case UIGestureRecognizerStateChanged:
        {
//            if (recognizer.view.center.x <= CGRectGetWidth(self.imgView.frame)) {
//                NSLog(@"%@",@"最左边");
//            } else  if (recognizer.view.center.x >= (CGRectGetWidth(self.frame) - CGRectGetWidth(self.imgView.frame)/2.0)) {
//                NSLog(@"%@",@"最右边");
//            }
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
//            NSLog(@"%@,%.2f,%.2f",NSStringFromSelector(_cmd),recognizer.view.center.x,translation.x);
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint stopPoint = recognizer.view.center;
            if (stopPoint.x - CGRectGetWidth(self.imgView.frame)*0.5 - self.insets.left < CGRectGetMaxX(self.frame)) {
                stopPoint = CGPointMake(CGRectGetWidth(self.imgView.frame)*0.5 + self.insets.left, stopPoint.y);
            }

            if (recognizer.view.center.x + CGRectGetWidth(self.imgView.frame)*0.5 + self.insets.right >= CGRectGetWidth(self.frame)) {
                stopPoint = CGPointMake(CGRectGetWidth(self.frame) - CGRectGetWidth(self.imgView.frame)*0.5 - self.insets.right, stopPoint.y);
                
                if (self.thumbFinishImage) {
                    self.imgView.image = self.thumbFinishImage;
                    self.labFront.text = self.textFinish;
                }
            }
            
            [UIView animateWithDuration:0.35 animations:^{
                recognizer.view.center = stopPoint;

            }];

        }
            break;
        default:
            break;
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:recognizer.view.superview];
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            view.backgroundColor = UIColor.whiteColor;
            //创建移动手势事件
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionPan:)];
            pan.minimumNumberOfTouches = 1;
            pan.delaysTouchesEnded = true;
            pan.cancelsTouchesInView = true;
            [view addGestureRecognizer:pan];
            
            view;
        });
    }
    return _imgView;
}

-(UILabel *)labFront{
    if (!_labFront) {
        _labFront = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:17];
            label.textColor = UIColor.whiteColor;
            label.textAlignment = NSTextAlignmentCenter;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
            label;
        });
    }
    return _labFront;
}

-(UILabel *)labBack{
    if (!_labBack) {
        _labBack = ({
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
            label.font = [UIFont systemFontOfSize:17];
            label.textColor = UIColor.whiteColor;
            label.textAlignment = NSTextAlignmentCenter;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled = YES;
            //        label.backgroundColor = UIColor.greenColor;
            label;
        });
    }
    return _labBack;
}

@end
