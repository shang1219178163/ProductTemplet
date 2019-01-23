//
//  UITableViewTextFieldCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewTextFieldCell.h"

#import "BN_Globle.h"
#import "BN_TextField.h"
#import "NSObject+Helper.h"

@interface UITableViewTextFieldCell ()

 
@end

@implementation UITableViewTextFieldCell

-(void)dealloc{
    [self.textField removeObserver:self forKeyPath:@"enabled" context:nil];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    //文字+文字(textField)
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    
    
    self.textField.placeholder = @"请输入";
    self.textField.textAlignment = NSTextAlignmentCenter;
    self.textField.delegate = self;
    
    [self.textField addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }
    
    CGFloat textFieldH = 30;
    CGFloat lableLeftH = textFieldH;
    
    //控件1
    self.labelLeft.frame = CGRectMake(kX_GAP, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    //控件2
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + kPadding, CGRectGetMidY(self.contentView.frame) - textFieldH/2.0, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.labelLeft.frame) - kPadding - kX_GAP, textFieldH);
    if (!self.labelLeft.text && !self.labelLeft.attributedText) {
        self.textField.frame = CGRectMake(kX_GAP, CGRectGetMidY(self.contentView.frame) - textFieldH/2.0, CGRectGetWidth(self.contentView.frame) - kX_GAP*2, textFieldH);
        
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //    [[[self superview] superview] endEditing:YES];
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.string = textField.text;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[[self superview] superview] endEditing:YES];
    return YES;
}

#pragma mark - -

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"enabled"]) {
        if ([change[NSKeyValueChangeNewKey] boolValue]) {
            self.textField.placeholder = @"请输入";
            
            self.textField.layer.borderWidth = kW_LayerBorder;
            self.textField.layer.borderColor = UIColor.lineColor.CGColor;
        } else {
            self.textField.placeholder = @"";
            self.textField.text = [self.textField.text validObject] ? self.textField.text :  kNIl_TEXT;
            
            self.textField.layer.borderWidth = kW_LayerBorder;
            self.textField.layer.borderColor = UIColor.clearColor.CGColor;
            
        }
    }
}


#pragma mark - -other

-(void)setString:(NSString *)string{
    _string = string;
    if (self.block) {
        self.block(self, string);
    }
}


#pragma mark - -layz



@end

