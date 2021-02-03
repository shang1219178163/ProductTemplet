//
//  NNSearchView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/24.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNSearchView.h"

#import <NNGloble/NNGloble.h>
#import "UIView+Helper.h"
#import "UIButton+Helper.h"
#import "UITextField+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@implementation NNSearchView

- (void)dealloc{
    [self.btn removeObserver:self forKeyPath:@"hidden"];
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textField];
        [self addSubview:self.btn];
      
        self.queryStr = @"";
        self.textField.placeholder = @"请输入关键字";
        self.textField.delegate = self;
        
        [self.btn addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];
}

-(void)setupConstraint{
    if (self.btn.isHidden == true) {
        [self.textField makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(kX_GAP);
            make.right.equalTo(self).offset(-kX_GAP);
            make.height.equalTo(self.sizeHeight - kY_GAP*2);
        }];
        
    } else {
        [self.btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-kX_GAP);
            make.size.equalTo(CGSizeMake(60, self.sizeHeight - kY_GAP*2));
        }];
        
        [self.textField makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(kX_GAP);
            make.right.equalTo(self.btn.left).offset(kPadding);
            make.height.equalTo(self.btn);
        }];
    }
}

#pragma mark -observeValueForKeyPath
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"hidden"]) {
        [self setNeedsLayout];
    }
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        if (![self.queryStr isEqualToString:@""]) {
            self.queryStr = [self.queryStr substringToIndex:self.queryStr.length - 1];
        }
    } else {
        self.queryStr = [textField.text stringByAppendingString:string];
    }
    if (self.block) {
        self.block(self, self.queryStr, false);
    }
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(self, self.queryStr, true);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - lazy

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton createRect:CGRectZero title:@"搜索" type:NNButtonTypeTitleRedAndOutline];
    }
    return _btn;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = ({
            UITextField * view = [UITextField createRect:CGRectZero];
            view.returnKeyType = UIReturnKeySearch;
            view.leftView = ({
                UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
                
                UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
                imgView.image = [UIImage imageNamed:@"icon_search_bar"];
                imgView.contentMode = UIViewContentModeScaleAspectFit;
                imgView.center = view.center;
                [view addSubview:imgView];
                
                view;
            });
            view.leftViewMode = UITextFieldViewModeAlways;

            view;
        });
    }
    return _textField;
}


@end
