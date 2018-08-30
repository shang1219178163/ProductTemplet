//
//  WHKTableViewFiftyNineCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/6/22.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFiftyNineCell.h"

#import "GlobleConst.h"

@implementation WHKTableViewFiftyNineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+pcikerView(原生)
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    
    self.textField.placeholder = @"请选择";
    self.textField.rightView = [self getTextFieldRightView:kIMAGE_arrowDown];
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    [self.textField addTarget:self action:@selector(handleActionSender:) forControlEvents:UIControlEventEditingDidBegin];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:kScreen_width];
    }
    
    CGFloat XGap = kX_GAP;
    //    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGFloat textFieldH = 30;
    CGFloat lableLeftH = textFieldH;
    
    //控件1
    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    //控件2
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding, CGRectGetMidY(self.contentView.frame) - textFieldH/2.0, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.labelLeft.frame) - padding - XGap, textFieldH);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)handleActionSender:(BN_TextField *)textField{
    [[self superview]endEditing:YES];
    [self createAlertViewTag:textField.tag];
    
}

#pragma mark - - AlertView
- (void)createAlertViewTag:(NSInteger)tag{
    
    NSArray * array = [self.dic sortedValuesByKey];
    
    BN_AlertViewOne * alertView = [[BN_AlertViewOne alloc]init];
    alertView.data = @{
                       kItem_obj    :   array,
                       
                       };
    alertView.label.text = @"选择死淘原因";
    [alertView show];
    alertView.block = ^(BN_AlertViewOne *view, NSIndexPath *indexPath) {
        DDLog(@"%@_%@_%@",@(indexPath.section),@(indexPath.row),array[indexPath.row]);
        self.textField.text = array[indexPath.row];
        if (self.block) {
            self.block(self, array[indexPath.row], indexPath);
        }
        
        
    };
    
}

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

#pragma mark - -layz


@end
