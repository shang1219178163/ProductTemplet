//
//  BINMsgView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/10/10.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BINMsgView.h"

@interface BINMsgView ()

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSString * theTitle;
@property (nonatomic, strong) NSString * theMessage;

@end

@implementation BINMsgView

-(UILabel *)labelTitle{
    
    if (!_labTitle) {
        _labTitle = [[UILabel alloc]init];
        _labTitle.userInteractionEnabled = YES;
    }
    return _labTitle;
}

-(UILabel *)labContent{
    
    if (!_labContent) {
        _labContent = [[UILabel alloc]init];
        _labTitle.userInteractionEnabled = YES;

    }
    return _labContent;
    
}

- (UIView *)msgViewTitle:(NSString *)title message:(NSString *)message{
    
    self.theTitle = title;
    self.theMessage = message;
    
    BINMsgView * msgView = [[BINMsgView alloc]initWithFrame:CGRectZero];
    return msgView;
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        CGSize sizeContent = [self sizeWithText:self.labContent.text font:self.labContent.font width:CGRectGetWidth(self.labContent.frame)];
        sizeContent.height = sizeContent.height > 20 ? sizeContent.height : 20;
        
        
        [self addSubview:self.labelTitle];
        [self addSubview:self.labContent];

    }
    return self;
}

@end
