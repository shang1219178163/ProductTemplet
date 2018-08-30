//
//  WHKTableViewFifteenCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/14.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFifteenCell.h"

@interface WHKTableViewFifteenCell ()

@end

@implementation WHKTableViewFifteenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //                 文字2+文字1
    //------------------------
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //                 文字2+文字1
    //------------------------
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    CGSize labLeftSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:kScreen_width];
    
    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat lableLeftH = kH_LABEL;
    
    CGRect titleRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - YGap - labLeftSize.width, YGap*1.5, labLeftSize.width, lableLeftH);
    CGRect titleSubRect = CGRectMake(CGRectGetMinX(titleRect) - padding - labLeftSubSize.width, CGRectGetMinY(titleRect), labLeftSubSize.width, lableLeftH);
    
    self.labelLeft.frame = titleRect;
    self.labelLeftSub.frame = titleSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
