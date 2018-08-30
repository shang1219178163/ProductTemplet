//
//  WHKTableViewSeventeenCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/23.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSeventeenCell.h"

@interface WHKTableViewSeventeenCell ()

@end

@implementation WHKTableViewSeventeenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字1
    //图片2
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.labelLeft];
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //控件1
    CGRect labelLeftRect = CGRectMake(kX_GAP, kY_GAP/2, CGRectGetWidth(self.contentView.frame) - 2 * kX_GAP, kH_LABEL);
    //控件2
    CGRect imgViewRect = CGRectMake(kX_GAP, CGRectGetMaxY(labelLeftRect), CGRectGetWidth(self.contentView.frame) - 2 * kX_GAP,CGRectGetHeight(self.contentView.frame) - CGRectGetMaxY(labelLeftRect) - kY_GAP/2 * 2);
    
    self.labelLeft.frame = labelLeftRect;
    self.imgViewLeft.frame = imgViewRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
