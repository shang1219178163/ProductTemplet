//
//  WHKTableViewAddressCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/21.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewAddressCell.h"

@interface WHKTableViewAddressCell ()

@end

@implementation WHKTableViewAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片+文字+图片
    BN_TextField * textField = [UIView createBINTextFieldWithRect:CGRectZero text:@"" placeholder:@"" font:KFZ_Third textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault leftView:nil leftPadding:5 rightView:nil rightPadding:5 ];
    textField.tag = kTAG_TEXTFIELD;
    [self.contentView addSubview:textField];
    
    UIView * topLine = [UIView createLineWithRect:CGRectMake(0, 0, kScreen_width, kH_LINE_VIEW) isDash:NO tag:kTAG_VIEW+10];
    [self.contentView addSubview:topLine];
    
    self.textField = textField;
    self.lineTop = topLine;
    self.lineTop.hidden = YES;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //View+文字+view
    CGFloat textFieldHeight = kH_TEXTFIELD;
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - textFieldHeight)/2.0;

    self.textField.frame = CGRectMake(0, YGap, CGRectGetWidth(self.contentView.frame), textFieldHeight);
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
