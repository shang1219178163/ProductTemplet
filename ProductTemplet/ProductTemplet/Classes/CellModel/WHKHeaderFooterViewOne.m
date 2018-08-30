
//
//  WHKHeaderFooterViewOne.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/24.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKHeaderFooterViewOne.h"

@implementation WHKHeaderFooterViewOne

//+(instancetype)viewWithTableView:(UITableView *)tableView{
//    
//    NSString * identifier = NSStringFromClass([self class]);
//    WHKHeaderFooterViewOne * view = (WHKHeaderFooterViewOne *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
//    if (!view) {
//        view = [[WHKHeaderFooterViewOne alloc] initWithReuseIdentifier:identifier];
// 
//        [view.layer addSublayer:[view createLayerType:@0]];
//        [view.layer addSublayer:[view createLayerType:@2]];
//
//    }
//    return view;
//}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

-(void)createControls{
    self.contentView.backgroundColor = [UIColor whiteColor];
    //文字(宽度自适应)+文字+文字
    [self.contentView addSubview:self.labelOne];
    [self.contentView addSubview:self.labelTwo];
    [self.contentView addSubview:self.labelThree];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize labOneSize = [self sizeWithText:self.labelOne.text font:self.labelOne.font width:kScreen_width];
    labOneSize = CGSizeMake(ceil(labOneSize.width), labOneSize.height);
    //文字+文字
    CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - kH_LABEL_SMALL*2)/2.0;
    CGFloat padding = kPadding;
    
    CGFloat width = (kScreen_width - labOneSize.width - padding*2 - kX_GAP*2)/2.0;
    width = floorf(width);
    self.labelOne.frame     = CGRectMake(kX_GAP, YGap, labOneSize.width, kH_LABEL_SMALL*2);
    self.labelTwo.frame     = CGRectMake(CGRectGetMaxX(self.labelOne.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
    self.labelThree.frame   = CGRectMake(CGRectGetMaxX(self.labelTwo.frame)+padding, YGap, width, kH_LABEL_SMALL*2);
}

#pragma mark - -layz

-(UILabel *)labelOne{
    if (!_labelOne) {
        _labelOne = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL patternType:@"0" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labelOne;
}

-(UILabel *)labelTwo{
    if (!_labelTwo) {
        _labelTwo = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+1 patternType:@"0" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labelTwo;
}

-(UILabel *)labelThree{
    if (!_labelThree) {
        _labelThree = [UILabel createLabelWithRect:CGRectZero text:@"" textColor:nil tag:kTAG_LABEL+2 patternType:@"0" font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _labelThree;
}

@end
