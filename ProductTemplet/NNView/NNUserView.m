
//
//  NNUserView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/10.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "NNUserView.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"

@implementation NNUserView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imgViewLeft];
        [self addSubview:self.imgViewRight];
        
        [self addSubview:self.labelLeft];
        [self addSubview:self.labelLeftMark];
        
        [self addSubview:self.labelLeftSub];
        [self addSubview:self.labelLeftSubMark];

        [self addSubview:self.labelRight];
        
    }
    return self;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize leftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    CGSize leftMarkSize = [self sizeWithText:self.labelLeftMark.text font:self.labelLeftMark.font width:CGFLOAT_MAX];
    CGSize leftSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:CGFLOAT_MAX];
    CGSize leftSubMarkSize = [self sizeWithText:self.labelLeftSubMark.text font:self.labelLeftSubMark.font width:CGFLOAT_MAX];
    
    CGSize rightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];

    CGFloat heightLab = 20;
    CGFloat paddingY = (CGRectGetHeight(self.frame) - heightLab*2)/3.0;
    CGFloat heightImgView = heightLab*2 + paddingY;

    /*
     图片1+文字2+文字3   + 文字6+箭头7
          文字4+文字5
     */
    
    CGSize imgViewSize = CGSizeMake(heightImgView, heightImgView);
    CGFloat YGap = 0;
    CGFloat XGap = 0;

    //控件1
    CGRect imgViewLeftRect = CGRectMake(XGap, YGap + paddingY, imgViewSize.width, imgViewSize.height);
    //控件2
    CGRect labelLeftRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, YGap + paddingY, leftSize.width, heightLab);
    //控件3
    CGRect labelLeftMarkRect = CGRectMake(CGRectGetMaxX(labelLeftRect) + kPadding, CGRectGetMinY(labelLeftRect), leftMarkSize.width, heightLab);
    //控件4
    CGRect labelLeftSubRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + kPadding, CGRectGetMaxY(labelLeftRect) + paddingY, leftSubSize.width, heightLab);//手机号11号字体长度78
    //控件5
    CGRect labelLeftSubMarkRect = CGRectMake(CGRectGetMaxX(labelLeftSubRect) + kPadding, CGRectGetMinY(labelLeftSubRect), leftSubMarkSize.width, heightLab);
    //控件6
    CGSize arrowSize = CGSizeMake(25, 25);
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.frame) - arrowSize.width - kX_GAP, (CGRectGetHeight(self.frame) - arrowSize.height)/2.0, arrowSize.width, arrowSize.height);
    
    
    CGRect labelRightRect = CGRectMake(CGRectGetMinX(imgViewRightRect) - kPadding - rightSize.width, CGRectGetMinY(imgViewRightRect), rightSize.width, arrowSize.height);
    
    self.imgViewLeft.frame = imgViewLeftRect;
    self.labelLeft.frame = labelLeftRect;
    self.labelLeftMark.frame = labelLeftMarkRect;

    self.labelLeftSub.frame = labelLeftSubRect;
    self.labelLeftSubMark.frame = labelLeftSubMarkRect;
    
    self.imgViewRight.frame = imgViewRightRect;
    self.labelRight.frame = labelRightRect;
}


#pragma mark - -

-(UIImageView *)imgViewLeft{
    if (!_imgViewLeft) {
        _imgViewLeft = [UIImageView createRect:CGRectZero];
        
    }
    return _imgViewLeft;
}

-(UIImageView *)imgViewRight{
    if (!_imgViewRight) {
        _imgViewRight = [UIImageView createRect:CGRectZero];
        _imgViewRight.image = UIImage.img_arrowRight_gray;
//        _imgViewRight.hidden = YES;
        
    }
    return _imgViewRight;
}

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labelLeft.textAlignment = NSTextAlignmentLeft;
    }
    return _labelLeft;
}

-(UILabel *)labelLeftMark{
    if (!_labelLeftMark) {
        _labelLeftMark = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labelLeftMark.textAlignment = NSTextAlignmentLeft;
    }
    return _labelLeftMark;
}

-(UILabel *)labelLeftSub{
    if (!_labelLeftSub) {
        _labelLeftSub = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labelLeftSub.textAlignment = NSTextAlignmentLeft;
    }
    return _labelLeftSub;
}

-(UILabel *)labelLeftSubMark{
    if (!_labelLeftSubMark) {
        _labelLeftSubMark = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labelLeftSubMark.textAlignment = NSTextAlignmentLeft;
    }
    return _labelLeftSubMark;
}

-(UILabel *)labelRight{
    if (!_labelRight) {
        _labelRight = [UILabel createRect:CGRectZero type:NNLabelTypeFitWidth];
        _labelRight.textAlignment = NSTextAlignmentRight;
    }
    return _labelRight;
}




@end
