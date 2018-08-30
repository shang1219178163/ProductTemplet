//
//  WHKTableViewNinetyCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/6/19.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewNinetyCell.h"

#import "BN_DatePicker.h"

@interface WHKTableViewNinetyCell ()

@property (nonatomic, copy) NSString * dateStart;
@property (nonatomic, copy) NSString * dateEnd;

@end

@implementation WHKTableViewNinetyCell

-(void)dealloc{
    [self.textFieldLeft removeObserver:self forKeyPath:@"text" context:nil];
    [self.textFieldRight removeObserver:self forKeyPath:@"text" context:nil];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //批次号
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textFieldLeft];
    
    [self.contentView addSubview:self.labelRight];
    [self.contentView addSubview:self.textFieldRight];

    

    self.labelRight.text = @"-";
    self.labelRight.textAlignment = NSTextAlignmentCenter;

    self.textFieldLeft.placeholder = @"请选择";
    self.textFieldRight.placeholder = @"请选择";
    self.textFieldLeft.delegate = self;
    self.textFieldRight.delegate = self;

    NSString * dateStr = [NSString timeFromNow];
    self.dateStart = dateStr;
    self.dateEnd = dateStr;
    
    self.textFieldLeft.text = [dateStr toDateShort];
    self.textFieldRight.text = [dateStr toDateShort];

    self.textFieldLeft.layer.borderWidth = kW_LayerBorderWidth;
    self.textFieldLeft.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.textFieldRight.layer.borderWidth = kW_LayerBorderWidth;
    self.textFieldRight.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    
    [self.textFieldLeft addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
    [self.textFieldRight addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        if (object == self.textFieldLeft) {
            self.dateStart = change[NSKeyValueChangeNewKey];
            
        }else{
            self.dateEnd = change[NSKeyValueChangeNewKey];
            
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    

    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    CGFloat textFieldWidth = (CGRectGetWidth(self.contentView.frame) - labLeftSize.width - kX_GAP*2 - kPadding)/2.4;
    
    CGSize textFieldSize = CGSizeMake(textFieldWidth, 30);
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - textFieldSize.height)*0.5;

    self.labelLeft.frame = CGRectMake(kX_GAP, YGap, labLeftSize.width, textFieldSize.height);

    self.textFieldLeft.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame)+kPadding, YGap, textFieldSize.width, textFieldSize.height);
    
    self.labelRight.frame = CGRectMake(CGRectGetMaxX(self.textFieldLeft.frame), YGap, textFieldSize.width*0.4, textFieldSize.height);
    self.textFieldRight.frame = CGRectMake(CGRectGetMaxX(self.labelRight.frame), YGap, textFieldSize.width, textFieldSize.height);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -UITextField
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [[[self superview] superview] endEditing:YES];
    
    [self createDatePick:nil tag:textField.tag];
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
    
    BN_DatePicker *datePicker = [[BN_DatePicker alloc] initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
    datePicker.datePickerMode = UIDatePickerModeDate;    
    datePicker.minimumDate = [NSDate distantPast];
    datePicker.maximumDate = [NSDate date];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    //    datePicker.locale = [NSLocale currentLocale];
    datePicker.title = @"请选择时间";
    datePicker.tag = tag;
    
    if ([date isKindOfClass:[NSString class]]) date = [NSDate dateWithString:date];
    datePicker.date = date ? date: [NSDate date];
    [datePicker show];
    datePicker.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {
        NSString * dateStr = [self stringWithDate:datePicker.date];
        DDLog(@"dateStr_%@_%ld",dateStr,btnIndex);
        
        if (btnIndex == 1) {
            switch (tag - kTAG_TEXTFIELD) {
                case 0:
                {
                    self.dateStart = dateStr;
                    self.textFieldLeft.text = [dateStr toDateShort];

                }
                    break;
                case 1:
                {
                    self.dateEnd = dateStr;
                    self.textFieldRight.text = [dateStr toDateShort];
                    
                }
                    break;
                default:
                    break;
            }
            
            NSString * start = [self.textFieldLeft.text  stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSString * end = [[self.textFieldRight.text toDateMonthDay]  stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSString *range = [NSString stringWithFormat:@"%@_%@",start,end];
            
            if (self.block) {
                self.block(self, self.dateStart, self.dateEnd, range, tag - kTAG_TEXTFIELD);
            }
        }
    };
}

#pragma mark - -layz

-(BN_TextField *)textFieldLeft{
    if (!_textFieldLeft) {
        _textFieldLeft = [UIView createBINTextFieldWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Second textAlignment:NSTextAlignmentCenter keyboardType:UIKeyboardTypeDefault];
        _textFieldLeft.tag = kTAG_TEXTFIELD;
    }
    return _textFieldLeft;
}

-(BN_TextField *)textFieldRight{
    if (!_textFieldRight) {
        _textFieldRight = [UIView createBINTextFieldWithRect:CGRectZero text:@"" placeholder:nil font:KFZ_Second textAlignment:NSTextAlignmentCenter keyboardType:UIKeyboardTypeDefault];
        _textFieldRight.tag = kTAG_TEXTFIELD+1;
    }
    return _textFieldRight;
}

@end
