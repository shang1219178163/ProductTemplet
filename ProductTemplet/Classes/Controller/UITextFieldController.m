
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

@interface UITextFieldController ()

//@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) NNTextFieldOne *textField;
@property (strong, nonatomic) NNTextFieldOne *textFieldPwd;
@property (strong, nonatomic) NNTextFieldOne *textFieldPwdNew;
@property (strong, nonatomic) UITextField *textFieldOne;

@end

@implementation UITextFieldController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupExtendedLayout];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Right" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem createItem:@"Right" style:UIBarButtonItemStyleDone];
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
    
    self.textField.identify = @"one";
    NSDictionary *dic = @{@"one":  @{@"user1":   @"pwd_1",
                                      @"user2":   @"pwd_2",
                                      @"user3":   @"pwd_3",
                                   },
                           };
    [NSUserDefaults.standardUserDefaults setObject:dic forKey:kTextFieldHistory];
    [NSUserDefaults.standardUserDefaults synchronize];

    [self.textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [self checkVersion];
}

#pragma mark -observeValueForKeyPath
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSDictionary *dic = [NSUserDefaults.standardUserDefaults objectForKey:kTextFieldHistory];
    NSDictionary *data = dic[@"one"];
    self.textFieldPwd.text = data[self.textField.text];
}


- (BOOL)checkVersion:(NSString *)appStoreID {
    __block BOOL isUpdate = NO;
    
    NSString *path = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", appStoreID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestPostURL:path body:nil];
    
    NSURLSessionDataTask *dataTask = [NSURLSession sendAsynRequest:request handler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            DDLog(@"%@",dic.allKeys);
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
        [_textField showHistoryWithImage:@"click" handlder:^(NNTextFieldOne * textField, UIImageView * imgView) {
            NSString *selectorName = CGRectGetHeight(textField.historyTableView.frame) < 5 ? @"showHistory"  :   @"hideHistroy";
            SEL selector = NSSelectorFromString(selectorName);
            [textField performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];

        }];
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
            NNTextFieldOne *textField = [NNTextFieldOne createPwdRect:CGRectMake(20, 140, kScreenWidth - 40, 40)
                                                                image:[UIImage imageNamed:@"icon_close"]
                                                        imageSelected:[UIImage imageNamed:@"icon_open"]];
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
            UITextField *textField = [UITextField createPwdRect:CGRectMake(20, 200, kScreenWidth - 40, 40)
                                                          image:[UIImage imageNamed:@"icon_close"]
                                                  imageSelected:[UIImage imageNamed:@"icon_open"]];
            
            textField;
        });
    }
    return _textFieldOne;
}


@end
