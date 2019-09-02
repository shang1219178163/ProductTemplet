//
//  NumberViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NumberViewController.h"

@interface NumberViewController ()

@end

@implementation NumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *array3 = @[@"JinYiPang", @"JinErPang", @"JinSanPang", @"JinYiPang", @"JinErPang",@"JinZhengEn"];
    NSLog(@"array3 = %@", [array3 valueForKeyPath:@"@distinctUnionOfObjects.self"]);
    
    NSArray *array4 = @[@{@"name" : @"JinYiPang", @"code" : @"123"},
                        @{@"name" : @"JinSanPang", @"code" :  @"90"},
                        @{@"name" : @"JinErPang", @"code" : @"80"},
                        @{@"name" : @"JinSanPang", @"code" : @"100"}];
    NSLog(@"array4 = %@", [array4 valueForKeyPath:@"name"]);
    NSLog(@"array4 = %@", [array4 valueForKeyPath:@"@distinctUnionOfObjects.name"]);
    
    NSArray *temp1 = @[@111, @222, @333, @444];
    NSArray *temp2 = @[@333, @444, @555];
    NSLog(@"temp  \n%@",[@[temp1, temp2] valueForKeyPath:@"@distinctUnionOfArrays.self"]);
    NSLog(@"temp  \n%@",[@[temp1, temp2] valueForKeyPath:@"@unionOfArrays.self"]);
    
    return;
    
    CGFloat money = 123456.78401;
    money = 0.123456;
    NSNumber * num = @(money);
    
    
    NSDecimalNumber * number = [@"0.35".decNumer decimalNumberByAdding:@"0.15".decNumer];
    DDLog(@"_%@_",number);

    DDLog(@"_%d_%d_",NSDate.date.week,NSDate.date.weekday);

    DDLog(@"_%@_",NSDate.date.weekdayDes);

    
    DDLog(@"%@",NSStringFromClass([self.frontVC class]));

}



@end
