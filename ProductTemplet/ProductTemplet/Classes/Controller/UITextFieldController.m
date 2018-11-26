
//
//  UITextFieldController.m
//  ProductTemplet
//
//  Created by hsf on 2018/11/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITextFieldController.h"

#import "BN_Category.h"

#import "BN_ViewHeight.h"

@interface UITextFieldController ()

//@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) BN_TextFieldOne *textField;
@property (strong, nonatomic) UITextField *textFieldPwd;

@end

@implementation UITextFieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textField = [[BN_TextFieldOne alloc]initWithFrame:CGRectMake(10, 20, kScreen_width - 20, 40)];
    self.textField.backgroundColor = UIColor.greenColor;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textField];
    
    [self.textField showHistoryWithImage:@"click" handlder:^(BN_TextFieldOne * _Nonnull textField, UIImageView * _Nonnull imgView) {
        NSString * selectorName = CGRectGetHeight(textField.historyTableView.frame) < 5 ? @"showHistory"  :   @"hideHistroy";
        SEL selector = NSSelectorFromString(selectorName);
        [textField performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];

    }];
    
    //
    self.textFieldPwd = [[BN_TextFieldOne alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame), CGRectGetMaxY(self.textField.frame) + 10, kScreen_width - 20, 40)];
    self.textFieldPwd.backgroundColor = UIColor.greenColor;
    self.textFieldPwd.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textFieldPwd];
    
//    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    leftView.backgroundColor = UIColor.cyanColor;
//    self.textField.leftView = leftView;
//    self.textField.leftViewMode = UITextFieldViewModeAlways;

//    UIImageView *rightView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    rightView.backgroundColor = UIColor.orangeColor;
//    self.textField.rightView = rightView;
//    self.textField.rightViewMode = UITextFieldViewModeAlways;

//    [rightView addActionHandler:^(id obj, id item, NSInteger idx) {
//        UITextField * textField = ((UIView *)item).superview;
//        [textField showHistory];
//
//    }];
    
//    [leftView addActionHandler:^(id obj, id item, NSInteger idx) {
//        UITextField * textField = ((UIView *)item).superview;
//        [textField showHistory];
//
//    }];
    
    [self.view getViewLayer];
    
    self.textField.identify = @"one";
//    NSDictionary * dic = @{
//                           @"one"   :   @[@"111111",@"222222",@"33333",],
//                           };
    
    NSDictionary * dic = @{
                           @"one"   :   @{
                                            @"user1"    :   @"pwd_1",
                                            @"user2"    :   @"pwd_2",
                                            @"user3"    :   @"pwd_3",
                                   },
                           };

    [NSUserDefaults.standardUserDefaults setObject:dic forKey:kDeafult_textFieldHistory];
    [NSUserDefaults.standardUserDefaults synchronize];

    [self.textField showHistory];
    
    [self.textField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSDictionary * dic = [NSUserDefaults.standardUserDefaults objectForKey:kDeafult_textFieldHistory];
    NSDictionary * data = dic[@"one"];
    
    self.textFieldPwd.text = data[self.textField.text];
}


@end
