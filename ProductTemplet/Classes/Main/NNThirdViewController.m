//
//  BNThirdViewController.m
//  
//
//  Created by BIN on 2018/3/14.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NNThirdViewController.h"
#import "NNCheckVersApi.h"

@interface NNThirdViewController ()

@end

@implementation NNThirdViewController

+ (void)initialize{
    if (self == [self class]) {
        DDLog(@"%@", @"NNThirdViewController")
    }
}

+ (void)load{
    DDLog(@"%@", @"NNThirdViewController")

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self addControllerName:@"SliderTabBarController"];
    
    [self printJiuJiuBiao];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)printJiuJiuBiao{
    [self printChengfaBiao:9];
}

- (void)printChengfaBiao:(NSUInteger)num {
    NSString *resultStr = @"";
    for (int i = 1; i <= num; i++) {
        for (int j = 1; j <= i; j++) {
            resultStr = [NSString stringWithFormat:@"%@\t%d * %d = %d", resultStr, j, i, j * i];
        }
        NSLog(@"%@",resultStr);
        resultStr = @"";
    }
    resultStr = nil;
}

@end
