
//
//  WHKTableViewSixtyOneCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/3/28.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSixtyOneCell.h"

@interface WHKTableViewSixtyOneCell ()

@end

@implementation WHKTableViewSixtyOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     文字
    +文字
     */
    //控件2
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    if ([self.labelLeft.attributedText validObject]) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:kScreen_width];
    }
//    CGSize labLeftDetailSize = [self sizeWithText:self.labelLeftDetail.text font:self.labelLeftDetail.font width:kScreen_width];
//    if ([self.labelLeftDetail.attributedText validObject]) {
//        labLeftDetailSize = [self sizeWithText:self.labelLeftDetail.attributedText font:self.labelLeftDetail.font width:kScreen_width];
//    }
    //控件
    CGFloat lableLeftH = kH_LABEL;
    CGFloat XGap = kX_GAP;
    CGFloat YGap = CGRectGetMidY(self.contentView.frame) - lableLeftH;
//    CGFloat padding = 10;
    
    //控件
    self.labelLeft.frame = CGRectMake(XGap, YGap, labLeftSize.width, lableLeftH);
    self.labelLeftSub.frame = CGRectMake(XGap, CGRectGetMaxY(self.labelLeft.frame),labLeftSize.width, lableLeftH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz


@end
