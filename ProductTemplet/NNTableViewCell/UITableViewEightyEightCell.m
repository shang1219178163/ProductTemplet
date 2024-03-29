//
//  UITableViewEightyEightCell.m
//  
//
//  Created by BIN on 2018/6/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewEightyEightCell.h"
#import <NNGloble/NNGloble.h>
#import "NSObject+Helper.h"
  
@implementation UITableViewEightyEightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+btn+文字+btn
    //控件2
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelRight];
    
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.numberBtnRight];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+textField+文字+btn
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize labRigthSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
    
    //控件
    CGFloat XGap = kX_GAP;
    //    CGFloat YGap = kY_GAP;
    CGFloat padding = 10;
    
    CGFloat lableLeftH = kH_LABEL;
    CGRect titleRect = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    
    CGRect btnLeftRect = CGRectMake(CGRectGetMaxX(titleRect)+padding, CGRectGetMinY(titleRect), CGRectGetWidth(self.contentView.frame)/2.0 - CGRectGetWidth(titleRect) - padding*2 - XGap*2, lableLeftH);
    
    CGRect titleSubRect = CGRectMake(CGRectGetWidth(self.contentView.frame)/2.0 + padding, CGRectGetMinY(titleRect),labRigthSize.width, lableLeftH);
    CGRect btnRightRect = CGRectMake(CGRectGetMaxX(titleSubRect)+padding, CGRectGetMinY(titleRect), CGRectGetWidth(btnLeftRect), CGRectGetHeight(btnLeftRect));
    
    self.labelLeft.frame = titleRect;
    self.labelRight.frame = titleSubRect;
    self.textField.frame = btnLeftRect;
    self.numberBtnRight.frame = btnRightRect;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(PPNumberButton *)numberBtnRight{
    if (!_numberBtnRight) {
        _numberBtnRight = [PPNumberButton numberButtonWithFrame:CGRectZero];
        //        _numberBtnLeft.delegate = self;
        // 初始化时隐藏减按钮
        //        _numberBtnRight.decreaseHide = YES;
        _numberBtnRight.increaseImage = UIImage.img_elemet_increase;
        _numberBtnRight.decreaseImage = UIImage.img_elemet_decrease;
        
        _numberBtnRight.tag = kTAG_BTN+1;
        
    }
    return _numberBtnRight;
}



@end
