
//
//  WHKTableViewFourtyNineCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/7/10.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFourtyNineCell.h"

@implementation WHKTableViewFourtyNineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    //文字+text+text+text
    [self.contentView addSubview:self.labTitle];
    [self.contentView addSubview:self.labLeft];
    [self.contentView addSubview:self.labCenter];
    [self.contentView addSubview:self.labRight];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    
    CGSize labLeftSize = [self sizeWithText:self.labTitle.text font:self.labTitle.font width:kScreen_width];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labTitle.attributedText font:self.labTitle.font width:kScreen_width];
    }
    CGFloat XGap = kX_GAP*0.5;
    //    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    CGFloat lableLeftH = CGRectGetHeight(self.contentView.bounds) - XGap*2;
    CGFloat textWidth = (CGRectGetWidth(self.contentView.frame) - labLeftSize.width - XGap*2 - padding*3)/3.0;
    
    self.labTitle.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2, labLeftSize.width, lableLeftH);
    self.labLeft.frame = CGRectMake(CGRectGetMaxX(self.labTitle.frame)+padding, CGRectGetMinY(self.labTitle.frame), textWidth, lableLeftH);
    self.labCenter.frame = CGRectMake(CGRectGetMaxX(self.labLeft.frame)+padding, CGRectGetMinY(self.labLeft.frame), textWidth, lableLeftH);
    self.labRight.frame = CGRectMake(CGRectGetMaxX(self.labCenter.frame)+padding, CGRectGetMinY(self.labCenter.frame), textWidth, lableLeftH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UILabel *)labTitle{
    if (!_labTitle) {
        _labTitle = [UIView createLabelWithRect:CGRectZero text:@"" textColor:[UIColor blackColor] tag:kTAG_LABEL patternType:@"2" font:15 backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labTitle;
}

-(UILabel *)labLeft{
    if (!_labLeft) {
        _labLeft = [UIView createLabelWithRect:CGRectZero text:@"" textColor:[UIColor blackColor] tag:kTAG_LABEL+1 patternType:@"2" font:15 backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labLeft;
}

-(UILabel *)labCenter{
    if (!_labCenter) {
        _labCenter = [UIView createLabelWithRect:CGRectZero text:@"" textColor:[UIColor blackColor] tag:kTAG_LABEL+2 patternType:@"2" font:15 backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labCenter;
}

-(UILabel *)labRight{
    if (!_labRight) {
        _labRight = [UIView createLabelWithRect:CGRectZero text:@"" textColor:[UIColor blackColor] tag:kTAG_LABEL+2 patternType:@"0" font:14 backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labRight;
}

@end

