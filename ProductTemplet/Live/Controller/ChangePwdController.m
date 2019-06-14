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
            [self goController:@"ResetPwdController" title:@"重置密码"];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneCodeView;
}


@end
