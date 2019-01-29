//
//  CustomViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/19.
//  Copyright © 2019 BN. All rights reserved.
//

#import "CustomViewController.h"

#import "BNGloble.h"
#import "NSArray+Helper.h"
#import "NSString+Helper.h"
#import "UIView+Helper.h"
#import "UIControl+Helper.h"

#import "BNItemsView.h"
#import "BNWalletView.h"
#import "BNSearchView.h"

#import "BNCellDefaultView.h"
#import "BNDateRangeView.h"
#import "BNSliderView.h"
#import "BNSheetView.h"
#import "BNSwitchView.h"
#import "BNListChooseView.h"


@interface CustomViewController ()

@property (nonatomic, strong) BNItemsView * itemsView;
@property (nonatomic, strong) BNWalletView * walletView;
@property (nonatomic, strong) BNSearchView * searchView;

@property (nonatomic, strong) BNCellDefaultView * defaultView;
@property (nonatomic, strong) BNDateRangeView * dateRangeView;
@property (nonatomic, strong) BNSliderView * sliderView;
@property (nonatomic, strong) BNSheetView * sheetView;
@property (nonatomic, strong) BNSwitchView * switchView;
@property (nonatomic, strong) BNListChooseView * chooseView;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSInteger idx = 2;
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
        default:
            break;
    }
    
    [self.view getViewLayer];
}

- (BNItemsView *)itemsView{
    if (!_itemsView) {
        _itemsView = [[BNItemsView alloc]initWithFrame:CGRectZero];
        _itemsView.block = ^(BNItemsView * _Nonnull itemsView, UIButton * _Nonnull btn) {
            DDLog(@"%@",btn.currentTitle);
        };
    }
    return _itemsView;
}

- (BNWalletView *)walletView{
    if (!_walletView) {
        _walletView = [[BNWalletView alloc]initWithFrame:CGRectZero];
//        _walletView.type = @2;
        _walletView.block = ^(BNWalletView * _Nonnull walletView, UIView * _Nonnull view) {
            DDLog(@"_%@",@(view.tag));
        };
    }
    return _walletView;
}

-(BNSearchView *)searchView{
    if (!_searchView) {
        _searchView = [[BNSearchView alloc]initWithFrame:CGRectZero];
        [_searchView.btn addActionHandler:^(UIControl * _Nonnull control) {
            DDLog(@"%@",_searchView.queryStr);
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchView;
}

-(BNCellDefaultView *)defaultView{
    if (!_defaultView) {
        _defaultView = [[BNCellDefaultView alloc]initWithFrame:CGRectZero];
        _defaultView.labelLeft.text = @"显示标题:";
        _defaultView.labelRight.text = @"11111";
        _defaultView.imgViewRight.hidden = false;
    }
    return _defaultView;
}

-(BNDateRangeView *)dateRangeView{
    if (!_dateRangeView) {
        _dateRangeView = [[BNDateRangeView alloc]initWithFrame:CGRectZero];
    }
    return _dateRangeView;
}

-(BNSliderView *)sliderView{
    if (!_sliderView) {
        _sliderView = [[BNSliderView alloc]initWithFrame:CGRectZero];
    }
    return _sliderView;
}

-(BNSheetView *)sheetView{
    if (!_sheetView) {
        _sheetView = [[BNSheetView alloc]initWithFrame:CGRectZero];
    }
    return _sheetView;
}

-(BNSwitchView *)switchView{
    if (!_switchView) {
        _switchView = [[BNSwitchView alloc]initWithFrame:CGRectZero];
    }
    return _switchView;
}

- (BNListChooseView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[BNListChooseView alloc]initWithFrame:CGRectZero];
    }
    return _chooseView;
}

@end
