//
//  NNTagViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2020/1/15.
//  Copyright © 2020 BN. All rights reserved.
//

#import "NNTagViewController.h"
#import "XGTagView.h"
#import "NNTagView.h"

@interface NNTagViewController ()

@property (nonatomic, strong) XGTagView *tagView;
@property (nonatomic, strong) NNTagView *tagViewNew;

@end

@implementation NNTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
//    NSArray *list = @[@"Demo", @"这是一些测试", @"感兴趣", @"Xgao", @"非常喜欢", @"如果这一天真的来临", @"不喜欢", @"从前有座山", ];
    NSArray *list = @[@"感兴趣Xgao非常喜欢", @"这是一些测试", @"感兴趣Xgao非常喜欢", @"如果这一天真的来临", @"不喜欢", @"从前有座山", @"从前有座山",@"不喜欢", @"喜欢", ];

    CGRect rect = CGRectMake(10, 10, kScreenWidth -20, 100);
    self.tagView = [[XGTagView alloc]initWithFrame:rect tagArray:list];
    self.tagView.textColorNormal = UIColor.orangeColor;
    
    [self.view addSubview:self.tagView];
    
    
    rect = CGRectMake(10, kScreenHeight/2, kScreenWidth -20, 100);
    self.tagViewNew = [[NNTagView alloc]initWithFrame:rect];
    self.tagViewNew.fontSize = 9;
    self.tagViewNew.tagArray = list;
    self.tagViewNew.textColorNormal = UIColor.orangeColor;
    
    [self.view addSubview:self.tagViewNew];
    
    
    DDLog(@"%@", @(rect));
    DDLog(@"%@", @(self.tagViewNew.frame));

    [self.view getViewLayer];
}


//- (XGTagView *)tagView{
//    if (!_tagView) {
//        _tagView = [XGTagView alloc]initWithFrame:<#(CGRect)#> tagArray:<#(nonnull NSMutableArray *)#>
//    }
//}




@end
