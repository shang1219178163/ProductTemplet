//
//  WHKTableViewSixtyCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/3/28.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSixtyCell.h"

#import "GlobleConst.h"

@implementation WHKTableViewSixtyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+时间选择器
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textField];
    
    self.textField.placeholder = @"请选择";
    self.textField.textAlignment = NSTextAlignmentCenter;

    self.textField.rightView = [self getTextFieldRightView:kIMAGE_arrowDown];
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
    self.textField.delegate = self;
    
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
    
    if (!self.dateStr  || ![self.dateStr validObject]) self.dateStr = [NSString timeFromNow];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setDateStr:(NSString *)dateStr{
    _dateStr = dateStr;
    
    if (dateStr.length == 10 && [dateStr containsString:@"-"]) {
        dateStr = [dateStr stringByAppendingString:@" 00:00:00"];
    }
    
    self.textField.text = [dateStr toDateShort];
    if (self.block) {
        self.block(self, dateStr);
    }
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[[self superview] superview] endEditing:YES];
    [self createDatePick:self.dateStr tag:textField.tag];
    return NO;
    
}

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//
//
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    [[[self superview] superview] endEditing:YES];
//    return YES;
//}

#pragma mark - - BN_DatePicker
- (void)createDatePick:(id)date tag:(NSInteger)tag{
    BN_DatePicker *datePicker = self.datePicker;

    if ([date isKindOfClass:[NSString class]]) date = [NSDate dateWithString:date];
    datePicker.date = date ? date: [NSDate date];
    [datePicker show];
    datePicker.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {

        NSString * dateStr = [self stringWithDate:datePicker.date];
        DDLog(@"dateStr_%@_%ld",dateStr,btnIndex);
        
        if (btnIndex == 1) {
            self.textField.text = [dateStr toDateShort];
            if (self.block) {
                self.block(self, dateStr);
            }
        }
    };
}


#pragma mark - -layz

-(BN_DatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = ({
            BN_DatePicker *view = [[BN_DatePicker alloc] initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
            view.minimumDate = [NSDate distantPast];
            view.maximumDate = [NSDate date];
            view.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
            //    datePicker.locale = [NSLocale currentLocale];
            view.title = @"请选择时间";
            
            view;
            
        });
    }
    return _datePicker;
}

@end
