//
//  BINShoppingCartBottomView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/11/13.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "NNShoppingView.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"

@implementation NNShoppingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {        
        [self addSubview:self.btnRadio];
        [self addSubview:self.btnDoIt];

        [self addSubview:self.labPriceAll];
        
        [self getViewLayer];

        self.backgroundColor = UIColor.whiteColor;
        self.backgroundColor = UIColor.whiteColor;

    }
    return self;
}

//- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps{
//    
//    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
//    [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontSize14] range:NSMakeRange(0, string.length)];
//    
//    for (NSInteger i = 0; i < textTaps.count; i++) {
//        [attString addAttribute:NSForegroundColorAttributeName value:UIColor.orangeColor range:[string rangeOfString:textTaps[i]]];
//        [attString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFontSize14] range:[string rangeOfString:textTaps[i]]];
//        
//    }
//    return attString;
//}

-(void)handleActionBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(shoppingCartView:sender:)]) {
        [self.delegate shoppingCartView:self sender:sender];
        
    }
    
    if (self.block) {
        self.block(self, sender);
    }
}

-(UIButton *)btnDoIt{
    if (!_btnDoIt) {
        CGRect rectBtn = CGRectMake(kScreenWidth - kScreenWidth/3.0, 0, kScreenWidth/3.0, CGRectGetHeight(self.frame));
        _btnDoIt = [UIButton createRect:rectBtn title:@"下一步" type:NNButtonTypeTitleWhiteAndBackgroudTheme];
        [_btnDoIt setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_btnDoIt setBackgroundImage:UIImageColor(UIColor.themeColor) forState:UIControlStateNormal];
        [_btnDoIt addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDoIt;
}

-(UIButton *)btnRadio{
    if (!_btnRadio) {
        _btnRadio = ({
            UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
            view.frame = CGRectMake(kX_GAP, kY_GAP, 65, kH_LABEL);
            
            [view setImage:[UIImage imageNamed:@"img_btn_unSelect.png"] forState:UIControlStateNormal];
            [view setImage:[UIImage imageNamed:@"img_btn_selected.png"] forState:UIControlStateSelected];
            [view setImage:[UIImage imageNamed:@"img_btn_selected.png"] forState:UIControlStateHighlighted];
            
            view.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [view setTitle:@"全选" forState:UIControlStateNormal];
            [view setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
            view.titleLabel.font = [UIFont systemFontOfSize:kFontSize16];
            
            view.tag = kTAG_BTN;
            [view addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
            view;
        });
    }
    return _btnRadio;
}


-(UILabel *)labPriceAll{
    if (!_labPriceAll) {
        NSString * titleSub = @"0个订单  共0元";
        CGRect rectSub = CGRectMake(CGRectGetMidX(self.btnRadio.frame), CGRectGetMaxY(self.btnRadio.frame), CGRectGetMinX(self.btnDoIt.frame) - CGRectGetMidX(self.btnRadio.frame), kH_LABEL);
        _labPriceAll = [UILabel createRect:rectSub type:NNLabelTypeFitWidth];
        _labPriceAll.text = titleSub;
        
    }
    return _labPriceAll;
}


@end
