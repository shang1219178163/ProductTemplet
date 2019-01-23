//
//  UITableViewStepCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewStepCell.h"
#import "BN_Globle.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@interface UITableViewStepCell ()
 
@end

@implementation UITableViewStepCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+btn
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.numberBtnLeft];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
   
    //文字+btn
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }
    
    //控件
    CGFloat XGap = kX_GAP;
    //    CGFloat YGap = kY_GAP;
    //    CGFloat padding = 10;
    CGFloat height = 35;
    
    CGFloat lableLeftH = kH_LABEL;
    CGSize numBtnSize = CGSizeMake(130, height);
    
    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    //    self.numberBtnLeft.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame)+50, CGRectGetMidY(self.contentView.frame) - height/2.0, numBtnSize.width, numBtnSize.height);
    
    self.numberBtnLeft.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - numBtnSize.width -60, CGRectGetMidY(self.contentView.frame) - height/2.0, numBtnSize.width, numBtnSize.height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(PPNumberButton *)numberBtnLeft{
    if (!_numberBtnLeft) {
        _numberBtnLeft = [PPNumberButton numberButtonWithFrame:CGRectZero];
        //        _numberBtnLeft.delegate = self;
        // 初始化时隐藏减按钮
        //        _numberBtnLeft.decreaseHide = YES;
        _numberBtnLeft.increaseImage = [UIImage imageNamed:kIMG_elemetInc];
        _numberBtnLeft.decreaseImage = [UIImage imageNamed:kIMG_elemetDec];

        _numberBtnLeft.shakeAnimation = YES;
        _numberBtnLeft.tag = kTAG_BTN;
    }
    return _numberBtnLeft;
}


@end
