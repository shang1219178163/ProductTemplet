//
//  TextViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/11/26.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "TextViewController.h"

#import "BN_Category.h"
#import "UITextView+Helper.h"

@interface TextViewController ()

@property (strong, nonatomic) UITextView *textView;

@end

@implementation TextViewController

- (UITextView *)textView{
    if (!_textView) {
        _textView = ({
            UITextView * view = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 180)];
            view.placeHolderTextView.text = @"11111";
            view;
        });
    }
    return _textView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.textView];
    
    
    DDLog(@"_%@_%@_",self.textView.placeHolderTextView,self.textView.placeHolderTextView.text);
    
    [self.view getViewLayer];

}



@end
