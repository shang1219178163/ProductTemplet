//
//  AnniSuperController.m
//  BN_Animation
//
//  Created by BIN on 2018/9/11.
//  Copyright © 2018年 WHKJ. All rights reserved.

#import "AnniSuperController.h"

@interface AnniSuperController ()

@end

@implementation AnniSuperController

-(CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        _shapeLayer = ({
            CAShapeLayer *layer = CAShapeLayer.layer;
            layer.bounds = CGRectMake(0, 0, 200, 200);
            layer.position = self.view.center;
            layer.backgroundColor = UIColor.greenColor.CGColor;
            //        layer.fillColor = UIColor.clearColor.CGColor;
            //        layer.strokeColor = [UIColor redColor].CGColor;
            layer.lineWidth = 3.f;
            layer;
        });
    }
    return _shapeLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = NSStringFromClass(self.class);
    
    NSLog(@"==========%@===========", NSStringFromClass(self.class));
   
    
}


@end
