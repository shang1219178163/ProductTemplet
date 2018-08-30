//
//  WHKTableViewFiftySevenCell.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/26.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFiftySevenCell.h"

@interface WHKTableViewFiftySevenCell ()


@end

@implementation WHKTableViewFiftySevenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
    |+文字+箭头
    |+文字
     */
    //控件1
    [self.contentView addSubview:self.labelLeftPrefix];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    [self.contentView addSubview:self.imgViewRight];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    if ([self.labelLeft.attributedText validObject]) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:kScreen_width];
    }
    
    CGSize labLeftSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:kScreen_width];
    if ([self.labelLeftSub.attributedText validObject]) {
        labLeftSubSize = [self sizeWithText:self.labelLeftSub.attributedText font:self.labelLeftSub.font width:kScreen_width];
    }
    
    CGFloat XGap = kX_GAP;
//    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    CGFloat lableLeftH = kH_LABEL;
    
    CGSize imgViewRightSize = CGSizeMake(25, 25);
    self.imgViewRight.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  XGap, CGRectGetMidY(self.contentView.frame) - imgViewRightSize.height/2.0, imgViewRightSize.width, imgViewRightSize.height);
    
    self.labelLeftPrefix.frame = CGRectMake(padding, 0, kW_LINE_Vert, CGRectGetHeight(self.contentView.frame));
    self.labelLeft.frame = CGRectMake(CGRectGetMaxX(self.labelLeftPrefix.frame) + XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0*2, labLeftSize.width, lableLeftH);
    self.labelLeftSub.frame = CGRectMake(CGRectGetMaxX(self.labelLeftPrefix.frame) + XGap, CGRectGetMaxY(self.labelLeft.frame), labLeftSubSize.width, lableLeftH);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UILabel *)labelLeftPrefix{
    if (!_labelLeftPrefix) {
        _labelLeftPrefix = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+5 patternType:@"2" font:KFZ_Second backgroudColor:kC_ThemeCOLOR alignment:NSTextAlignmentLeft];
    }
    return _labelLeftPrefix;
}


@end
