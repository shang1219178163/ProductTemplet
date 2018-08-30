//
//  WHKTableViewFiftyEightCell.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/26.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFiftyEightCell.h"

@interface WHKTableViewFiftyEightCell ()

@end

@implementation WHKTableViewFiftyEightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字+|+文字+文字
    //控件2
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    [self.contentView addSubview:self.labelRight];
    [self.contentView addSubview:self.labelRightSub];
    
    
    [self.contentView addSubview:self.lineVert];

    self.labelLeft.font = self.labelLeftSub.font = self.labelRight.font = self.labelRightSub.font;
    self.labelLeftSub.textAlignment = NSTextAlignmentRight;
    self.labelRightSub.textAlignment = NSTextAlignmentRight;

    self.labelLeftSub.adjustsFontSizeToFitWidth = YES;
    self.labelRightSub.adjustsFontSizeToFitWidth = YES;

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字+|+文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    CGSize labRigthSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:kScreen_width];
    
    if (![self.labelLeft.text validObject]) self.labelLeft.hidden = YES;;
    if (![self.labelRight.text validObject]) self.labelRight.hidden = YES;
    
    //控件
    CGFloat XGap = kX_GAP;
    CGFloat YGap = kY_GAP;
    CGFloat padding = 10;
    
    CGFloat lableLeftH = kH_LABEL;
    CGFloat labelSubWidth = CGRectGetWidth(self.contentView.frame)/2.0 - labLeftSize.width - XGap*2 - padding;
    CGFloat labelSubWidthRight = CGRectGetWidth(self.contentView.frame)/2.0 - labRigthSize.width - XGap*2 - padding;

    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    self.labelLeftSub.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame)+padding, CGRectGetMinY(self.labelLeft.frame), labelSubWidth, lableLeftH);
    
    self.labelRight.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)/2.0+kX_GAP, CGRectGetMinY(self.labelLeft.frame), labRigthSize.width, lableLeftH);
    self.labelRightSub.frame = CGRectMake(CGRectGetMaxX(self.labelRight.frame)+padding, CGRectGetMinY(self.labelLeft.frame), labelSubWidthRight, lableLeftH);

    self.lineVert.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)/2.0, YGap, 1, CGRectGetHeight(self.contentView.frame) - kY_GAP*2);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UIView *)lineVert{
    if (!_lineVert) {
        _lineVert = [UIView createLineWithRect:CGRectMake(0, 0, kScreen_width, kH_LINE_VIEW) isDash:NO hidden:NO tag:kTAG_VIEW+11];
        _lineVert.backgroundColor = kC_LineColor;

    }
    return _lineVert;
}

-(UILabel *)labelRightSub{
    if (!_labelRightSub) {
        _labelRightSub = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+5 patternType:@"2" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentRight];
    }
    return _labelRightSub;
}

@end
