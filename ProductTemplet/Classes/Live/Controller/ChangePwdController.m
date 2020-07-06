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
        [_phoneCodeView.btn addActionHandler:^(UIControl * _Nonnull control) {
            [self pushVC:@"ResetPwdController" title:@"重置密码" animated:true block:^(__kindof UIViewController * _Nonnull vc) {
                
            }];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneCodeView;
}


@end
