
//
//  BN_BaseMenuListController.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/16.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_MenuListController.h"

#import "BN_Globle.h"
#import "BN_BtnView.h"
#import "BN_MenuView.h"

#import "UIView+Helper.h"
#import "NSArray+Helper.h"

@interface BN_MenuListController ()

@property (nonatomic, strong) BN_BtnView * btnView;
@property (nonatomic, strong) BN_MenuView * menuView;

@end

@implementation BN_MenuListController

-(BN_BtnView *)btnView{
    if (!_btnView) {
        _btnView = ({
            BN_BtnView * btnView = [[BN_BtnView alloc]initWithFrame:CGRectMake(10, 10, kScreen_width/4.0, 50)];
            btnView.imageView.image = [UIImage imageNamed:@"img_arrowDown_orange.png"];
            btnView.label.text = @"测试数据";
            btnView.type = @3;
            btnView.adjustsSizeToFitText = YES;

            btnView;
        });
    }
    return _btnView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.greenColor;
    
//    [self configureMenuList];
    
    [self.view addSubview:self.btnView];
    self.btnView.block = ^(BN_BtnView *view) {
        DDLog(@"%@",view.label.text);
        
    };
    
    self.btnView.imageView.image = nil;

    
    [self.view getViewLayer];
}

- (void)configureMenuList{
    NSArray * menuList = [NSArray arrayWithItemPrefix:@"工厂_" startIndex:1 count:10 type:@0];
    
    self.navigationItem.titleView = self.btnView;
    
    self.btnView.label.text = [menuList firstObject];
    self.btnView.label.textColor = UIColor.whiteColor;
    self.btnView.block = ^(BN_BtnView *view) {
        [self handleActionBtnView:view];
        
    };
    
    BN_MenuView * menuView = [[BN_MenuView alloc]initWithFrame:CGRectMake(0, 0, kScreen_width, 0.0)];
    menuView.dataList = menuList;
    menuView.block = ^(BN_MenuView *view, NSIndexPath *indexPath) {
        
        NSString * string = menuList[indexPath.row];
        self.btnView.label.text = string;
        [self handleActionBtnView:self.btnView];
        
        [UIView animateWithDuration:kAnimDuration_Drop animations:^{
            self.btnView.imageView.transform = view.isShow  ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
            
        }];
        
    };
    
    self.menuView = menuView;
    
    [self.navigationItem.titleView getViewLayer];
    
    
}

#pragma mark - -BINBtnView
- (void)handleActionBtnView:(BN_BtnView *)sender{
    self.menuView.isShow = CGAffineTransformIsIdentity(sender.imageView.transform) ? YES : NO;

    [UIView animateWithDuration:kAnimDuration_Drop animations:^{
        sender.imageView.transform = CGAffineTransformIsIdentity(sender.imageView.transform) ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
