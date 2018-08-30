//
//  WHKTableViewTwentyCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/25.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewTwentyCell.h"

@interface WHKTableViewTwentyCell ()


@end

@implementation WHKTableViewTwentyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     图片+文字
     图片+文字
     图片+文字
    */
    self.iconLabViewOne = [[BINIconLabelView alloc]init];
    self.iconLabViewTwo = [[BINIconLabelView alloc]init];
    self.iconLabViewThree = [[BINIconLabelView alloc]init];
    
    [self.contentView addSubview:self.iconLabViewOne];
    [self.contentView addSubview:self.iconLabViewTwo];
    [self.contentView addSubview:self.iconLabViewThree];
    
    [self.contentView addSubview:self.imgViewRight];
    
 
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    /*图片+文字
     图片+文字          箭头
     图片+文字
     */
    
    CGFloat XYGap = kY_GAP;
    //控件>
    CGSize imgViewRightSize = CGSizeMake(25, 25);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  XYGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
    self.imgViewRight.frame = imgViewRightRect;

    
    CGRect iconLabViewRectOne = CGRectMake(XYGap, XYGap, CGRectGetMinX(imgViewRightRect) - XYGap, 20);
    CGRect iconLabViewRectTwo = CGRectMake(XYGap, CGRectGetMaxY(iconLabViewRectOne), CGRectGetWidth(iconLabViewRectOne), CGRectGetHeight(iconLabViewRectOne));
    CGRect iconLabViewRectThree = CGRectMake(XYGap, CGRectGetMaxY(iconLabViewRectTwo), CGRectGetWidth(iconLabViewRectOne), CGRectGetHeight(iconLabViewRectOne));
    
    self.iconLabViewOne.frame = iconLabViewRectOne;
    self.iconLabViewTwo.frame = iconLabViewRectTwo;
    self.iconLabViewThree.frame = iconLabViewRectThree;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
