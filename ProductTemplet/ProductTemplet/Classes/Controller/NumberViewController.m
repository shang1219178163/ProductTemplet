//
//  NumberViewController.m
//  ProductTemplet
//
//  Created by hsf on 2018/11/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NumberViewController.h"

#import "BN_Category.h"

@interface NumberViewController ()

@end

@implementation NumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CGFloat money = 123456.78401;
    money = 0.123456;
    NSNumber * num = @(money);
    
    NSString * string = NSStringFromRoundHalfUp(num, 2, NSNumberFormatterDecimalStyle);
    NSString * string1 = NSStringFromRoundHalfUp(num, 2, NSNumberFormatterPercentStyle);

    NSNumber * string8 = NSNumberFromRound(num, 2, NSNumberFormatterRoundHalfUp);
    NSNumber * string9 = NSNumberFromRound(num, 2, NSNumberFormatterRoundCeiling);
    NSNumber * string10 = NSNumberFromRound(num, 2, NSNumberFormatterRoundFloor);
    
    DDLog(@"_%@_",string);
    DDLog(@"_%@_",string1);
   
    DDLog(@"_%@_",string8);
    DDLog(@"_%@_",string9);
    DDLog(@"_%@_",string10);

}



@end
