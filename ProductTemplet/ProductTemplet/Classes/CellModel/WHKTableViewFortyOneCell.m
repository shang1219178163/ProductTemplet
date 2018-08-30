//
//  WHKTableViewFortyOneCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/11/24.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFortyOneCell.h"

@interface WHKTableViewFortyOneCell ()


@end

@implementation WHKTableViewFortyOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /*
     ----------------------------
     图片+文字
     图片+文字
     ----------------------------
     */
    
    self.imgLabViewOne = [BINImgLabelView labWithImage:nil imageSize:CGSizeMake(15, 15)];
    self.imgLabViewOne.labelTitle.font = [UIFont systemFontOfSize:KFZ_Third];
    self.imgLabViewOne.labelTitle.numberOfLines = 1;
    self.imgLabViewOne.labelTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.imgLabViewTwo = [BINImgLabelView labWithImage:nil imageSize:CGSizeMake(15, 20)];
    self.imgLabViewTwo.labelTitle.font = [UIFont systemFontOfSize:KFZ_Third];
    self.imgLabViewTwo.labelTitle.numberOfLines = 1;
    self.imgLabViewTwo.labelTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    [self.contentView addSubview:self.imgLabViewOne];
    [self.contentView addSubview:self.imgLabViewTwo];
    
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //
    CGRect imgLabViewRectOne = CGRectMake(kX_GAP, kY_GAP, kScreen_width - kX_GAP*2, kH_LABEL);
    CGRect imgLabViewRectTwo = CGRectMake(kX_GAP, CGRectGetMaxY(imgLabViewRectOne), CGRectGetWidth(imgLabViewRectOne), kH_LABEL);

    self.imgLabViewOne.frame = imgLabViewRectOne;
    self.imgLabViewTwo.frame = imgLabViewRectTwo;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
