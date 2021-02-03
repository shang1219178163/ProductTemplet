//
//  NNGroupViewZero.m
//  BINAlertView
//
//  Created by BIN on 2018/3/23.
//  Copyright © 2018年 SouFun. All rights reserved.
//

#import "NNGroupViewZero.h"
#import <NNGloble/NNGloble.h>
#import "NNCategoryPro.h"

@interface NNGroupViewZero ()

@property (nonatomic, strong ,readwrite) NSMutableArray * selectedList;

@end

@implementation NNGroupViewZero

-(NSMutableArray *)selectedList{
    if (!_selectedList) {
        _selectedList = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectedList;
}

+ (NNGroupViewZero *)viewRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList{
    
    NNGroupViewZero *view = [[NNGroupViewZero alloc]initRect:rect items:items numberOfRow:numberOfRow itemHeight:itemHeight padding:padding selectedList:selectedList];
    return view;
}


- (id)initRect:(CGRect)rect items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding selectedList:(NSArray *)selectedList{
    self = [super init];
    if (self) {
        self.items = items;
        
        [self.selectedList removeAllObjects];
        [self.selectedList addObjectsFromArray:selectedList];
        
        //    CGFloat padding = 15;
        //    CGFloat viewHeight = 30;
        //    NSInteger numberOfRow = 4;
        NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
        //
        self.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), rowCount * itemHeight + (rowCount - 1) * padding);
        self.backgroundColor = UIColor.greenColor;
        
        CGSize viewSize = CGSizeMake((CGRectGetWidth(self.frame) - (numberOfRow-1)*padding)/numberOfRow, itemHeight);
        for (NSInteger i = 0; i< items.count; i++) {
            
            CGFloat w = viewSize.width;
            CGFloat h = viewSize.height;
            CGFloat x = w * ( i % numberOfRow) + padding * ( i % numberOfRow);
            CGFloat y =  (i / numberOfRow) * (h + padding);
            
            NSString * title = items[i];
            CGRect btnRect = CGRectMake(x, y, w, h);
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            btn.frame = btnRect;
            [btn setTitle:title forState:UIControlStateNormal];
            
            bool isChoose = [selectedList containsObject:title] ;
            if (isChoose) {
                [btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
            } else {
                [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
                btn.layer.borderColor = UIColor.lineColor.CGColor;
                btn.layer.borderWidth = 1;
            }
            
            btn.tag = kTAG_BTN+i;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
            if ([self.selectedList containsObject:title]) {
                [self handleSender:btn backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
                
            }
            else{
                [self handleSender:btn backgroudColor:UIColor.whiteColor textColor:UIColor.titleColor3 layerColor:UIColor.lineColor];
                
            }
            [self addSubview:btn];
            
        }
    }
    return self;
}


-(void)setIsOnlyOne:(BOOL)isOnlyOne{
    _isOnlyOne = isOnlyOne;
    if (isOnlyOne  && self.selectedList.count > 1) {
//        NSAssert(isOnlyOne  && self.selectedList.count == 1, @"isOnlyOne = yes代表单选");
        self.selectedList = [NSMutableArray arrayWithObject: [self.selectedList lastObject]];
        for (UIButton *sender in self.subviews) {
            NSString * title = sender.titleLabel.text;
            if ([self.selectedList containsObject:title]) {
                [self handleSender:sender backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
                
            } else {
                [self handleSender:sender backgroudColor:UIColor.whiteColor textColor:UIColor.titleColor3 layerColor:UIColor.lineColor];
                
            }
        }
    }
}

- (void)handleActionBtn:(UIButton *)sender{
//    DDLog(@"isOnlyOne__%@",@(self.isOnlyOne));
    
    NSString * title = sender.titleLabel.text;
    if (self.isOnlyOne == NO) {
        if (![self.selectedList containsObject:title]) {
            [self.selectedList addObject:title];
            [self handleSender:sender backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
            
        } else {
            [self.selectedList removeObject:title];
            [self handleSender:sender backgroudColor:UIColor.whiteColor textColor:UIColor.titleColor3 layerColor:UIColor.lineColor];
            
        }
    }
    else{
        
        if ([self.selectedList containsObject:title]) {
        
        }
        else{
            [self.selectedList removeAllObjects];
            for (UIButton *btn in self.subviews) {

                if ([btn isEqual:sender]) {
                    [self.selectedList addObject:title];
                    [self handleSender:btn backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];

                } else {
                    [self handleSender:btn backgroudColor:UIColor.whiteColor textColor:UIColor.titleColor3 layerColor:UIColor.lineColor];

                }
            }
        }
    }
    
    if (self.viewBlock) {
        self.viewBlock(self, self.selectedList, title, self.isOnlyOne);
    }
}


-(void)setColorBackNormal:(UIColor *)colorBackNormal{
    for (UIButton *sender in self.subviews) {
        if ([self.selectedList containsObject:sender.titleLabel.text]) {
            [self handleSender:sender backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
        } else {
            [self handleSender:sender backgroudColor:colorBackNormal textColor:UIColor.titleColor3 layerColor:UIColor.lineColor];
        }
    }
}

-(void)setColorBackSelected:(UIColor *)colorBackSelected{
    for (UIButton *sender in self.subviews) {
        if ([self.selectedList containsObject:sender.titleLabel.text]) {
            [self handleSender:sender backgroudColor:colorBackSelected textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
        } else {
            [self handleSender:sender backgroudColor:UIColor.whiteColor textColor:UIColor.titleColor3 layerColor:UIColor.lineColor];
        }
    }
}

- (void)handleSender:(UIButton *)sender backgroudColor:(UIColor *)backgroudColor textColor:(UIColor *)textColor layerColor:(UIColor *)layerColor{
    [sender setBackgroundImage:UIImageColor(backgroudColor) forState:UIControlStateNormal];
    [sender setTitleColor:textColor forState:UIControlStateNormal];
}

-(void)setChooseList:(NSArray *)chooseList{
    [self.selectedList removeAllObjects];
    for (UIButton *btn in self.subviews) {
        NSString * title = btn.titleLabel.text;
        if ([chooseList containsObject:title]) {
            [self.selectedList addObject:title];
            [self handleSender:btn backgroudColor:UIColor.themeColor textColor:UIColor.whiteColor layerColor:UIColor.themeColor];
        } else {
            [self handleSender:btn backgroudColor:UIColor.whiteColor textColor:UIColor.titleColor3 layerColor:UIColor.lineColor];
        }
    }
}

-(NSArray *)chooseList{
    return self.selectedList;
}

@end
