
//
//  WHKTableViewSixtySixCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSixtySixCell.h"

@interface WHKTableViewSixtySixCell ()

@end

@implementation WHKTableViewSixtySixCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelRight];
    
    
    [self.contentView addSubview:self.lineVert];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    //    CGFloat padding = kPadding;
 
    self.labelLeft.frame = CGRectMake(kX_GAP, YGap, CGRectGetWidth(self.contentView.frame)/2.0 - kX_GAP*2, kH_LABEL);;
    self.labelRight.frame = CGRectMake(CGRectGetWidth(self.contentView.frame)/2.0 + kX_GAP, YGap, CGRectGetWidth(self.labelLeft.frame), kH_LABEL);;
    
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




@end
