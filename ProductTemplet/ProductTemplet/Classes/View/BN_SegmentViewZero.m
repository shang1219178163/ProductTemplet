              //
//  BINSegmentView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/8/15.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BN_SegmentViewZero.h"

static const CGFloat kH_lineHorizontal = 2;
static const CGFloat KH_lineVertical = 1;

@interface BN_SegmentViewZero ()

@property (nonatomic, strong) NSArray * titleArr;

@property (nonatomic, strong) UIView * lineViewHori;

@property (nonatomic, assign) CGFloat titleWidth;

@property (nonatomic, strong) NSMutableArray * labelMarr;
@property (nonatomic, strong) NSMutableArray * lineVertMarr;

@end

@implementation BN_SegmentViewZero

- (id)initWithFrame:(CGRect)frame Titles:(NSArray *)titles titleWidth:(CGFloat)titleWith selectIndex:(NSInteger)selectIndex IsBottom:(BOOL)isBottom{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selectIndex = selectIndex;
        self.titleArr = titles;
        self.titleWidth = titleWith;
        
        CGFloat height = CGRectGetHeight(frame);
        
        self.contentSize = CGSizeMake(height, titleWith * titles.count);
        self.scrollEnabled = YES;
        [self setContentOffset:CGPointMake(0, 0)];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = NO;
        self.bounces = NO;
        self.contentSize =  CGSizeMake(titleWith * titles.count, height);
        
        UIView *backgroudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, titleWith * titles.count, height)];
        backgroudView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backgroudView];
        
        
        self.labelMarr = [NSMutableArray arrayWithCapacity:0];
        self.lineVertMarr = [NSMutableArray arrayWithCapacity:0];
        
        for (NSInteger i = 0; i < titles.count; i++) {
            
            CGRect labRect = CGRectMake(titleWith * i, 0, titleWith, height);
//            DDLog(@"labRect%ld_%@",i,NSStringFromCGRect(labRect));
            UILabel * label = [self createLabelWithRect:labRect text:titles[i] textColor:[UIColor blackColor] tag:kTAG_LABEL+i patternType:@"2" font:17 backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter hasGesture:YES target:self aSelector:@selector(tapView:)];
            [backgroudView addSubview:label];
            
            if (selectIndex == i) {
                if (self.titleColorSelected) {
                    label.textColor = self.titleColorSelected;
                    
                }else{
                    label.textColor = kC_ThemeCOLOR;
                    
                }
            }else{
                label.textColor = [UIColor blackColor];
            }
            
            
            CGRect lineVertRect = CGRectMake(titleWith * i, 0, KH_lineVertical, height);
            UIView * lineViewVert = [self createLineWithRect:lineVertRect isDash:NO tag:kTAG_VIEW+i];
            [backgroudView addSubview:lineViewVert];
            
            if (self.gapLineColor) {
                self.gapLineColor = self.gapLineColor;
                
            }else{
                self.gapLineColor = [UIColor clearColor];
                
            }
            
            if (i == 0) {
                lineViewVert.hidden = YES;
            }
            
            [self.labelMarr addObject:label];
            [self.lineVertMarr addObject:lineViewVert];
            
            self.titleLabels = self.labelMarr.copy;
        }
        CGFloat YGap = 0;
        if (isBottom == YES) {
            YGap = height - kH_lineHorizontal;
        }
        
        CGRect lineHoriRect = CGRectMake(titleWith * selectIndex, YGap, titleWith, kH_lineHorizontal);
        UIView * lineViewHori = [self createLineWithRect:lineHoriRect isDash:NO tag:kTAG_VIEW+20];
        [backgroudView addSubview:lineViewHori];
        
        if (self.indicatorColor) {
            lineViewHori.backgroundColor = self.indicatorColor;
            
        }else{
            lineViewHori.backgroundColor = kC_ThemeCOLOR;
            
        }
        self.lineViewHori = lineViewHori;
    }
    return self;
}

- (void)tapView:(UITapGestureRecognizer *)tap{
    
    //    NSInteger tapIndex = tap.view.tag;
    NSInteger selectedIndex = tap.view.tag - kTAG_LABEL;
    self.IsSelectIndex = selectedIndex;
    [self updateSegmentStatesWithIndex:selectedIndex];
    
}

- (void)updateSegmentStatesWithIndex:(NSInteger)selectedIndex{
    
    for (UILabel * view in self.labelMarr) {
        
        UILabel * lable = (UILabel *)view;
        if (selectedIndex != (lable.tag - kTAG_LABEL)) {
            lable.textColor = [UIColor blackColor];
            
        }else{
            if ([self.titleColorSelected isKindOfClass:[UIColor class]]) {
                lable.textColor = self.titleColorSelected;
                
            }else{
                lable.textColor = kC_ThemeCOLOR;

            }
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frame = self.lineViewHori.frame;
        frame.origin.x = selectedIndex * self.titleWidth;
        self.lineViewHori.frame = frame;
        
    }];
    
    if (self.block) {
        self.block(self, selectedIndex);
    }
    self.IsSelectIndex = selectedIndex;
}


- (void)setSelectIndex:(NSInteger)selectedIndex{
    [self updateSegmentStatesWithIndex:selectedIndex];
    
}

- (void)setTitleColorSelected:(UIColor *)titleColorSelected{
    
    for (UILabel * view in self.labelMarr) {
        
        UILabel * lable = (UILabel *)view;
        if (self.selectIndex != (lable.tag - kTAG_LABEL)) {
            lable.textColor = [UIColor blackColor];
            
        }else{
            lable.textColor = titleColorSelected;
            
        }
    }
}

- (void)setIndicatorColor:(UIColor *)indicatorColor{
    
    self.lineViewHori.backgroundColor = indicatorColor;
    
}

-(void)setGapLineColor:(UIColor *)gapLineColor{

    for (UIView *view in self.lineVertMarr) {
        view.backgroundColor = gapLineColor;
        
    }

}

#pragma mark - -other Funtions
- (UIView *)createLineWithRect:(CGRect)rect isDash:(BOOL)isDash tag:(NSInteger)tag{
    
    if (!isDash) {
        UIView * lineView = [[UIView alloc]initWithFrame:rect];
        //            lineView.backgroundColor = [Utilities colorWithHexString:@"#d2d2d2"];
        lineView.backgroundColor = [UIColor clearColor];
        
        return lineView;
        
    }else{
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
        imageView.tag = tag;
        imageView.backgroundColor = [UIColor clearColor];
        
        UIGraphicsBeginImageContext(imageView.frame.size);   //开始画线
        [imageView.image drawInRect:CGRectMake(0, 0, CGRectGetWidth(imageView.frame), CGRectGetHeight(imageView.frame))];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);  //设置线条终点形状
        
        CGFloat lengths[] = {3,1.5};
        CGContextRef line = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(line, [UIColor lightGrayColor].CGColor);
        
        CGContextSetLineDash(line, 0, lengths, 2);  //画虚线
        CGContextMoveToPoint(line, 0, 0);    //开始画线
        CGContextAddLineToPoint(line, CGRectGetMaxX(imageView.frame), 0);
        CGContextStrokePath(line);
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        return imageView;
    }
}

- (UILabel *)createLabelWithRect:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor tag:(NSInteger)tag patternType:(NSString *)patternType font:(CGFloat)fontSize backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment hasGesture:(BOOL)hasGesture target:(id)target aSelector:(SEL)aSelector;
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    
    [label setText:text];
    [label setTextColor:textColor];
    [label setFont:[UIFont systemFontOfSize:fontSize]];
    [label setTextAlignment:alignment];
    [label setTag:tag];
    [label setBackgroundColor:backgroudColor];
    //        [label setBackgroundColor:[UIColor clearColor]];
    
    switch ([patternType integerValue]) {
        case 0:
        {
            [label setNumberOfLines:0];
            [label setLineBreakMode:NSLineBreakByCharWrapping];
            
        }
            break;
        case 1:
        {
            
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            
        }
            break;
        case 2:
        {
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            
            label.adjustsFontSizeToFitWidth = YES;
            label.minimumScaleFactor = 0.5;
        }
            break;
        case 3:
        {
            label.textAlignment = NSTextAlignmentCenter;
            [label setNumberOfLines:1];
            //            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = CGRectGetWidth(rect)/2.0;
        }
            break;
        default:
            break;
    }
    
    
    if (hasGesture == YES) {
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:aSelector];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        
        tapGesture.cancelsTouchesInView = NO;
        tapGesture.delaysTouchesEnded = NO;
        
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tapGesture];
    }
    
    return label;
}

@end
