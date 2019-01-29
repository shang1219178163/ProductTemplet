
//
//  UITextFieldController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/23.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITextFieldController.h"

#import "BNCategory.h"

#import "BNViewHeight.h"


@interface UITextFieldController ()

//@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) BNTextFieldOne *textField;
@property (strong, nonatomic) UITextField *textFieldPwd;

@end

@implementation UITextFieldController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Right" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self.navigationItem.rightBarButtonItem setActionBlock:^{
        DDLog(@"%@",@"111");

    }];
    
    self.textField = [[BNTextFieldOne alloc]initWithFrame:CGRectMake(10, 20, kScreenWidth - 20, 40)];
    self.textField.backgroundColor = UIColor.greenColor;
    self.textField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.textField];
    
    [self.textField showHistoryWithImage:@"click" handlder:^(BNTextFieldOne * _Nonnull textField, UIImageView * _Nonnull imgView) {
        NSString * selectorName = CGRectGetHeight(textField.historyTableView.frame) < 5 ? @"showHistory"  :   @"hideHistroy";
        SEL selector = NSSelectorFromString(selectorName);
        [textField performSelectorOnMainThread:selector withObject:nil waitUntilDone:NO];

    }];
    
    //
    self.textFieldPwd = [[BNTextFieldOne alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textField.frame), CGRectGetMaxY(self.textField.frame) + 10, kScreenWidth - 20, 40)];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self checkVersion];
    
    
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 200, 100, 100)];
    imgView.image = [UIImage imageNamed:@"btn_add"];
    imgView.backgroundColor = UIColor.redColor;
    [self.view addSubview:imgView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSDictionary * dic = [NSUserDefaults.standardUserDefaults objectForKey:kDeafult_textFieldHistory];
    NSDictionary * data = dic[@"one"];
    
    self.textFieldPwd.text = data[self.textField.text];
}


- (BOOL)checkVersion {
    __block BOOL isUpdate = NO;
    
    NSString *path = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",kID_AppStoreConnect];
    NSMutableURLRequest *request = [NSMutableURLRequest requestPostURL:path body:nil];
    
    NSURLSessionDataTask *dataTask = [NSURLSession sendAsynRequest:request handler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            DDLog(@"%@",dic.allKeys);
        }
    }];
    [dataTask resume];
    return isUpdate;
}



@end
