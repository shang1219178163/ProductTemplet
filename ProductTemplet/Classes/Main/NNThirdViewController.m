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
        DDLog(@"%@", @"NNThirdViewController");
    }
}

+ (void)load{
    DDLog(@"%@", @"NNThirdViewController");

}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;    
//    [self addControllerName:@"SliderTabBarController"];
    
//    [self printJiuJiuBiao];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSArray *array = @[@"1", @"2", @"3", @"4", ];
    NSArray *array1 = @[@"3", @"4", @"5", @"6", ];

    NSArray *a = [array intersectionWithArray:array1];
    NSArray *b = [array relativeComplementWithArray:array1];
    NSArray *c = [array unionWithArray:array1];
    NSArray *d = [array differenceWithArray:array1];
    DDLog(@"%@ %@ %@ %@", a, b, c, d);
    
    
    NSDictionary *dictionary = @{@"a" : @"aaa",
                                 @"b" : @"bbb",
                                 @"c" : @"ccc",
                                 @"d" : @"ddd",
    };
    NSDictionary *dictionary1 = @{@"c" : @"ccc1",
                                  @"d" : @"ddd1",
                                  @"e" : @"eee",
                                  @"f" : @"fff",
    };
    NSDictionary *dic1 = [dictionary merge:dictionary1 block:^id _Nonnull(id  _Nonnull key, id  _Nonnull oldVal, id  _Nullable newVal) {
        return oldVal;
    }];
    DDLog(@"%@", dic1);
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
