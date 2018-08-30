//
//  WHKTableViewTwentyFourCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewTwentyFourCell.h"

@interface WHKTableViewTwentyFourCell ()


@end

@implementation WHKTableViewTwentyFourCell

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
//    self.imgLabView = [[BINImgLabelView alloc]init];
    self.imgLabView = [BINImgLabelView labWithImage:nil imageSize:CGSizeMake(15*2, 15)];

    [self.contentView addSubview:self.iconLabViewOne];
    [self.contentView addSubview:self.iconLabViewTwo];
    [self.contentView addSubview:self.imgLabView];
    
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
    CGSize imgViewRightSize = CGSizeMake(80, 55);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width -  XYGap, (CGRectGetHeight(self.contentView.frame) - imgViewRightSize.height)/2.0, imgViewRightSize.width, imgViewRightSize.height);
    self.imgViewRight.frame = imgViewRightRect;
    
    
    CGRect iconLabViewRectOne = CGRectMake(XYGap, XYGap, CGRectGetMinX(imgViewRightRect) - XYGap, 20);
    CGRect iconLabViewRectTwo = CGRectMake(XYGap, CGRectGetMaxY(iconLabViewRectOne), CGRectGetWidth(iconLabViewRectOne), CGRectGetHeight(iconLabViewRectOne));
    CGRect imgLabViewRect = CGRectMake(XYGap, CGRectGetMaxY(iconLabViewRectTwo), CGRectGetWidth(iconLabViewRectOne),15);
    
    if (self.imgViewRight.hidden == YES) {
        iconLabViewRectOne = CGRectMake(XYGap, XYGap, CGRectGetWidth(self.contentView.frame) - XYGap*2, 20);
        iconLabViewRectTwo = CGRectMake(XYGap, CGRectGetMaxY(iconLabViewRectOne), CGRectGetWidth(self.contentView.frame) - XYGap*2, CGRectGetHeight(iconLabViewRectOne));
        imgLabViewRect = CGRectMake(XYGap, CGRectGetMaxY(iconLabViewRectTwo), CGRectGetWidth(self.contentView.frame) - XYGap*2,15);
        
    }
    
    self.iconLabViewOne.frame = iconLabViewRectOne;
    self.iconLabViewTwo.frame = iconLabViewRectTwo;
    self.imgLabView.frame = imgLabViewRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
