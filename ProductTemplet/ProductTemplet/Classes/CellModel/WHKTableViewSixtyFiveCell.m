//
//  WHKTableViewSixtyFiveCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/8.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSixtyFiveCell.h"

@interface WHKTableViewSixtyFiveCell ()

@end

@implementation WHKTableViewSixtyFiveCell

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
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    CGFloat padding = kPadding;
    
    CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:kScreen_width];
    
    //控件1
    CGRect titleSubRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - kX_GAP - labRightSize.width, YGap, labRightSize.width, kH_LABEL);
    //控件2
    CGRect titleRect = CGRectMake(kX_GAP, CGRectGetMinY(titleSubRect), CGRectGetMinX(titleSubRect) - kX_GAP - padding*2, kH_LABEL);
    
    self.labelLeft.frame = titleRect;
    self.labelRight.frame = titleSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz


@end
