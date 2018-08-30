//
//  WHKGroupViewViewController.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKGroupViewViewController.h"

#import "BN_RadioViewZero.h"

#import "BN_RadioView.h"

#import "BN_GroupView.h"

@interface WHKGroupViewViewController ()

@property (nonatomic ,strong) NSMutableArray * elementList;

@end

@implementation WHKGroupViewViewController

-(NSMutableArray *)elementList{
    if (!_elementList) {
        _elementList = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = 0; i< 15; i++) {
            NSString * title = [NSString stringWithFormat:@"点我%@",@(i)];
            [_elementList addObject:title];
            
        }
    }
    return _elementList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //
    CGRect rect = CGRectMake(20, 20, kScreen_width - 20*2, 0);
    UIView * containView = [self createViewWithRect:rect elements:self.elementList numberOfRow:4 viewHeight:30 padding:15];
    containView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:containView];
    
    for (UIView * view in containView.subviews) {
        [view addActionHandler:^(id obj, id item, NSInteger idx) {
            
            if ([item isKindOfClass:[UILabel class]]) {
                UILabel * label = (UILabel *)item;
                DDLog(@"__%@",@(label.tag));
                BN_RadioViewZero * radioView = [containView viewWithTag:(label.tag - kTAG_LABEL + kTAG_VIEW)];
                radioView.isSelected = !radioView.isSelected;
                
            }
            else if ([item isKindOfClass:[UIView class]]) {
                BN_RadioViewZero * radioView = item;
                DDLog(@"__%@",@(radioView.tag));
                radioView.isSelected = !radioView.isSelected;
            }
        }];
    }
    
    //
    CGRect rectNew = CGRectMake(20, CGRectGetMidY(self.view.bounds), kScreen_width - 20*2, 0);
//    UIView * containViewNew = [self createViewWithRectNew:rectNew elements:self.elementList numberOfRow:2 viewHeight:30 padding:10];
//    containViewNew.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:containViewNew];
    
//    for (UIView * view in containViewNew.subviews) {
//        [view addActionHandler:^(id obj, id item, NSInteger idx) {
//            DDLog(@"%@",item);
//            BN_RadioView * radioView = item;
//            radioView.isSelected = !radioView.isSelected;
//
//        }];
//    }
 
    BN_GroupView * groupView = [BN_GroupView viewWithRect:rectNew items:self.elementList numberOfRow:2 itemHeight:30 padding:10 selectedList:@[@1,@3,@6]];
    [self.view addSubview:groupView];
    
    groupView.groupBlock = ^(BN_GroupView *groupView, NSArray* selectedItems, NSInteger idx, BOOL isOnlyOne) {
        DDLog(@"_%@_%@_%@",@(selectedItems.count),@(idx),@(isOnlyOne));
    };
    
    [self.view getViewLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createViewWithRectNew:(CGRect)rect elements:(NSArray *)elements numberOfRow:(NSInteger)numberOfRow viewHeight:(CGFloat)viewHeight padding:(CGFloat)padding{
    
    //    CGFloat padding = 15;
    //    CGFloat viewHeight = 30;
    //    NSInteger numberOfRow = 4;
    NSInteger rowCount = elements.count % numberOfRow == 0 ? elements.count/numberOfRow : elements.count/numberOfRow + 1;
    //
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * viewHeight + (rowCount - 1) * padding)];
    backgroudView.backgroundColor = [UIColor greenColor];
    
    CGSize viewSize = CGSizeMake((CGRectGetWidth(backgroudView.frame) - (numberOfRow-1)*padding)/numberOfRow, viewHeight);
    for (NSInteger i = 0; i< elements.count; i++) {
        
        CGFloat w = viewSize.width;
        CGFloat h = viewSize.height;
        CGFloat x = (w + padding) * (i % numberOfRow);
        CGFloat y = (h + padding) * (i / numberOfRow);
        
        NSString * title = elements[i];
        CGRect btnRect = CGRectMake(x, y, w, h);
//        UIButton * btn = [UIView createBtnWithRect:btnRect title:title font:15 image:nil tag:kTAG_BTN+i patternType:@"0" target:nil aSelector:nil];
//
        NSDictionary * dict = @{
                                kRadio_title : title,
                                kRadio_imageN : @"img_cir_normal.png",
                                kRadio_imageH : @"img_cir_Selected.png",

                                kRadio_textColorH : [UIColor redColor],
                                kRadio_textColorN : [UIColor blackColor],
                                
                                };
        BN_RadioView * view = [[BN_RadioView alloc]initWithFrame:btnRect attDict:dict isSelected:YES];
        view.tag = kTAG_VIEW + i;
        
        [backgroudView addSubview:view];
        view.block = ^(BN_RadioView *radioView, UIView *itemView, BOOL isSelected) {
            DDLog(@"_%@_%@",@(itemView.tag),@(isSelected));
        };
        
    }
    return backgroudView;
}

- (UIView *)createViewWithRect:(CGRect)rect elements:(NSArray *)elements numberOfRow:(NSInteger)numberOfRow viewHeight:(CGFloat)viewHeight padding:(CGFloat)padding{
    
    //    CGFloat padding = 15;
    //    CGFloat viewHeight = 30;
    //    NSInteger numberOfRow = 4;
    NSInteger rowCount = elements.count % numberOfRow == 0 ? elements.count/numberOfRow : elements.count/numberOfRow + 1;
    //
    UIView * backgroudView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * viewHeight + (rowCount - 1) * padding)];
    backgroudView.backgroundColor = [UIColor greenColor];
    
    CGSize viewSize = CGSizeMake((CGRectGetWidth(backgroudView.frame) - (numberOfRow-1)*padding)/numberOfRow, viewHeight);
    for (NSInteger i = 0; i < elements.count; i++) {
        
        CGFloat w = viewSize.width;
        CGFloat h = viewSize.height;
        CGFloat x = (w + padding) * (i % numberOfRow);
        CGFloat y = (h + padding) * (i / numberOfRow);
        
        NSString * title = elements[i];
        CGRect btnRect = CGRectMake(x, y, w, h);
        //        UIButton * btn = [UIView createBtnWithRect:btnRect title:title font:15 image:nil tag:kTAG_BTN+i patternType:@"0" target:nil aSelector:nil];
        //
        CGRect radioViewRect = CGRectMake(x, y, 30, 30);
        BN_RadioViewZero * radioView = [[BN_RadioViewZero alloc]initWithFrame:radioViewRect imgName_N:@"img_select_N" imgName_H:@"img_select_H"];
        radioView.isSelected = i%2 == 0 ? YES : NO;
        radioView.tag = kTAG_VIEW + i;
        CGRect labelRect = CGRectMake(x+30, y, w-30, 30);
        UILabel * label = [UIView createLabelWithRect:labelRect text:title textColor:nil tag:kTAG_LABEL+i patternType:@"2" font:15 backgroudColor:[UIColor yellowColor] alignment:NSTextAlignmentCenter];
        
        [backgroudView addSubview:radioView];
        [backgroudView addSubview:label];
        
    }
    return backgroudView;
}


@end
