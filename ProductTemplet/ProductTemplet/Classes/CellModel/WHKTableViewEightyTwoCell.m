//
//  WHKTableViewEightyTwoCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/11.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewEightyTwoCell.h"

@implementation WHKTableViewEightyTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    
    
    [self.contentView addSubview:self.userView];
    [self.contentView addSubview:self.labelLeft];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.userView.frame = CGRectMake(kXY_GAP, kY_GAP, CGRectGetWidth(self.contentView.frame) - kXY_GAP*2, kH_userView);
    
    self.labelLeft.frame = CGRectMake(kXY_GAP, CGRectGetMaxY(self.userView.frame) + kY_GAP, CGRectGetWidth(self.userView.frame), CGRectGetHeight(self.contentView.frame) - CGRectGetMaxY(self.userView.frame) - kY_GAP);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BN_UserView *)userView{
    if (!_userView) {
        _userView = [[BN_UserView alloc]initWithFrame:CGRectZero];
    }
    return _userView;
    
}

@end
