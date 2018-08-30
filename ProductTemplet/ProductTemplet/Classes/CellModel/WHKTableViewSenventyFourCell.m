//
//  WHKTableViewSenventyFourCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/25.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSenventyFourCell.h"

@implementation WHKTableViewSenventyFourCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字(icon)+文字(icon)+文字(icon)+文字(icon)
    
    [self.contentView addSubview:self.labViewOne];
    [self.contentView addSubview:self.labViewTwo];
    
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL)/2.0;
    
    CGFloat padding = kPadding;
    NSInteger itemCount = 4;
    CGFloat width = (kScreen_width - (itemCount-1)*padding - kX_GAP*2)/itemCount;
    width = floorf(width);
    
    
    self.labViewOne.frame =  CGRectMake(kX_GAP, YGap, width, kH_LABEL);
    self.labViewTwo.frame = CGRectMake(CGRectGetMaxX(self.labViewOne.frame)+padding + (width + padding), YGap, width, kH_LABEL);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BN_LabView *)labViewOne{
    if (!_labViewOne) {
        _labViewOne = ({
            BN_LabView * labView = [[BN_LabView alloc]initWithFrame:CGRectZero];
            labView.padding = 0.0;
            labView.patternType = @3;
            
            labView;
        });
    }
    return _labViewOne;
}

-(BN_LabView *)labViewTwo{
    if (!_labViewTwo) {
        _labViewTwo = ({
            BN_LabView * labView = [[BN_LabView alloc]initWithFrame:CGRectZero];
            labView.padding = 0.0;
            labView.patternType = @3;
            
            labView;
        });
        
    }
    return _labViewTwo;
}

@end
