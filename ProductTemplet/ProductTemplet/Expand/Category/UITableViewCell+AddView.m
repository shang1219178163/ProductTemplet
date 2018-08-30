
//
//  UITableViewCell+AddView.m
//  BN_SeparatorView
//
//  Created by hsf on 2018/8/23.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import "UITableViewCell+AddView.h"

#import <objc/runtime.h>


@implementation UITableViewCell (AddView)

@dynamic labelRight,labelLeft,labelLeftMark,labelLeftSub,labelLeftSubMark,imgViewLeft,imgViewRight,btn,textField,textView,radioView;

+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsZero;
    
    return cell;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *identifier = NSStringFromClass([self class]);
    return [self cellWithTableView:tableView identifier:identifier];
}


#pragma mark - -layz

- (CGSize)imgViewLeftSize{
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}

- (void)setImgViewLeftSize:(CGSize)imgViewLeftSize{
    objc_setAssociatedObject(self, @selector(imgViewLeftSize), @(imgViewLeftSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(CGFloat)width{
    return CGRectGetWidth(self.contentView.frame);
    
}

-(CGFloat)height{
    return CGRectGetHeight(self.contentView.frame);
    
}

-(void)setLabelRight:(UILabel *)labelRight{
    objc_setAssociatedObject(self, @selector(labelRight), labelRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(UILabel *)labelRight{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+4 patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentRight];

//        lab = ({
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.tag = kTAG_LABEL + 4;
//            label.font = [UIFont systemFontOfSize:17];
//            label.textAlignment = NSTextAlignmentRight;
//
//            label.numberOfLines = 0;
//            label.userInteractionEnabled = YES;
//            //        label.backgroundColor = [UIColor greenColor];
//            label;
//        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(void)setLabelLeft:(UILabel *)labelLeft{
    objc_setAssociatedObject(self, @selector(labelLeft), labelLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(UILabel *)labelLeft{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];

//        lab = ({
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.tag = kTAG_LABEL;
//            label.font = [UIFont systemFontOfSize:17];
//            label.textAlignment = NSTextAlignmentLeft;
//
//            label.numberOfLines = 0;
//            label.userInteractionEnabled = YES;
//            //        label.backgroundColor = [UIColor greenColor];
//            label;
//        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

- (void)setLabelLeftMark:(UILabel *)labelLeftMark{
    objc_setAssociatedObject(self, @selector(labelLeftMark), labelLeftMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UILabel *)labelLeftMark{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];

//        lab = ({
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.tag = kTAG_LABEL + 1;
//            label.font = [UIFont systemFontOfSize:17];
//            label.textAlignment = NSTextAlignmentLeft;
//
//            label.numberOfLines = 0;
//            label.userInteractionEnabled = YES;
//            //        label.backgroundColor = [UIColor greenColor];
//            label;
//        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(void)setLabelLeftSub:(UILabel *)labelLeftSub{
    objc_setAssociatedObject(self, @selector(labelLeftSub), labelLeftSub, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UILabel *)labelLeftSub{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];

//        lab = ({
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.tag = kTAG_LABEL + 2;
//
//            label.font = [UIFont systemFontOfSize:17];
//            //            label.textColor = [UIColor grayColor];
//            label.textAlignment = NSTextAlignmentLeft;
//
//            label.numberOfLines = 0;
//            label.userInteractionEnabled = YES;
//            //        label.backgroundColor = [UIColor greenColor];
//            label;
//        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(void)setLabelLeftSubMark:(UILabel *)labelLeftSubMark{
    objc_setAssociatedObject(self, @selector(labelLeftSubMark), labelLeftSubMark, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UILabel *)labelLeftSubMark{
    UILabel * lab = objc_getAssociatedObject(self, _cmd);
    if (lab == nil) {
        lab = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+3 patternType:@"2" font:KFZ_Second backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentLeft];

//        lab = ({
//            UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
//            label.tag = kTAG_LABEL + 3;
//            label.font = [UIFont systemFontOfSize:17];
//            //            label.textColor = [UIColor grayColor];
//            label.textAlignment = NSTextAlignmentLeft;
//
//            label.numberOfLines = 0;
//            label.userInteractionEnabled = YES;
//            //        label.backgroundColor = [UIColor greenColor];
//            label;
//        });
        objc_setAssociatedObject(self, _cmd, lab, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return lab;
}

-(void)setImgViewLeft:(UIImageView *)imgViewLeft{
    objc_setAssociatedObject(self, @selector(imgViewLeft), imgViewLeft, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UIImageView *)imgViewLeft{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (imgV == nil) {
        imgV = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //            imgView.backgroundColor = [UIColor orangeColor];
            
            imgView;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return imgV;
}

-(void)setImgViewRight:(UIImageView *)imgViewRight{
    objc_setAssociatedObject(self, @selector(imgViewRight), imgViewRight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(UIImageView *)imgViewRight{
    UIImageView * imgV = objc_getAssociatedObject(self, _cmd);
    if (imgV == nil) {
        imgV = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.userInteractionEnabled = YES;
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            //            imgView.backgroundColor = [UIColor orangeColor];
            imgView.frame = CGRectMake(self.width - kX_GAP - kWH_ArrowRight, (self.height - kWH_ArrowRight)/2.0, kWH_ArrowRight, kWH_ArrowRight);
            imgView.image = [UIImage imageNamed:kIMAGE_arrowRight];
            imgView.hidden = YES;
            imgView;
        });
        objc_setAssociatedObject(self, _cmd, imgV, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return imgV;
}

-(void)setBtn:(UIButton *)btn{
    objc_setAssociatedObject(self, @selector(btn), btn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(UIButton *)btn{
    UIButton * button = objc_getAssociatedObject(self, _cmd);
    if (button == nil) {
        button = [UIView createBtnWithRect:CGRectZero title:@"取消订单" font:KFZ_Second image:nil tag:kTAG_BTN patternType:@"7" target:nil aSelector:nil];
//        button = ({
//            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setTitle:@"btn" forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:17];
//            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
//
//            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//
//            btn;
//        });
        objc_setAssociatedObject(self, _cmd, button, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return button;
    
}

-(void)setTextField:(BN_TextField *)textField{
    objc_setAssociatedObject(self, @selector(textField), textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(BN_TextField *)textField{
    BN_TextField * textField = objc_getAssociatedObject(self, _cmd);
    if (textField == nil) {
        textField = [UIView createBINTextFieldWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Second textAlignment:NSTextAlignmentLeft keyboardType:UIKeyboardTypeDefault];
        textField.tag = kTAG_TEXTFIELD;

        objc_setAssociatedObject(self, _cmd, textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return textField;
}

-(void)setTextView:(BN_TextView *)textView{
    objc_setAssociatedObject(self, @selector(textView), textView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(BN_TextView *)textView{
    BN_TextView * tv = objc_getAssociatedObject(self, _cmd);
    if (tv == nil) {
        tv = [UIView createTextViewWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Third textAlignment:NSTextAlignmentLeft keyType:UIKeyboardTypeDefault];
        
        objc_setAssociatedObject(self, _cmd, tv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return tv;
}

- (void)setRadioView:(BN_RadioViewZero *)radioView{
    objc_setAssociatedObject(self, @selector(radioView), radioView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

-(BN_RadioViewZero *)radioView{
    BN_RadioViewZero * view = objc_getAssociatedObject(self, _cmd);
    if (view == nil) {
        view = [[BN_RadioViewZero alloc]initWithFrame:CGRectZero imgName_N:@"img_select_N" imgName_H:@"img_select_H"];
        view.isSelected = NO;
        view.tag = kTAG_VIEW_RADIO;
        
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return view;
}

//-(UITextField *)textField{
//    UITextField * textField = objc_getAssociatedObject(self, _cmd);
//    if (textField == nil) {
//        textField = ({
//            UITextField * textField = [[UITextField alloc]initWithFrame:CGRectZero];
//            textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//            textField.keyboardAppearance = UIKeyboardAppearanceDefault;
//
//            //        textField.returnKeyType = UIReturnKeyDone;
//            //        textField.clearButtonMode = UITextFieldViewModeAlways;
//
//            textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//            textField.autocorrectionType = UITextAutocorrectionTypeNo;
//            textField.clearButtonMode = UITextFieldViewModeWhileEditing;//清楚键
//            //        textField.layer.borderWidth = 0.5;  // 给图层添加一个有色边框
//            //        textField.layer.borderColor = [UtilityHelper colorWithHexString:@"d2d2d2"].CGColor;
//            textField.backgroundColor = [UIColor whiteColor];
//
//            textField;
//        });
//        objc_setAssociatedObject(self, _cmd, textField, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    }
//    return textField;
//}
//
//-(UITextView *)textView{
//    UITextView * tv = objc_getAssociatedObject(self, _cmd);
//    if (tv == nil) {
//        tv = ({
//            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
//
//            textView.font = [UIFont systemFontOfSize:17];
//            textView.textAlignment = NSTextAlignmentLeft;
//
//            textView.keyboardAppearance = UIKeyboardAppearanceDefault;
//            textView.returnKeyType = UIReturnKeyDone;
//
//            textView.autocorrectionType = UITextAutocorrectionTypeNo;
//            textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
//
//            //            textView.layer.borderWidth = 0.5;
//            //            textView.layer.borderColor = kC_LineColor.CGColor;
//            //            [textView scrollRectToVisible:rect animated:YES];
//            textView;
//        });
//        objc_setAssociatedObject(self, _cmd, tv, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    }
//    return tv;
//}

#pragma mark - -getTextFieldRightView

- (id)getTextFieldRightView:(NSString *)unitString{
    //    NSArray * unitList = @[@"元",@"公斤"];
    if (unitString != nil && ![unitString isEqualToString:@""]) {
        if ([unitString containsString:@".png"]) {
            CGSize size = CGSizeMake(20, 20);
            UIImageView * imgView = [UIImageView createImageViewWithRect:CGRectMake(0, 0, size.width, size.height) image:unitString tag:kTAG_IMGVIEW patternType:@"0"];
            return imgView;
        }
        else{
            CGSize size = [self sizeWithText:unitString font:@(KFZ_Third) width:kScreen_width];
            
            UILabel * label = [UILabel createLabelWithRect:CGRectMake(0, 0, size.width+2, 25) text:unitString textColor:kC_TextColor_Title tag:kTAG_LABEL patternType:@"2" font:KFZ_Third backgroudColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
            return label;
        }
    }
    return nil;
}


@end
