//
//  NNTextFieldOne.m
//  BNKit
//
//  Created by BIN on 2018/11/23.
//

#import "NNTextFieldOne.h"

#import "NNGloble.h"

@interface NNTextFieldOne ()
 
@property(nonatomic, copy) void(^block)(NNTextFieldOne *textField, UIImageView *imgView);

@end

@implementation NNTextFieldOne

//文本框显示时的位置及显示范围
- (CGRect)textRectForBounds:(CGRect)bounds{
    CGRect rectClearBtn = [super clearButtonRectForBounds:bounds];
    CGRect rectLeftView = [super leftViewRectForBounds:bounds];
    
    CGRect rect = bounds;
    if (self.clearButtonMode != UITextFieldViewModeNever) rect.size.width -= CGRectGetWidth(rectClearBtn);
    if (self.leftViewMode != UITextFieldViewModeNever) rect.size.width -= CGRectGetWidth(rectLeftView);
    
    rect.origin.x = kPadding;
    rect.size.width -= kPadding*2;
    return rect;
}
//文本框编辑时的位置及显示范围
- (CGRect)editingRectForBounds:(CGRect)bounds{
    CGRect rectClearBtn = [super clearButtonRectForBounds:bounds];
    CGRect rectLeftView = [super leftViewRectForBounds:bounds];
    
    CGRect rect = bounds;
    if (self.clearButtonMode != UITextFieldViewModeNever) rect.size.width -= CGRectGetWidth(rectClearBtn);
    if (self.leftViewMode != UITextFieldViewModeNever) rect.size.width -= CGRectGetWidth(rectLeftView);
    
    rect.origin.x = kPadding;
    rect.size.width -= kPadding*2;
    return rect;
}
//文本框清除按钮的位置及显示范围
- (CGRect)clearButtonRectForBounds:(CGRect)bounds{
    CGRect rect = [super clearButtonRectForBounds:bounds];
    CGRect rectLeftView = [super leftViewRectForBounds:bounds];

    return CGRectOffset(rect, -CGRectGetWidth(rectLeftView), 0);
}
//文本框左视图的位置及显示范围
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect rect = [super leftViewRectForBounds:bounds];
    CGRect rectLeftView = [super leftViewRectForBounds:bounds];

    return CGRectOffset(rect, bounds.size.width - CGRectGetWidth(rectLeftView), 0);
}

- (void)showHistoryWithImage:(NSString *)image handlder:(void(^)(NNTextFieldOne *textField, UIImageView *imgView))handler{
    self.block = handler;
    UIImageView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
    leftView.image = [UIImage imageNamed:image];
    leftView.contentMode = UIViewContentModeScaleAspectFit;
    leftView.backgroundColor = UIColor.cyanColor;
    self.leftView = leftView;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_handleActionTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
//    tapGesture.cancelsTouchesInView = NO;
//    tapGesture.delaysTouchesEnded = NO;
    
    leftView.userInteractionEnabled = YES;
    [leftView addGestureRecognizer:tap];
}

- (void)p_handleActionTap:(UITapGestureRecognizer *)gesture{
    if (self.block) {
        self.block((NNTextFieldOne *)gesture.view.superview, (UIImageView *)gesture.view);
    }
    
}

@end
