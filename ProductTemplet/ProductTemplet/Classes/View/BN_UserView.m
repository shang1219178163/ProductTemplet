
//
//  BN_UserView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/10.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_UserView.h"

@implementation BN_UserView

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
    
    CGSize leftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    CGSize leftMarkSize = [self sizeWithText:self.labelLeftMark.text font:self.labelLeftMark.font width:kScreen_width];
    CGSize leftSubSize = [self sizeWithText:self.labelLeftSub.text font:self.labelLeftSub.font width:kScreen_width];
    CGSize leftSubMarkSize = [self sizeWithText:self.labelLeftSubMark.text font:self.labelLeftSubMark.font width:kScreen_width];
    
    CGSize rightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:kScreen_width];

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
    CGRect imgViewRightRect = CGRectMake(CGRectGetWidth(self.frame) - arrowSize.width - kXY_GAP, (CGRectGetHeight(self.frame) - arrowSize.height)/2.0, arrowSize.width, arrowSize.height);
    
    
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
        _imgViewLeft = [UIImageView createImageViewWithRect:CGRectZero image:nil tag:kTAG_IMGVIEW patternType:@"0"];
        
    }
    return _imgViewLeft;
    
}

-(UIImageView *)imgViewRight{
    if (!_imgViewRight) {
        _imgViewRight = [UIImageView createImageViewWithRect:CGRectZero image:kIMAGE_arrowRight tag:kTAG_IMGVIEW+1 patternType:@"0"];
//        _imgViewRight.hidden = YES;
        
    }
    return _imgViewRight;
    
}

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    }
    return _labelLeft;
}

-(UILabel *)labelLeftMark{
    if (!_labelLeftMark) {
        _labelLeftMark = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    }
    return _labelLeftMark;
}

-(UILabel *)labelLeftSub{
    if (!_labelLeftSub) {
        _labelLeftSub = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    }
    return _labelLeftSub;
}

-(UILabel *)labelLeftSubMark{
    if (!_labelLeftSubMark) {
        _labelLeftSubMark = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+3 patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    }
    return _labelLeftSubMark;
}

-(UILabel *)labelRight{
    if (!_labelRight) {
        _labelRight = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+4 patternType:@"2" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentRight];
    }
    return _labelRight;
}




@end
