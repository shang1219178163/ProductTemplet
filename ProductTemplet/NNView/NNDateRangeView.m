//
//  NNDateRangeView.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/1/23.
//  Copyright © 2019 BN. All rights reserved.
//

#import "NNDateRangeView.h"

#import <NNGloble/NNGloble.h>
#import "NSDateFormatter+Helper.h"
#import "UIView+Helper.h"
#import "NSString+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface NNDateRangeView()

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labStart;
@property (nonatomic, strong) UILabel * labEnd;
@property (nonatomic, strong) UILabel * labLine;

@end

@implementation NNDateRangeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.labelLeft];
        [self addSubview:self.labStart];
        [self addSubview:self.labEnd];
        [self addSubview:self.labLine];
        
        self.dateStart = self.dateEnd = [NSDateFormatter stringFromDate:NSDate.date fmt:kFormatDate];
                
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];

}

-(void)setupConstraint{
    CGSize labelLeftSize = [self.labelLeft sizeThatFits:CGSizeMake(CGFLOAT_MAX, 35)];
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kX_GAP);
        make.size.equalTo(labelLeftSize);
    }];
    
    CGSize labStartSize = [self.labStart sizeThatFits:CGSizeMake(100, 35)];
    [self.labStart makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.lessThanOrEqualTo(self.labelLeft.right).offset(30);
        make.size.equalTo(labStartSize);
    }];
    
    CGSize labLineSize = [self.labLine sizeThatFits:CGSizeMake(20, 35)];
    [self.labLine makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.labStart.right).offset(20);
        make.size.equalTo(labLineSize);
    }];
    
    CGSize labEndSize = [self.labEnd sizeThatFits:CGSizeMake(20, 35)];
    [self.labEnd makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.labLine.right).offset(20);
        make.size.equalTo(labEndSize);
    }];
    
}

- (void)setDateStart:(NSString *)dateStart{
    _dateStart = dateStart;
    self.labStart.text = [dateStart substringToIndex:10];

}

- (void)setDateEnd:(NSString *)dateEnd{
    _dateEnd = dateEnd;
    self.labEnd.text = [dateEnd substringToIndex:10];

}

#pragma mark - lazy

-(UILabel *)labelLeft{
    if (!_labelLeft) {
        _labelLeft = [self createLabelRect:CGRectZero text:@"日期选择:" tag:0];
    }
    return _labelLeft;
}

- (UILabel *)labStart{
    if (!_labStart) {
        _labStart = [self createLabelRect:CGRectZero text:@"起始日期" tag:kTAG_LABEL];
        _labStart.textColor = UIColor.titleColor9;
        @weakify(self);
        [_labStart addGestureTap:^(UIGestureRecognizer *sender) {
            @strongify(self);
            [self.datePicker show];
            
        }];
    }
    return _labStart;
}

- (UILabel *)labEnd{
    if (!_labEnd) {
        _labEnd = [self createLabelRect:CGRectZero text:@"截止日期" tag:kTAG_LABEL+1];
        _labEnd.textColor = UIColor.titleColor9;
        @weakify(self);
        [_labEnd addGestureTap:^(UIGestureRecognizer *sender) {
            @strongify(self);
            [self.datePickerEnd show];
           
        }];
    }
    return _labEnd;
}

- (UILabel *)labLine{
    if (!_labLine) {
        _labLine = [self createLabelRect:CGRectZero text:@"-" tag:1];
    }
    return _labLine;
}

-(NNDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = ({
            NNDatePicker *view = [[NNDatePicker alloc] initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
            view.minimumDate = NSDate.distantPast;
            view.maximumDate = NSDate.distantFuture;
            view.title = @"请选择时间";
            view.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {
                NSString * dateStr = [NSDateFormatter stringFromDate:datePicker.date fmt:kFormatDate];
                self.dateStart = dateStr;
                if (self.block) {
                    self.block(self);
                }
            };
            view;
        });
    }
    return _datePicker;
}

-(NNDatePicker *)datePickerEnd{
    if (!_datePickerEnd) {
        _datePickerEnd = ({
            NNDatePicker *view = [[NNDatePicker alloc] initWithCancelBtnTitle:@"取消" confirmBtnTitle:@"确认"];
            view.minimumDate = NSDate.distantPast;
            view.maximumDate = NSDate.distantFuture;
            view.title = @"请选择时间";
            view.block = ^(UIDatePicker *datePicker, NSInteger btnIndex) {
                NSString * dateStr = [NSDateFormatter stringFromDate:datePicker.date fmt:kFormatDate];
                self.dateEnd = dateStr;
                if (self.block) {
                    self.block(self);
                }
            };
            view;
        });
    }
    return _datePickerEnd;
}

- (UILabel *)createLabelRect:(CGRect)rect text:(NSString *)text tag:(NSInteger)tag{
    UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    view.font = [UIFont systemFontOfSize:16];
    view.textAlignment = NSTextAlignmentCenter;
    view.userInteractionEnabled = true;
    view.numberOfLines = 1;
    view.lineBreakMode = NSLineBreakByTruncatingTail;
    view.adjustsFontSizeToFitWidth = YES;
    //        label.backgroundColor = UIColor.greenColor;

    view.text = text;
    view.tag = tag;
    return view;
}

@end
