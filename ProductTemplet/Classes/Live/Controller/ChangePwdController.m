//
//  ChangePwdController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/14.
//  Copyright © 2019 BN. All rights reserved.
//

#import "ChangePwdController.h"
#import "BNPhoneCodeView.h"

@interface ChangePwdController ()

@property(nonatomic, strong) BNPhoneCodeView * phoneCodeView;

@end

@implementation ChangePwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.phoneCodeView];
    
//    [self.view getViewLayer];
}



#pragma mark -lazy

- (BNPhoneCodeView *)phoneCodeView{
    if (!_phoneCodeView) {
        _phoneCodeView = [[BNPhoneCodeView alloc]initWithFrame:self.view.bounds];
        @weakify(self);
        [_phoneCodeView.btn addActionHandler:^(UIButton * _Nonnull sender) {
            @strongify(self);
            [self.navigationController pushVC:@"ResetPwdController" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
                vc.title = @"重置密码";
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneCodeView;
}


@end
