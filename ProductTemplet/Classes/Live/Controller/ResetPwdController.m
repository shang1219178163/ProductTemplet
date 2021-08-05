//
//  ResetPwdController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/6/14.
//  Copyright © 2019 BN. All rights reserved.
//

#import "ResetPwdController.h"
#import "BNPwdModifyView.h"

@interface ResetPwdController ()

@property (nonatomic, strong) BNPwdModifyView *pwdModifyView;

@end

@implementation ResetPwdController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;  
    [self.view addSubview:self.pwdModifyView];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
 
}

#pragma mark -lazy
-(BNPwdModifyView *)pwdModifyView{
    if (!_pwdModifyView) {
        _pwdModifyView = [[BNPwdModifyView alloc]initWithFrame:self.view.bounds];
    }
    return _pwdModifyView;
}


@end
