//
//  WHKTableViewSenventyFiveCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/26.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSenventyFiveCell.h"

#import <ZYCornerRadius/UIImageView+CornerRadius.h>

@implementation WHKTableViewSenventyFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片1+文字2+图标3+图片6
    //    文字4
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.imgViewRight];
    
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    [self.contentView addSubview:self.iCon];
    
    
    
    [self.imgViewLeft zy_cornerRadiusRoundingRect];
    [self.imgViewLeft zy_attachBorderWidth:1.5 color:kC_ThemeCOLOR];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    CGSize labSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:kScreen_width];
    
    CGFloat h_Lab = kH_LABEL;
    CGFloat h_ImgView = self.height - 15*2;
    CGSize imgViewSize = CGSizeMake(h_ImgView, h_ImgView);
    CGFloat YGap = 15;
    //图片+文字+图标+箭头
    //    文字
    //控件6
    CGSize imgViewRightSize = CGSizeMake(25, 25);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  YGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, imgViewSize.width, imgViewSize.height);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, YGap, labLeftSize.width, h_Lab);
    //控件3
    
    CGFloat maxWidth = CGRectGetMinX(imgViewRightRect) - CGRectGetMinX(labelLeftRect);
    CGFloat width = labSubSize.width <= maxWidth ? labSubSize.width : maxWidth;
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMinX(labelLeftRect), CGRectGetMaxY(labelLeftRect), width, h_Lab);

    //控件4
    CGRect iconRect = CGRectMake(CGRectGetMaxX(labelLeftRect) + kPadding, CGRectGetMinY(labelLeftRect), h_Lab, h_Lab);
   
    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    self.iCon.frame = iconRect;
    
    self.imgViewRight.frame = imgViewRightRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UIImageView *)iCon{
    if (!_iCon) {
        _iCon = [UIImageView createImageViewWithRect:CGRectZero image:@"icon_company.png" tag:kTAG_VIEW+2 patternType:@"0"];
    }
    return _iCon;
}


@end
