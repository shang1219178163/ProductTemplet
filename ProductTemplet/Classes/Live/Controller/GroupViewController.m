//
//  GroupViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/14.
//  Copyright © 2019 BN. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()
@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) NSArray<NSString *> *items;
@property (nonatomic, assign) NSInteger numberOfRow;
@property (nonatomic, assign) CGFloat padding;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    self.padding = 5;
    self.numberOfRow = 3;
    
    
    NSMutableArray * marr = [NSMutableArray array];
    for (NSInteger i = 0; i < 24; i++) {
        NSString * title = [@"按钮_" stringByAppendingFormat:@"%@", @(i)];
        [marr addObject:title];
    }
    self.items = marr.copy;
    self.itemList = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *image = idx == 3 ? @"bug.png" : nil;
        UIButton *view = [self createBtnRect:CGRectZero title:obj image:image type:@(idx)];
        [view addActionHandler:^(UIButton * _Nonnull sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:view];
        
        [self.itemList addObject:view];
    }];
    
//    [self.view getViewLayer];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    NSInteger rowCount = self.items.count%self.numberOfRow == 0 ? self.items.count/self.numberOfRow : self.items.count/self.numberOfRow + 1;
    CGFloat itemWidth = (CGRectGetWidth(self.view.bounds) - (self.numberOfRow - 1)*self.padding)/self.numberOfRow;
    CGFloat itemHeight = (CGRectGetHeight(self.view.bounds) - (rowCount - 1)*self.padding)/rowCount;
    
    [self.itemList enumerateObjectsUsingBlock:^(UIButton * view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = (idx % self.numberOfRow) * (itemWidth + self.padding);
        CGFloat y = (idx / self.numberOfRow) * (itemHeight + self.padding);
        
        CGRect itemRect = CGRectMake(x, y, itemWidth, itemHeight);
        view.frame = itemRect;
    }];
    
}

- (UIButton *)createBtnRect:(CGRect)rect title:(NSString *)title image:(NSString *)image type:(NSNumber *)type{
    assert([UIImage imageNamed:image]);
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    btn.frame = rect;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    switch (type.integerValue) {
        case 1://主题背景白色字体无圆角
        {
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateNormal];
       
        }
            break;
        case 2://白色背景灰色字体无边框
        {
            [btn setTitleColor:UIColor.titleColor9 forState:UIControlStateNormal];
        }
            break;
        case 3://地图定位按钮一类
        {
            [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.lightGrayColor) forState:UIControlStateDisabled];
            
        }
            break;
        case 4://白色背景主题色字体和边框
        {
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            btn.layer.borderColor = UIColor.themeColor.CGColor;
            btn.layer.borderWidth = kW_LayerBorder;
            
        }
            break;
        case 5://白色背景主题字体无边框
        {
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            
        }
            break;
        case 6://红色背景白色字体
        {
            [btn setBackgroundImage:UIImageColor(UIColor.redColor) forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            btn.layer.cornerRadius = 3;
        }
            break;
        case 7://灰色背景黑色字体无边框
        {
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.backgroudColor) forState:UIControlStateNormal];
            
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateSelected];
            
        }
            break;
        case 8://白色背景红色字体无边框
        {
            [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        }
            break;
        default:
        {
            //白色背景黑色字体灰色边框
            [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            btn.layer.borderColor = UIColor.lineColor.CGColor;
            btn.layer.borderWidth = 1;
        }
            break;
    }
    return btn;
}


@end
