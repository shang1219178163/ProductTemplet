
//
//  BNBaseMenuListController.m
//  
//
//  Created by BIN on 2018/5/16.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "BNMenuListController.h"

#import "NNGloble.h"
#import "NNBtnView.h"
#import "NNMenuView.h"

#import "UIView+Helper.h"
#import "NSArray+Helper.h"

@interface BNMenuListController ()

@property (nonatomic, strong) NNBtnView * btnView;
@property (nonatomic, strong) NNMenuView * menuView;

@end

@implementation BNMenuListController

-(NNBtnView *)btnView{
    if (!_btnView) {
        _btnView = ({
            NNBtnView * btnView = [[NNBtnView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth/4.0, 50)];
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
    self.btnView.block = ^(NNBtnView *view) {
        DDLog(@"%@",view.label.text);
        
    };
    
    self.btnView.imageView.image = nil;

    
    [self.view getViewLayer];
}

- (void)configureMenuList{
    NSArray * menuList = [NSArray arrayItemPrefix:@"工厂_" startIndex:1 count:10 type:@0];
    
    self.navigationItem.titleView = self.btnView;
    
    self.btnView.label.text = [menuList firstObject];
    self.btnView.label.textColor = UIColor.whiteColor;
    self.btnView.block = ^(NNBtnView *view) {
        [self handleActionBtnView:view];
        
    };
    
    NNMenuView * menuView = [[NNMenuView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.0)];
    menuView.dataList = menuList;
    menuView.block = ^(NNMenuView *view, NSIndexPath *indexPath) {
        
        NSString * string = menuList[indexPath.row];
        self.btnView.label.text = string;
        [self handleActionBtnView:self.btnView];
        
        [UIView animateWithDuration:kDurationDrop animations:^{
            self.btnView.imageView.transform = view.isShow  ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
            
        }];
        
    };
    
    self.menuView = menuView;
    
    [self.navigationItem.titleView getViewLayer];
    
    
}

#pragma mark - -BINBtnView
- (void)handleActionBtnView:(NNBtnView *)sender{
    self.menuView.isShow = CGAffineTransformIsIdentity(sender.imageView.transform) ? YES : NO;

    [UIView animateWithDuration:kDurationDrop animations:^{
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
