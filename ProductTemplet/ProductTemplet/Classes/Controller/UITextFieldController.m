
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
    NSDictionary * dic = @{
                           @"one"   :   @[@"111111",@"222222",@"33333",],
                           };

    [NSUserDefaults.standardUserDefaults setObject:dic forKey:@"UITextField+JKHistory"];
    [NSUserDefaults.standardUserDefaults synchronize];

    [self.textField showHistory];
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
