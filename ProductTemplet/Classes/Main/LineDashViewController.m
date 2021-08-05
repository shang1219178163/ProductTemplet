
//
//  LineDashViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/9/18.
//  Copyright © 2019 BN. All rights reserved.
//

#import "LineDashViewController.h"

@interface LineDashViewController ()

@end

@implementation LineDashViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    [self.view addSubview:self.btn];
    [self.view addSubview:self.btn1];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
//    [self.btn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.btn.superview).offset(20);
//        make.left.equalTo(self.btn.superview).offset(10);
//        make.width.equalTo(100);
//        make.height.equalTo(45);
//    }];
    
    self.btn.frame = CGRectMake(10, 10, 100, 45);
//    [self addLineDashStrokeColor:nil view:self.btn cornerRadius:0];
    [self.btn addLineDashLayerColor:nil width:1 dashPattern:nil cornerRadius:0];

    self.btn1.frame = CGRectMake(10, 10 + 45 + 10, 100, 45);
//    [self addLineDashStrokeColor:nil view:self.btn1 cornerRadius:5];
    [self.btn1 addLineDashLayerColor:UIColor.themeColor width:1 dashPattern:@[@5, @2] cornerRadius:0];

}

- (void)addLineDashStrokeColor:(UIColor *)color view:(UIView *)view cornerRadius:(CGFloat)cornerRadius {
    view.layer.borderColor = UIColor.clearColor.CGColor;
    view.layer.borderWidth = 0;

    CAShapeLayer *layer = CAShapeLayer.layer;
    //虚线的颜色
    layer.strokeColor = color.CGColor ? : UIColor.redColor.CGColor;
    //填充的颜色
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.frame = view.bounds;
    layer.path = [UIBezierPath bezierPathWithRoundedRect:layer.frame cornerRadius:cornerRadius].CGPath;
    
    //虚线的宽度
    layer.lineWidth = 1;
    //虚线的间隔
    layer.lineDashPattern = @[@4, @2];
    //设置线条的样式
    //    layer.lineCap = @"square";
    
    if (cornerRadius > 0) {
        view.layer.cornerRadius = cornerRadius;
        view.layer.masksToBounds = true;
    }
    
    [view.layer addSublayer:layer];
}

- (void)addLineDashStrokeColor:(UIColor *)color view:(UIView *)view{
    view.layer.borderColor = UIColor.clearColor.CGColor;
    view.layer.borderWidth = 1;

    CAShapeLayer *layer = CAShapeLayer.layer;
    //虚线的颜色
    layer.strokeColor = color.CGColor ? : UIColor.redColor.CGColor;
    //填充的颜色
    layer.fillColor = UIColor.clearColor.CGColor;
    layer.frame = view.bounds;
    //设置路径
    layer.path = [UIBezierPath bezierPathWithRect:layer.frame].CGPath;

    //虚线的宽度
    layer.lineWidth = 1;
    //虚线的间隔
    layer.lineDashPattern = @[@4, @2];
    //设置线条的样式
    //    layer.lineCap = @"square";

    [view.layer addSublayer:layer];
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            btn.frame = CGRectZero;
            [btn setTitle:@"测试按钮" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            //    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addActionHandler:^(UIButton * _Nonnull sender) {
                self.timer.fireDate = NSDate.date;
                
            } forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _btn;
}

- (UIButton *)btn1{
    if (!_btn1) {
        _btn1 = ({
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            btn.frame = CGRectZero;
            [btn setTitle:@"测试按钮1" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            //    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
            btn;
        });
    }
    return _btn1;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handActionTimer:) userInfo:nil repeats:true];
        [NSRunLoop.mainRunLoop addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (void)handActionTimer:(NSTimer *)timer {
    self.btn.tag += 1;
    [self.btn setTitle:[@(self.btn.tag) stringValue] forState:UIControlStateNormal];
    
}

@end
