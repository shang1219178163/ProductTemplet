//
//  BN_UserPwdChangeController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/4.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "BN_UserPwdChangeController.h"



@interface BN_UserPwdChangeController ()

@property (nonatomic, strong) NSMutableArray * itemList;
@property (nonatomic, strong) UIButton * btnCode;
@property (nonatomic, strong) UIButton * btnSure;

@end

@implementation BN_UserPwdChangeController

-(NSMutableArray *)itemList{
    if (!_itemList) {
        _itemList = @[
                      @{
                          @"text"           :  @"",
                          @"placeholder"    :  @"   请输入手机号",
                          
                          }.mutableCopy,
                      @{
                          @"text"           :  @"",
                          @"placeholder"    :  @"   请输入验证码",
                          
                          }.mutableCopy,
                      @{
                          @"text"           :  @"",
                          @"placeholder"    :  @"   请输入新密码",
                          
                          }.mutableCopy,
                      @{
                          @"text"           :  @"",
                          @"placeholder"    :  @"   确认密码",
                          
                          }.mutableCopy,
                      ].mutableCopy;
    }
    return _itemList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
        
    [self createControls];
    
    
    [self.view getViewLayer];
}

- (void)createControls{
    CGFloat height = 35;
    CGFloat padding = 15;
    CGSize btnPwdSize = CGSizeMake(90, height);
    
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(kX_GAP,kX_GAP,kX_GAP,kX_GAP));
        
    }];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    
    NSInteger count = self.itemList.count;
    UIView * lastView = nil;
    for (NSInteger i = 0 ; i < count ; ++i){
        NSMutableDictionary * mdict = self.itemList[i];
        
        UITextField *subv = [UITextField new];
        subv.tag = kTAG_TEXTFIELD+i;
        subv.backgroundColor = [UIColor lightTextColor];
        [container addSubview:subv];
        
        subv.text = mdict[@"text"];
        subv.placeholder = mdict[@"placeholder"];
        
        [subv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(container);
            make.height.equalTo(height);
            
            if (lastView){
                make.top.equalTo(lastView.bottom).offset(padding);
            }
            else{
                make.top.equalTo(container.top).offset(0);
            }
        }];
        lastView = subv;
        
        if (i == 1) {
            [subv updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).offset(-(padding*2 + btnPwdSize.width));
                
                [container addSubview:self.btnCode];
                [self.btnCode makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(lastView).offset(0);
                    make.left.equalTo(lastView.right).offset(padding);
                    make.right.equalTo(container).offset(0);
                    
                    make.size.equalTo(btnPwdSize);
                    
                }];
            }];
        }else{
            [subv updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).offset(0);
                
            }];
            
        }
    }
    
    [container addSubview:self.btnSure];
    [self.btnSure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastView.bottom).offset(height);
        make.left.right.equalTo(lastView).offset(0);
        make.height.equalTo(lastView);
    }];
    lastView = self.btnSure;
    
    
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.bottom.equalTo(lastView.bottom);
        make.width.equalTo(scrollView);
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - - layz
-(UIButton *)btnCode{
    if (!_btnCode) {
        _btnCode = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            
            btn;
        });
    }
    return _btnCode;
}

-(UIButton *)btnSure{
    if (!_btnSure) {
        _btnSure = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@"提交" forState:UIControlStateNormal];
            [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            [btn setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateNormal];
            btn;
        });
    }
    return _btnSure;
}

@end
