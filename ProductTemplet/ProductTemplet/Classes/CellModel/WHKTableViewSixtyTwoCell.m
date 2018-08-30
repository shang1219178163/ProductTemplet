
//
//  WHKTableViewSixtyTwoCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/4/2.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewSixtyTwoCell.h"

@interface WHKTableViewSixtyTwoCell ()<UITextViewDelegate>

@end

@implementation WHKTableViewSixtyTwoCell

-(void)dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self.textView];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
   //文字+文字(textView)
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.textView];
    
    
    
    self.textView.placeholder = @"请输入";
    self.textView.userInteractionEnabled = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleTextViewDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:self.textView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //文字+文字
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];

    CGFloat YGap = kY_GAP;
    CGFloat padding = kPadding;
    
    CGRect titleRect = CGRectZero;
    CGRect titleSubRect = CGRectZero;
    if (!CGSizeEqualToSize(CGSizeZero, labLeftSize)) {
        if ([self.type integerValue] == 1) {
            titleRect = CGRectMake(kX_GAP, YGap, labLeftSize.width, kH_LABEL);
            titleSubRect = CGRectMake(CGRectGetMinX(titleRect), CGRectGetMaxY(titleRect), self.width - kX_GAP*2, self.height - CGRectGetHeight(titleRect) - YGap*2);
        
        }
        else{
            titleRect = CGRectMake(kX_GAP, YGap, labLeftSize.width, kH_LABEL);
            CGSize subSize = CGSizeMake(self.width - CGRectGetWidth(titleRect) - kX_GAP*2 - padding, self.height - YGap*2);
            titleSubRect = CGRectMake(CGRectGetMaxX(titleRect) + padding, CGRectGetMinY(titleRect), subSize.width, subSize.height);
            
        }
    }
    else{
        titleSubRect = CGRectMake(kX_GAP, YGap, self.width - kX_GAP*2, self.height - YGap*2);
   
    }
    self.labelLeft.frame = titleRect;
    self.textView.frame = titleSubRect;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)handleTextViewDidEndEditing:(NSNotification *)noti{
    UITextView * textView = noti.object;
//    DDLog(@"_%@_",textView.text);
    if (self.block) {
        self.block(self, textView);
    }
    
}

//#pragma mark - -textView
//
//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
//    return YES;
//
//}
//
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//
//}
//
//
//- (void)textViewDidEndEditing:(UITextView *)textView{
//
//
//}

#pragma mark - -layz


@end
