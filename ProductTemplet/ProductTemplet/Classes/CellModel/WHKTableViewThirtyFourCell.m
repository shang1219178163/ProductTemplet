
//
//  WHKTableViewThirtyFourCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/10/31.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewThirtyFourCell.h"

@interface WHKTableViewThirtyFourCell ()

@end

@implementation WHKTableViewThirtyFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字1+文字3
    //文字2

    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelRight];
    [self.contentView addSubview:self.labelLeftSub];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    CGSize textSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:kScreen_width];
    
    //图片+文字+文字+图片
    CGFloat YGap = kY_GAP/2;
    CGFloat padding = kPadding;
    
    CGFloat labelHeight = kH_LABEL;
    
    //控件3
    CGRect labelRightRect = CGRectMake(kScreen_width - textSize.width - kX_GAP, YGap, textSize.width, labelHeight);
    //控件1
    CGRect labelLeftRect = CGRectMake(kX_GAP, YGap, CGRectGetMinX(labelRightRect) - kX_GAP - padding, labelHeight);
    //控件2
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), CGRectGetWidth(labelLeftRect), labelHeight);

    
    self.labelRight.frame = labelRightRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
