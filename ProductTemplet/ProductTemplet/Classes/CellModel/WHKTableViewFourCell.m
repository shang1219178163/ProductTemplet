//
//  WHKTableViewFourCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/17.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFourCell.h"

@interface WHKTableViewFourCell ()

@end

@implementation WHKTableViewFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字1
    //文字2
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //控件1
    CGRect labelLeftRect = CGRectMake(kX_GAP, kY_GAP/2, kScreen_width - 2*kX_GAP, kH_LABEL);
    //控件2
    CGRect labelLeftSubRect = CGRectMake(kX_GAP, CGRectGetMaxY(labelLeftRect), CGRectGetWidth(self.contentView.frame) - 2 * kX_GAP,CGRectGetHeight(self.contentView.frame) - CGRectGetMaxY(labelLeftRect) - kY_GAP/2);

    self.labelLeft.frame = labelLeftRect;
    self.labelLeftSub.frame = labelLeftSubRect;
    
}

@end
