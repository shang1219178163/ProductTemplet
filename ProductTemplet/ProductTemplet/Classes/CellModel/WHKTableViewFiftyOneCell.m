
//
//  WHKTableViewFiftyOneCell.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFiftyOneCell.h"

@interface WHKTableViewFiftyOneCell ()


@end

@implementation WHKTableViewFiftyOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    //文字+textField+textField+textField
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textFieldLeft];
    [self.contentView addSubview:self.textFieldCenter];
    [self.contentView addSubview:self.textFieldRight];

    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    

    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:kScreen_width];
    }
    CGFloat XGap = kX_GAP;
//    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat textFieldH = 30;
    CGFloat lableLeftH = textFieldH;
    CGFloat textFieldWidth = (CGRectGetWidth(self.contentView.frame) - labLeftSize.width - XGap*2 - padding*3)/3.0;
    
    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2., labLeftSize.width, lableLeftH);
    self.textFieldLeft.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame)+padding, CGRectGetMinY(self.labelLeft.frame), textFieldWidth, textFieldH);
    self.textFieldCenter.frame = CGRectMake(CGRectGetMaxX(self.textFieldLeft.frame)+padding, CGRectGetMinY(self.labelLeft.frame), textFieldWidth, textFieldH);
    self.textFieldRight.frame = CGRectMake(CGRectGetMaxX(self.textFieldCenter.frame)+padding, CGRectGetMinY(self.labelLeft.frame), textFieldWidth, textFieldH);

//    self.textFieldLeft.backgroundColor = [UIColor randomColor];
//    self.textFieldCenter.backgroundColor = [UIColor randomColor];
//    self.textFieldRight.backgroundColor = [UIColor randomColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BN_TextField *)textFieldLeft{
    if (!_textFieldLeft) {
        _textFieldLeft = [UIView createBINTextFieldWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Second textAlignment:NSTextAlignmentCenter keyboardType:UIKeyboardTypeDefault];
        _textFieldLeft.tag = kTAG_TEXTFIELD;
        
    }
    return _textFieldLeft;
}

-(BN_TextField *)textFieldCenter{
    if (!_textFieldCenter) {
        _textFieldCenter = [UIView createBINTextFieldWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Second textAlignment:NSTextAlignmentCenter keyboardType:UIKeyboardTypeDefault];
        _textFieldCenter.tag = kTAG_TEXTFIELD+1;
        
    }
    return _textFieldCenter;
}

-(BN_TextField *)textFieldRight{
    if (!_textFieldRight) {
        _textFieldRight = [UIView createBINTextFieldWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Second textAlignment:NSTextAlignmentCenter keyboardType:UIKeyboardTypeDefault];
        _textFieldRight.tag = kTAG_TEXTFIELD+2;
        
    }
    return _textFieldRight;
}

@end
