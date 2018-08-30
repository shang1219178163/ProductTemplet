//
//  WHKTableViewThirtyThreeCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/10/30.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewThirtyThreeCell.h"

@interface WHKTableViewThirtyThreeCell ()

@end

@implementation WHKTableViewThirtyThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片1+文字2+icon3+单选框5
    //     文字4
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftMark];
    
    [self.contentView addSubview:self.imgViewIcon];
    [self.contentView addSubview:self.radioView];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    CGSize labLeftSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:kScreen_width];
    
    CGFloat YGap = kY_GAP;
    CGFloat heightLab = kH_LABEL;
    CGFloat heightImgView = CGRectGetHeight(self.contentView.frame) - YGap*2;

    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, heightImgView, heightImgView);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, CGRectGetMinY(imgViewLeftRect), labLeftSize.width, heightLab);
    //控件3
    CGSize iconSize = CGSizeMake(28, 15);
    CGRect imgViewIconRect = CGRectMake(CGRectGetMaxX(labelLeftRect) + kPadding, CGRectGetMidY(labelLeftRect) - iconSize.height/2.0, iconSize.width, iconSize.height);
    
    //控件4
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, CGRectGetMaxY(labelLeftRect), labLeftSubSize.width, heightLab);
    
    //控件5
    CGSize imgViewRightSize = CGSizeMake(30, 30);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  YGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
 
    self.imgViewLeft.frame = imgViewLeftRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftMark.frame = labelLeftSubRect;
    self.imgViewIcon.frame = imgViewIconRect;
    self.radioView.frame = imgViewRightRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
