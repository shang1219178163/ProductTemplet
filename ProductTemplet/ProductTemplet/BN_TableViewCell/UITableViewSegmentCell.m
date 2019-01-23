//
//  UITableViewSegmentCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewSegmentCell.h"
#import "BN_Globle.h"
#import "NSObject+Helper.h"
#import "UIView+AddView.h"

@implementation UITableViewSegmentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}
 
- (void)createControls{
    //文字+segment
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.segmentCtrl];
    
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
    self.segmentCtrl.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame)+30, CGRectGetMidY(self.contentView.frame) - height/2.0, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.labelLeft.frame) -30*2, height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UISegmentedControl *)segmentCtrl{
    if (!_segmentCtrl) {
        _segmentCtrl = [UIView createSegmentRect:CGRectMake(0, 0, kScreenWidth, 44) items:@[@"是",@"否"] selectedIndex:0 type:@0];
        _segmentCtrl.selectedSegmentIndex = 0;
        
    }
    return _segmentCtrl;
}

@end
