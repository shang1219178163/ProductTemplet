//
//  CustomViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/19.
//  Copyright © 2019 BN. All rights reserved.
//

#import "CustomViewController.h"

#import <NNGloble/NNGloble.h>
#import "NSArray+Helper.h"
#import "NSString+Helper.h"
#import "UIView+Helper.h"
#import "UIControl+Helper.h"

#import "NNItemsView.h"
#import "NNWalletView.h"
#import "NNSearchView.h"

#import "NNCellDefaultView.h"
#import "NNDateRangeView.h"
#import "NNSliderView.h"
#import "NNSheetView.h"
#import "NNSwitchView.h"
#import "NNListChooseView.h"


@interface CustomViewController ()

@property (nonatomic, strong) NNItemsView * itemsView;
@property (nonatomic, strong) NNWalletView * walletView;
@property (nonatomic, strong) NNSearchView * searchView;

@property (nonatomic, strong) NNCellDefaultView * defaultView;
@property (nonatomic, strong) NNDateRangeView * dateRangeView;
@property (nonatomic, strong) NNSliderView * sliderView;
@property (nonatomic, strong) NNSheetView * sheetView;
@property (nonatomic, strong) NNSwitchView * switchView;
@property (nonatomic, strong) NNListChooseView * chooseView;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger idx = 3;
    switch (idx) {
        case 0:
        {
            NSArray * list = [NSArray arrayItemPrefix:@"item_" startIndex:0 count:16 type:@0];
            self.itemsView.frame = CGRectMake(20, 20, kScreenWidth - 40, kScreenWidth - 40);
            self.itemsView.items = list;
            //    [self.view addSubview: self.itemsView];
            
            self.itemsView.items = list = [NSArray arrayItemPrefix:@"item_" startIndex:0 count:12 type:@0];;

        }
            break;
        case 1:
        {
            self.walletView.frame = CGRectMake(20, 20, kScreenWidth - 40, kScreenWidth - 40);
            //    [self.view addSubview: self.walletView];
        }
            break;
        case 2:
        {
            self.defaultView.frame = CGRectMake(0, 0, kScreenWidth, 60);
            [self.view addSubview:self.defaultView];

            NSArray * list = @[self.dateRangeView, self.sliderView, self.switchView, self.sheetView, self.chooseView,self.searchView];
            CGRect rect = self.defaultView.frame;
            for (UIView * view in list) {
                rect = CGRectMake(0, CGRectGetMaxY(rect), kScreenWidth, 60);
                view.frame = rect;
                [self.view addSubview:view];
            }
            
            DDLog(@"_%@_",@([@" 21" isContainBlank]));
        }
            break;
        case 3:
         {
      
         }
             break;
        default:
            break;
    }
    
    [self.view getViewLayer];
}

- (NNItemsView *)itemsView{
    if (!_itemsView) {
        _itemsView = [[NNItemsView alloc]initWithFrame:CGRectZero];
        _itemsView.block = ^(NNItemsView * _Nonnull itemsView, UIButton * _Nonnull btn) {
            DDLog(@"%@",btn.currentTitle);
        };
    }
    return _itemsView;
}

- (NNWalletView *)walletView{
    if (!_walletView) {
        _walletView = [[NNWalletView alloc]initWithFrame:CGRectZero];
//        _walletView.type = @2;
        _walletView.block = ^(NNWalletView * _Nonnull walletView, UIView * _Nonnull view) {
            DDLog(@"_%@",@(view.tag));
        };
    }
    return _walletView;
}

-(NNSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[NNSearchView alloc]initWithFrame:CGRectZero];
        [_searchView.btn addActionHandler:^(UIButton * _Nonnull sender) {
            DDLog(@"%@",_searchView.queryStr);
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchView;
}

-(NNCellDefaultView *)defaultView{
    if (!_defaultView) {
        _defaultView = [[NNCellDefaultView alloc]initWithFrame:CGRectZero];
        _defaultView.labelLeft.text = @"显示标题:";
        _defaultView.labelRight.text = @"11111";
        _defaultView.imgViewRight.hidden = false;
    }
    return _defaultView;
}

-(NNDateRangeView *)dateRangeView{
    if (!_dateRangeView) {
        _dateRangeView = [[NNDateRangeView alloc]initWithFrame:CGRectZero];
    }
    return _dateRangeView;
}

-(NNSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[NNSliderView alloc]initWithFrame:CGRectZero];
    }
    return _sliderView;
}

-(NNSheetView *)sheetView{
    if (!_sheetView) {
        _sheetView = [[NNSheetView alloc]initWithFrame:CGRectZero];
    }
    return _sheetView;
}

-(NNSwitchView *)switchView{
    if (!_switchView) {
        _switchView = [[NNSwitchView alloc]initWithFrame:CGRectZero];
    }
    return _switchView;
}

- (NNListChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[NNListChooseView alloc]initWithFrame:CGRectZero];
    }
    return _chooseView;
}

@end
