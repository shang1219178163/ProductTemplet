//
//  WHKTableViewTwentySevenCell.m
//  HuiZhuBang
//
//  Created by BIN on 2017/9/27.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewTwentySevenCell.h"

@interface WHKTableViewTwentySevenCell ()

@end

@implementation WHKTableViewTwentySevenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    /**
     ---------------------------
     图像+价格          |  call
        +车型          |
     姓名+星星+信任值    | 立即确认
     ---------------------------
     */
    //议价列表
    CGSize imgSize = CGSizeMake(55, 55);
    CGRect imgViewRect = CGRectMake(kX_GAP, kY_GAP, imgSize.width, imgSize.height);
    UIImageView * imgView = [UIImageView createImageViewWithRect:imgViewRect image:kIMAGE_default_User_H tag:kTAG_IMGVIEW patternType:@"1"];
    [self.contentView addSubview:imgView];
    
    UILabel * labelName = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"1" font:KFZ_Third backgroudColor:nil alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:labelName];
    
    UILabel * labelPrice = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 patternType:@"2" font:KFZ_Second backgroudColor:nil alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:labelPrice];
    
    BINImgLabelView * imgLabelView = [BINImgLabelView labWithImage:nil imageSize:CGSizeMake(15*2, 15)];
    [self.contentView addSubview:imgLabelView];

    CGSize starRateViewSize = CGSizeMake(15*5, 15);
    CGFloat starYGap = (20 - starRateViewSize.height)/2.0;
    
    CGRect starViewRect = CGRectMake(0, CGRectGetMaxY(self.imgViewLeft.frame) + starYGap , starRateViewSize.width, starRateViewSize.height);
    XHStarRateView * starRateView = [UIView getStarViewRect:starViewRect rateStyle:@"2" currentScore:60];
    [self.contentView addSubview:starRateView];

    UILabel * labelIntegrityLevel = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 patternType:@"4" font:KFZ_Fouth backgroudColor:nil alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:labelIntegrityLevel];
    
    UIButton * btnCall = [UIView createBtnWithRect:CGRectZero title:@"" font:KFZ_Second image:nil tag:kTAG_BTN patternType:@"3" target:nil aSelector:nil];
    [self.contentView addSubview:btnCall];
    
    UIButton * btnConfirm = [UIView createBtnWithRect:CGRectZero title:@"" font:KFZ_Second image:nil tag:kTAG_BTN+1 patternType:@"4" target:nil aSelector:nil];
    [self.contentView addSubview:btnConfirm];
    
    UIView * vertLine = [UIView createLineWithRect:CGRectZero isDash:NO tag:kTAG_VIEW];
    vertLine.backgroundColor = kC_LineColor;
    [self.contentView addSubview:vertLine];
    
    UIView * topLine = [UIView createLineWithRect:CGRectMake(0, 0, kScreen_width, kH_LINE_VIEW) isDash:NO tag:kTAG_VIEW+10];
    [self.contentView addSubview:topLine];
    
    
    [self.contentView addSubview:self.imgViewLeft];

    
    self.imgViewLeft = imgView;
    self.labelName = labelName;
    self.labelPrice = labelPrice;
    self.labelIntegrityLevel = labelIntegrityLevel;
    
    self.imgLabView = imgLabelView;
    self.starsView = starRateView;

    self.btnCall = btnCall;
    self.btnConfirm = btnConfirm;

    self.lineVert = vertLine;
    self.lineTop = topLine;
    self.lineTop.hidden = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    

    //议价列表
    CGSize textSize = [self sizeWithText:self.labelIntegrityLevel.text font:self.labelIntegrityLevel.font width:kScreen_width];

    CGSize btnCallSize = CGSizeMake(35, 35);
    CGSize btnConfirmSize = CGSizeMake(75, 30);
    CGRect btnConfirmRect = CGRectMake(CGRectGetWidth(self.contentView.frame) - kY_GAP - btnConfirmSize.width, kY_GAP * 3 + btnCallSize.height, btnConfirmSize.width, btnConfirmSize.height);
    CGRect btnCallRect = CGRectMake(CGRectGetMidX(btnConfirmRect) -  btnCallSize.width/2.0, kY_GAP*2, btnCallSize.width, btnCallSize.height);

    CGFloat kScale = kS_scaleOrder;
    CGFloat padding = kPadding;
    CGFloat heightLab = 20;

    CGSize imgSize = CGSizeMake(55, 55);
    CGRect imgViewRect = CGRectMake(kX_GAP, kY_GAP, imgSize.width, imgSize.height);

    CGRect labelNameRect = CGRectMake(0, CGRectGetMaxY(imgViewRect), CGRectGetMaxX(imgViewRect), kH_LABEL);
    
    CGRect labelPriceRect = CGRectMake(CGRectGetMaxX(imgViewRect) + padding*2, CGRectGetMaxY(labelNameRect) - heightLab*3, kScreen_width * kScale - CGRectGetMaxX(imgViewRect), heightLab);

    CGRect imgLabViewRect = CGRectMake(CGRectGetMinX(labelPriceRect), CGRectGetMaxY(labelPriceRect), CGRectGetWidth(labelPriceRect), heightLab);
    //星星
    CGSize starRateViewSize = CGSizeMake(15*5, 15);
    
    CGRect starViewRect = CGRectMake(CGRectGetMaxX(imgViewRect) + padding*2, CGRectGetMaxY(imgLabViewRect) + padding , starRateViewSize.width, starRateViewSize.height);
    
    CGFloat labelIntegrityHeight = 15;
    CGRect labelIntegrityRect = CGRectMake(CGRectGetMaxX(starViewRect) + padding, CGRectGetMidY(starViewRect) - labelIntegrityHeight/2.0, textSize.width+5, labelIntegrityHeight);

    self.imgViewLeft.frame = imgViewRect;
    self.labelName.frame = labelNameRect;
    self.labelPrice.frame = labelPriceRect;
    self.imgLabView.frame = imgLabViewRect;
    self.starsView.frame = starViewRect;
    self.labelIntegrityLevel.frame = labelIntegrityRect;
    
    self.lineVert.frame = CGRectMake(CGRectGetMaxX(labelPriceRect), padding, kH_LINE_VIEW, CGRectGetHeight(self.contentView.frame) - padding*2);
    self.btnCall.frame = btnCallRect;
    self.btnConfirm.frame = btnConfirmRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
