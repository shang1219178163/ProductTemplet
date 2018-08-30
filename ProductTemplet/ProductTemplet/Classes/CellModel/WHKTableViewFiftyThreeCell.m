//
//  WHKTableViewFiftyThreeCell.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/26.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFiftyThreeCell.h"

@interface WHKTableViewFiftyThreeCell ()


@end

@implementation WHKTableViewFiftyThreeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+文字(textField)+图片
//    [self.contentView addSubview:self.labelLeft];
//    [self.contentView addSubview:self.textField];
//    [self.contentView addSubview:self.imgViewRight];
//    
//
//    self.textField.placeholder = @"请选择";
//    self.textField.textAlignment = NSTextAlignmentCenter;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    

//    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
//    if (self.labelLeft.attributedText) {
//        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:kScreen_width];
//    }
//
//    CGFloat XGap = kX_GAP;
////    CGFloat YGap = kY_GAP;
//
//    CGFloat textFieldH = 30;
//    CGFloat lableLeftH = textFieldH;
//
//    CGSize imgViewRightSize = CGSizeMake(CGRectGetHeight(self.contentView.frame) - kPadding*2, CGRectGetHeight(self.contentView.frame) - kPadding*2);
//    self.imgViewRight.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - imgViewRightSize.width - XGap, kPadding, imgViewRightSize.width, imgViewRightSize.height);
//
//    //控件1
//    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
//    //控件2
//    self.textField.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + kPadding, CGRectGetMidY(self.contentView.frame) - textFieldH/2.0, CGRectGetMinX(self.imgViewRight.frame) - CGRectGetMaxX(self.labelLeft.frame) - kPadding*2, textFieldH);
//
//    if (self.imgViewRight.hidden == YES) {
//        CGRect rect = self.textField.frame;
//        rect.size.width += CGRectGetWidth(self.imgViewRight.frame) + kPadding;
//        self.textField.frame = rect;
//
//    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz



@end
