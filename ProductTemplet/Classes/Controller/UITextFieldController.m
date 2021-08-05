
//
//  UITextFieldController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITextFieldController.h"
#import "UIView+Tmp.h"
#import "KVOViewController.h"
#import <NNCategoryPro/NNCategoryPro.h>

@interface UITextFieldController ()

//@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NNTextFieldOne *textField;
@property (strong, nonatomic) NNTextFieldOne *textFieldPwd;
@property (strong, nonatomic) NNTextFieldOne *textFieldPwdNew;
@property (strong, nonatomic) UITextField *textFieldOne;
@property (nonatomic, strong) UIButton *button;

@end

@implementation UITextFieldController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupExtendedLayout];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Right" style:UIBarButtonItemStyleDone target:nil action:nil];
    @weakify(self);
    [self.navigationItem.rightBarButtonItem addActionBlock:^(UIBarButtonItem * _Nonnull item) {
        @strongify(self);
        KVOViewController *controller = [[KVOViewController alloc]init];
        [self.navigationController pushViewController:controller animated:true];
    }];
    
    [self.view addSubview:self.textField];
    [self.view addSubview:self.textFieldPwd];
    [self.view addSubview:self.textFieldPwdNew];
    [self.view addSubview:self.textFieldOne];
    [self.view addSubview:self.button];

    self.textField.backgroundColor = UIColor.systemGreenColor;
    self.textFieldPwd.backgroundColor = UIColor.systemOrangeColor;
    self.textFieldPwdNew.backgroundColor = UIColor.systemYellowColor;
    self.textFieldOne.backgroundColor = UIColor.systemTealColor;

//    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    leftView.backgroundColor = UIColor.cyanColor;
//    self.textField.leftView = leftView;
//    self.textField.leftViewMode = UITextFieldViewModeAlways;

//    UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    rightView.backgroundColor = UIColor.orangeColor;
//    self.textField.rightView = rightView;
//    self.textField.rightViewMode = UITextFieldViewModeAlways;
//
//    [rightView addGestureTap:^(UITapGestureRecognizer * _Nonnull reco) {
//        UITextField *textField = reco.view.superview;
//        [textField showHistory];
//    }];
//    
//    [leftView addGestureTap:^(UITapGestureRecognizer * _Nonnull reco) {
//        UITextField * textField = reco.view.superview;
//        [textField showHistory];
//
//    }];
    

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(80);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(35);
    }];
    
    [self.textFieldPwd makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(35);
    }];
    
    [self.textFieldPwdNew makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPwd.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(35);
    }];
    
    [self.textFieldOne makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldPwdNew.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(35);
    }];
    
    [self.button makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldOne.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.height.equalTo(35);
        make.width.equalTo(60);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self checkVersion];
}

- (BOOL)checkVersion:(NSString *)appStoreID {
    __block BOOL isUpdate = NO;
    
    NSString *path = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", appStoreID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestPostURL:path body:nil];
    
    NSURLSessionDataTask *dataTask = [NSURLSession sendAsynRequest:request handler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            DDLog(@"%@", dic.allKeys);
        }
    }];
    [dataTask resume];
    return isUpdate;
}

#pragma mark -lazy
- (NNTextFieldOne *)textField{
    if (!_textField) {
        _textField = [[NNTextFieldOne alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth - 40, 40)];
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        
        _textField.menuTarget.list = @[@"111", @"222", @"333", @"444", @"555"].mutableCopy;
        _textField.menuTarget.block = ^(NNTextFieldMenuTarget *target) {
            DDLog(@"%@", target.selectedText);
        };
    }
    return _textField;
}

-(NNTextFieldOne *)textFieldPwd{
    if (!_textFieldPwd) {
        _textFieldPwd = ({
            NNTextFieldOne * textField = [[NNTextFieldOne alloc]initWithFrame:CGRectMake(20, 80, kScreenWidth - 40, 40)];
            textField.tag = kTAG_TEXTFIELD+1;
            textField.placeholder = @"  请输入密码";
            
//            textField.clearsOnBeginEditing = YES;
            textField.clearButtonMode = UITextFieldViewModeAlways;
            textField.secureTextEntry = YES;
            
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 0, 30, 30);
            [btn setImage:UIImageNamed(@"icon_close") forState:UIControlStateNormal];
            [btn setImage:UIImageNamed(@"icon_open") forState:UIControlStateSelected];
            [btn setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [btn addActionHandler:^(UIButton * _Nonnull sender) {
                sender.selected = !sender.selected;

                NSString *tempPwdStr = textField.text;
                textField.text = @""; // 这句代码可以防止切换的时候光标偏移
                textField.secureTextEntry = !sender.selected;
                textField.text = tempPwdStr;

            } forControlEvents:UIControlEventTouchUpInside];

            textField.rightView = btn;
            textField.rightViewMode = UITextFieldViewModeAlways;
            
            textField;
        });
    }
    return _textFieldPwd;
}

-(NNTextFieldOne *)textFieldPwdNew{
    if (!_textFieldPwdNew) {
        _textFieldPwdNew = ({
            NNTextFieldOne *textField = [[NNTextFieldOne alloc]initWithFrame:CGRectMake(20, 140, kScreenWidth - 40, 40)];
            [textField addPasswordEveBlock:[UIImage imageNamed:@"icon_close"]
                             imageSelected:[UIImage imageNamed:@"icon_open"]
                                      edge:UIEdgeInsetsZero
                                     block:^(UIButton *sender) {
                DDLog(@"sender: %@", sender);
            }];
//            NNTextFieldOne * textField = [[NNTextFieldOne alloc]initWithFrame:CGRectMake(20, 140, kScreenWidth - 40, 40)];
//            textField.placeholder = @"  请输入密码";
//            textField.backgroundColor = UIColor.greenColor;
////            textField.clearsOnBeginEditing = YES;
//            textField.clearButtonMode = UITextFieldViewModeAlways;
//            textField.secureTextEntry = true;
//
//            textField.leftViewMode = UITextFieldViewModeAlways;
//            textField.leftView = ({
//                UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//                imgView.userInteractionEnabled = true;
//                imgView.image = [UIImage imageNamed: @"icon_close"];
//                imgView.contentMode = UIViewContentModeCenter;
//
////                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionTapGesture:)];
//                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
//                tap.numberOfTapsRequired = 1;
//                tap.numberOfTouchesRequired = 1;
//                //    tapGesture.cancelsTouchesInView = NO;
//                //    tapGesture.delaysTouchesEnded = NO;
//                [tap addActionBlock:^(UIGestureRecognizer * _Nonnull reco) {
//                    DDLog(@"%@", reco)
//                    UIImageView * sender = (UIImageView *)reco.view;
//                    sender.selected = !sender.selected;
//                    sender.image = UIImageNamed(sender.selected == false ? @"icon_close" : @"icon_open");
//
//                    UITextField * textField = self.textFieldPwdNew;
//                    NSString *tempPwdStr = textField.text;
//                    textField.text = @""; // 这句代码可以防止切换的时候光标偏移
//                    textField.secureTextEntry = !sender.selected;
//                    textField.text = tempPwdStr;
//                }];
//
//                [imgView addGestureRecognizer:tap];
//
//                imgView;
//            });
            textField;
        });
    }
    return _textFieldPwdNew;
}

- (void)handleActionTapGesture:(UITapGestureRecognizer *)reco{
    UIImageView *sender = (UIImageView *)reco.view;
    sender.selected = !sender.selected;
    sender.image = UIImageNamed(sender.selected == false ? @"icon_close" : @"icon_open");
    
    UITextField *textField = self.textFieldPwdNew;
    NSString *tempPwdStr = textField.text;
    textField.text = @""; // 这句代码可以防止切换的时候光标偏移
    textField.secureTextEntry = !sender.selected;
    textField.text = tempPwdStr;

}

-(UITextField *)textFieldOne{
    if (!_textFieldOne) {
        _textFieldOne = ({
//            UITextField *textField = [UITextField createPwdRect:CGRectMake(20, 200, kScreenWidth - 40, 40)
//                                                          image:[UIImage imageNamed:@"icon_close"]
//                                                  imageSelected:[UIImage imageNamed:@"icon_open"]];
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(20, 140, kScreenWidth - 40, 40)];
            [textField addPasswordEveBlock:[UIImage imageNamed:@"icon_close"]
                             imageSelected:[UIImage imageNamed:@"icon_open"]
                                      edge:UIEdgeInsetsZero
                                     block:^(UIButton *sender) {
                DDLog(@"sender: %@", sender);
            }];
            textField;
        });
    }
    return _textFieldOne;
}

- (UIButton *)button{
    if (!_button) {
        _button = ({
            UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
            [sender setTitle:@"下拉列表" forState:UIControlStateNormal];
            [sender setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
//            [sender setTitleColor:UIColor.systemBlueColor forState:UIControlStateSelected];
            sender.titleLabel.font = [UIFont systemFontOfSize:15];
            
            sender.titleLabel.adjustsFontSizeToFitWidth = YES;
            sender.imageView.contentMode = UIViewContentModeScaleAspectFit;
            sender;
        });
                
        _button.menuTarget.hiddenClearButton = true;
        _button.menuTarget.list = @[@"北京", @"上海", @"广州", @"深圳", @"西安"].mutableCopy;
        _button.menuTarget.block = ^(NNButtonMenuTarget *menuTarget) {
            DDLog(@"%@", menuTarget.selectedText);
        };
    }
    return _button;
}

@end
