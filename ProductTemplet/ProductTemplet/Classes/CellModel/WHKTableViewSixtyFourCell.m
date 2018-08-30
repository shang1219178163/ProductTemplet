//
//  WHKTableViewSixtyFourCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/8.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSixtyFourCell.h"

@interface WHKTableViewSixtyFourCell ()

@end

@implementation WHKTableViewSixtyFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片+文字+图片
    //   +文字
    [self.contentView addSubview:self.imgViewRight];
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //图片+文字+文字+图片
    if (CGSizeEqualToSize(self.imgViewLeftSize, CGSizeZero)){
        if (self.imgViewLeft.image) self.imgViewLeftSize = CGSizeMake(self.imgViewLeft.image.size.width/2.0, self.imgViewLeft.image.size.height/2.0);
        //        self.imgViewLeftSize = CGSizeMake(20, 20);
    }
    
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - self.imgViewLeftSize.height)/2.0;
    CGFloat padding = kPadding;
    
    
    CGSize imgViewRightSize = CGSizeMake(25, 25);
    //控件1
    CGRect imgViewLeftRect = CGRectMake(YGap, YGap, self.imgViewLeftSize.width, self.imgViewLeftSize.height);
    //控件4
    CGRect imgViewRightRect = CGRectMake(kScreen_width - imgViewRightSize.width -  kX_GAP, CGRectGetMidY(imgViewLeftRect) - imgViewRightSize.height/2.0, imgViewRightSize.width, imgViewRightSize.height);
   
    //控件2
    CGRect titleRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, kY_GAP, CGRectGetMinX(imgViewRightRect)- CGRectGetMaxX(imgViewLeftRect) - padding*2, kH_LABEL);
    
    //控件3
    CGRect titleSubRect = CGRectMake(CGRectGetMinX(titleRect), CGRectGetMaxY(titleRect), CGRectGetWidth(titleRect), kH_LABEL_SMALL);
    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.imgViewRight.frame = imgViewRightRect;
    self.labelLeft.frame = titleRect;
    self.labelLeftSub.frame = titleSubRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz



@end
