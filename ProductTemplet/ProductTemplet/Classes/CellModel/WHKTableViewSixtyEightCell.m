//
//  WHKTableViewSixtyEightCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/10.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSixtyEightCell.h"

@interface WHKTableViewSixtyEightCell ()

@end

@implementation WHKTableViewSixtyEightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字+文字+文字+文字
    [self.contentView addSubview:self.labelOne];
    [self.contentView addSubview:self.labelTwo];
    [self.contentView addSubview:self.labelThree];
    [self.contentView addSubview:self.labelFour];
    [self.contentView addSubview:self.labelFive];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //    CGSize labOneSize = [self sizeWithText:self.labelOne.text font:self.labelOne.font width:kScreen_width];
    
    //文字+文字
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL_SMALL*2)/2.0;
    CGFloat padding = kPadding;
    NSInteger itemCount = 5;
    CGFloat width = (kScreen_width - (itemCount-1)*padding - kX_GAP*2)/itemCount;
    width = floorf(width);
    
    self.labelOne.frame     = CGRectMake(kX_GAP, YGap, width, kH_LABEL_SMALL*2);
    self.labelTwo.frame     = CGRectMake(CGRectGetMaxX(self.labelOne.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelThree.frame   = CGRectMake(CGRectGetMaxX(self.labelTwo.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelFour.frame    = CGRectMake(CGRectGetMaxX(self.labelThree.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelFive.frame    = CGRectMake(CGRectGetMaxX(self.labelFour.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UILabel *)labelOne{
    if (!_labelOne) {
        _labelOne = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"0" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labelOne;
}

-(UILabel *)labelTwo{
    if (!_labelTwo) {
        _labelTwo = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 patternType:@"0" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labelTwo;
}

-(UILabel *)labelThree{
    if (!_labelThree) {
        _labelThree = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 patternType:@"0" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labelThree;
}
-(UILabel *)labelFour{
    if (!_labelFour) {
        _labelFour = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+3 patternType:@"0" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labelFour;
}
-(UILabel *)labelFive{
    if (!_labelFive) {
        _labelFive = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+4 patternType:@"0" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labelFive;
}

@end
