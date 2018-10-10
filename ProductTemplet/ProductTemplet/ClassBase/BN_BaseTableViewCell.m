//
//  BN_BaseTableViewCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/27.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_BaseTableViewCell.h"

@implementation BN_BaseTableViewCell


-(CGFloat)width{
    return CGRectGetWidth(self.contentView.frame);
    
}

-(CGFloat)height{
    return CGRectGetHeight(self.contentView.frame);
    
}

- (id)getTextFieldRightView:(NSString *)unitString{
    //    NSArray * unitList = @[@"元",@"公斤"];
    if (unitString != nil && ![unitString isEqualToString:@""]) {
        if ([unitString containsString:@".png"]) {
            CGSize size = CGSizeMake(20, 20);
            UIImageView * imgView = [UIView createImageViewWithRect:CGRectMake(0, 0, size.width, size.height) image:unitString tag:kTAG_IMGVIEW patternType:@"0"];
            return imgView;
        }
        else{
            CGSize size = [self sizeWithText:unitString font:@(KFZ_Third) width:CGFLOAT_MAX];
            
            UILabel * label = [UIView createLabelWithRect:CGRectMake(0, 0, size.width+2, 25) text:unitString textColor:kC_TextColor_Title tag:kTAG_LABEL patternType:@"2" font:KFZ_Third backgroudColor:UIColor.clearColor alignment:NSTextAlignmentCenter];
            return label;
        }
    }
    return nil;
}

#pragma mark - -layz

-(UIView *)lineTop{
    if (!_lineTop) {
        _lineTop = [UIView createLineWithRect:CGRectMake(0, 0, kScreen_width, kH_LINE_VIEW) isDash:NO hidden:YES tag:kTAG_VIEW+10];
        
    }
    return _lineTop;
}

-(UIImageView *)imgViewLeft{
    if (!_imgViewLeft) {
        _imgViewLeft = [UIView createImageViewWithRect:CGRectZero image:nil tag:kTAG_IMGVIEW patternType:@"0"];
        
    }
    return _imgViewLeft;
    
}

-(UIImageView *)imgViewRight{
    if (!_imgViewRight) {
        _imgViewRight = [UIView createImageViewWithRect:CGRectZero image:kIMAGE_arrowRight tag:kTAG_IMGVIEW+1 patternType:@"0"];
        _imgViewRight.hidden = YES;
        
    }
    return _imgViewRight;
    
}

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"2" font:KFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
    }
    return _labelLeft;
}

-(UILabel *)labelLeftMark{
    if (!_labelLeftMark) {
        _labelLeftMark = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 patternType:@"2" font:KFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
    }
    return _labelLeftMark;
}

-(UILabel *)labelLeftSub{
    if (!_labelLeftSub) {
        _labelLeftSub = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 patternType:@"2" font:KFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
    }
    return _labelLeftSub;
}

-(UILabel *)labelLeftSubMark{
    if (!_labelLeftSubMark) {
        _labelLeftSubMark = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+3 patternType:@"2" font:KFZ_Second backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentLeft];
    }
    return _labelLeftSubMark;
}

-(UILabel *)labelRight{
    if (!_labelRight) {
        _labelRight = [UIView createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+4 patternType:@"2" font:KFZ_Third backgroudColor:UIColor.whiteColor alignment:NSTextAlignmentRight];
    }
    return _labelRight;
}

-(BN_TextField *)textField{
    if (!_textField) {
        _textField = [UIView createTextFieldWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Second textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault];
        _textField.tag = kTAG_TEXTFIELD;
    }
    return _textField;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIView createBtnWithRect:CGRectZero title:@"取消订单" font:KFZ_Second image:nil tag:kTAG_BTN patternType:@"7" target:nil aSelector:nil];

    }
    return _btn;
}

-(BN_TextView *)textView{
    if (!_textView) {
        _textView = [UIView createTextViewWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Third textAlignment:NSTextAlignmentLeft keyType:UIKeyboardTypeDefault];
    }
    return _textView;
}

-(BN_RadioViewZero *)radioView{
    if (!_radioView) {
        _radioView = [[BN_RadioViewZero alloc]initWithFrame:CGRectZero imgName_N:@"img_select_H" imgName_H:@"img_select_H"];
        _radioView.isSelected = NO;
        _radioView.tag  = kTAG_VIEW_RADIO;
    }
    return _radioView;
    
}

@end
