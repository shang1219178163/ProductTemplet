
//
//  WHKTableViewThirtySevenCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/11/9.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewThirtySevenCell.h"

@interface WHKTableViewThirtySevenCell ()

@end

@implementation WHKTableViewThirtySevenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字1+空格+文字2(交易明细)
    /*
     -------------------------
     文字:   文字
            .
            .
            .
     -------------------------
     */

    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize titleSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    CGFloat contentMaxWidth = kScreen_width - kX_GAP - titleSize.width - kPadding - kX_GAP;

    CGSize contentSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:contentMaxWidth];
    if (contentSize.height < kH_LABEL) {
        contentSize.height = kH_LABEL;
    }
    CGFloat padding = kPadding;
    
    CGFloat labelSubHeight = kH_LABEL;
    if (contentSize.width > 0) {
        labelSubHeight = contentSize.height;

    }
        
    //控件1
    CGRect labelLeftRect = CGRectMake(kX_GAP, kY_GAP, titleSize.width, labelSubHeight);
    //控件2
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMaxX(labelLeftRect)+padding, CGRectGetMinY(labelLeftRect), contentMaxWidth, labelSubHeight);
    
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftMark.frame = labelLeftSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end

