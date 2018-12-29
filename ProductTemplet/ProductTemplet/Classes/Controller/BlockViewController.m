//
//  BlockViewController.m
//  ProductTemplet
//
//  Created by hsf on 2018/10/26.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BlockViewController.h"

@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    @weakify(self);
    self.block = ^(UIViewController * _Nonnull controller, NSString * _Nonnull title) {
        @strongify(self);
        self.view.backgroundColor = UIColor.randomColor;
        
    };
    
    NSString * text = @"@weakify 将当前对象声明为weak.. 这样block内部引用当前对象,就不会造成引用计数+1可以破解循环引用/n@strongify 相当于声明一个局部的strong对象,等于当前对象.可以保证block调用的时候,内部的对象不会释放";
    
    
    CGRect rect = CGRectMake(10, 10, kScreen_width - 20, kScreen_width - 20);
    UILabel * label = [UIView createLabelRect:rect text:text textColor:UIColor.redColor tag:kTAG_LABEL type:@0 font:16 backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
    [self.view addSubview:label];
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self.view];

    if (self.block) {
        self.block(self, NSStringFromCGPoint(point));
    }
    
}


@end
