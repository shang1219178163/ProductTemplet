//
//  UITableViewSwitchCell.m
//  BN_TableViewCell
//
//  Created by Bin Shang on 2018/12/14.
//

#import "UITableViewSwitchCell.h"

#import "BN_Globle.h"
#import "NSString+Helper.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

@implementation UITableViewSwitchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+地址选择器
    [self.contentView addSubview:self.labelLeft];
    
    [self.contentView addSubview:self.switchCtrl];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:CGFLOAT_MAX];
    }
    //控件
    CGFloat XGap = kX_GAP;
    CGFloat height = 35;
    
    CGFloat lableLeftH = kH_LABEL;
    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    self.switchCtrl.frame = CGRectMake(CGRectGetWidth(self.contentView.frame) - kX_GAP - CGRectGetWidth(self.switchCtrl.frame), CGRectGetMidY(self.contentView.frame) - CGRectGetHeight(self.switchCtrl.frame)/2.0, CGRectGetWidth(self.switchCtrl.frame), CGRectGetHeight(self.switchCtrl.frame));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UISwitch *)switchCtrl{
    if (!_switchCtrl) {
        _switchCtrl = ({
            UISwitch *view = [[UISwitch alloc]init];
            view.on = YES;//设置初始为ON的一边
            view.onTintColor = UIColor.themeColor;
            view.tintColor = UIColor.whiteColor;
            view;
        });
    }
    return _switchCtrl;
}



@end

