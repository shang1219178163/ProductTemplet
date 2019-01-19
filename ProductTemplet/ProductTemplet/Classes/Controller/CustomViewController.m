//
//  CustomViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/19.
//  Copyright © 2019 BN. All rights reserved.
//

#import "CustomViewController.h"

#import "BNItemsView.h"
#import "BNWalletView.h"

@interface CustomViewController ()

@property (nonatomic, strong) BNItemsView * itemsView;
@property (nonatomic, strong) BNWalletView * walletView;

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray * list = [NSMutableArray array];
    for (NSInteger i = 0; i < 16; i++) {
        NSString * title = [NSString stringWithFormat:@"item_%@",@(i)];
        [list addObject:title];
    }
    
    list = [NSArray arrayWithItemPrefix:@"item_" startIndex:0 count:16 type:@0];
    self.itemsView.frame = CGRectMake(20, 20, kScreenWidth - 40, kScreenWidth - 40);
    self.itemsView.items = list;
//    [self.view addSubview: self.itemsView];
    
    NSMutableArray * listNew = [NSMutableArray array];
    for (NSInteger i = 0; i < 12; i++) {
        NSString * title = [NSString stringWithFormat:@"item_%@",@(i)];
        [listNew addObject:title];
    }
    self.itemsView.items = listNew;

    self.walletView.frame = CGRectMake(20, 20, kScreenWidth - 40, kScreenWidth - 40);
    [self.view addSubview: self.walletView];
    self.walletView.type = @2;
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
        _walletView.block = ^(BNWalletView * _Nonnull walletView, UIView * _Nonnull view) {
            DDLog(@"_%@",@(view.tag));
        };
    }
    return _walletView;
}



@end
