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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
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
            UIViewController *vc = [[NSClassFromString(@"ResetPwdController") alloc]init];
            vc.title = @"重置密码";
            [self.navigationController pushViewController:vc animated:true];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneCodeView;
}


@end
