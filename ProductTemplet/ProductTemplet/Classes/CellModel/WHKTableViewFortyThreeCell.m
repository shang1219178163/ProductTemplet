//
//  WHKTableViewFortyThreeCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/11/30.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFortyThreeCell.h"

@interface WHKTableViewFortyThreeCell ()


@end

@implementation WHKTableViewFortyThreeCell

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
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    
    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat textFieldH = 30;
    CGFloat lableLeftH = textFieldH;
    
    //控件1
    CGRect titleRect = CGRectMake(YGap, YGap, labLeftSize.width, lableLeftH);
    //控件2
    CGRect titleSubRect = CGRectMake(CGRectGetMaxX(titleRect) + padding, YGap, kScreen_width - YGap - CGRectGetMaxX(titleRect) - padding, textFieldH);
    
    self.labelLeft.frame = titleRect;
    self.textField.frame = titleSubRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

