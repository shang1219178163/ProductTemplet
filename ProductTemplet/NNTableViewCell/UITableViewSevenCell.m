//
//  UITableViewSevenCell.m
//  
//
//  Created by BIN on 2017/8/18.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewSevenCell.h"
#import <NNGloble/NNGloble.h>
#import "NSObject+Helper.h"
#import "UIView+AddView.h"
#import "UILabel+Helper.h"

#import <Masonry/Masonry.h>

@interface UITableViewSevenCell ()

@end

@implementation UITableViewSevenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /**
     文字+文字+文字
     文字+文字+文字
     */
    [self.contentView addSubview:self.labOne];
    [self.contentView addSubview:self.labTwo];
    [self.contentView addSubview:self.labThree];
    
    [self.contentView addSubview:self.labOneSub];
    [self.contentView addSubview:self.labTwoSub];
    [self.contentView addSubview:self.labThreeSub];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat xGap = 10;
    CGFloat width = (CGRectGetWidth(self.contentView.frame) - xGap*4)/3.0;
    @weakify(self);
    [self.labOne makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(kY_GAP);
        make.left.equalTo(self.labOne.superview).offset(xGap);
        make.width.equalTo(width);
        make.height.equalTo(kH_LABEL_SMALL);
    }];
    
    [self.labTwo makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.labOne);
        make.left.equalTo(self.labOne.right).offset(xGap);
        make.width.equalTo(width);
        make.height.equalTo(kH_LABEL_SMALL);
    }];
 
    [self.labThree makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.labOne);
        make.left.equalTo(self.labTwo.right).offset(xGap);
        make.width.equalTo(width);
        make.height.equalTo(kH_LABEL_SMALL);
    }];
    
    [self.labOneSub makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.labOne.bottom).offset(kPadding);
        make.left.equalTo(self.labOneSub.superview).offset(xGap);
        make.width.equalTo(width);
        make.height.equalTo(kH_LABEL_SMALL);
    }];
    
    [self.labTwoSub makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.labOneSub);
        make.left.equalTo(self.labOneSub.right).offset(xGap);
        make.width.equalTo(width);
        make.height.equalTo(kH_LABEL_SMALL);
    }];
    
    [self.labThreeSub makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.labOneSub);
        make.left.equalTo(self.labTwoSub.right).offset(xGap);
        make.width.equalTo(width);
        make.height.equalTo(kH_LABEL_SMALL);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UILabel *)labOne{
    if (!_labOne) {
        _labOne = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labOne.textAlignment = NSTextAlignmentCenter;
    }
    return _labOne;
}

-(UILabel *)labTwo{
    if (!_labTwo) {
        _labTwo = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labTwo.textAlignment = NSTextAlignmentCenter;

    }
    return _labTwo;
}

-(UILabel *)labThree{
    if (!_labThree) {
        _labThree = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labThree.textAlignment = NSTextAlignmentCenter;

    }
    return _labThree;
}

-(UILabel *)labOneSub{
    if (!_labOneSub) {
        _labOneSub = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labOneSub.textAlignment = NSTextAlignmentCenter;

    }
    return _labOneSub;
}

-(UILabel *)labTwoSub{
    if (!_labTwoSub) {
        _labTwoSub = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labTwoSub.textAlignment = NSTextAlignmentCenter;

    }
    return _labTwoSub;
}

-(UILabel *)labThreeSub{
    if (!_labThreeSub) {
        _labThreeSub = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labThreeSub.textAlignment = NSTextAlignmentCenter;

    }
    return _labThreeSub;
}

@end
