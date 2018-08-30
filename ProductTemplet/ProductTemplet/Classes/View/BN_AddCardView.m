//
//  BINAddCardView.m
//  HuiZhuBang
//
//  Created by BIN on 2017/10/18.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "BN_AddCardView.h"

@interface BN_AddCardView ()

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) UIImageView * imgViewAdd;
@property (nonatomic, strong) UILabel * label;

@end

@implementation BN_AddCardView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        CGSize imgViewSize = CGSizeMake(kH_LABEL_SMALL, kH_LABEL_SMALL);
        CGFloat YGap = (CGRectGetHeight(frame) - imgViewSize.height*2)/2.0;
        CGFloat XGapImgView = (CGRectGetWidth(frame) - imgViewSize.width)/2.0;
        
        CGRect imgViewRect = CGRectMake(XGapImgView, YGap, imgViewSize.width, imgViewSize.height);
        UIImageView * imgView = [self createImageViewWithRect:imgViewRect image:@"img_cardAdd.png" tag:kTAG_IMGVIEW patternType:@"0"];
        [self addSubview:imgView];
        
        CGSize textSize = [self sizeWithText:title font:@(KFZ_Third) width:CGRectGetWidth(frame)];
        CGFloat XGapLab = (CGRectGetWidth(frame) - textSize.width)/2.0;
        
        CGRect labRect = CGRectMake(XGapLab, CGRectGetMaxY(imgViewRect), textSize.width, kH_LABEL_SMALL);
        UILabel * lab = [self createLabelWithRect:labRect text:title textColor:kC_TextColor_TitleSub tag:kTAG_LABEL patternType:@"2" font:KFZ_Third backgroudColor:nil alignment:NSTextAlignmentCenter];
        [self addSubview:lab];
        
        if (image == nil) {
            imgView.hidden = NO;
            lab.hidden = NO;
            
        }else{
            imgView.hidden = YES;
            lab.hidden = YES;
            
        }
        self.tag = tag;
        
        if ([image isKindOfClass:[NSString class]]) {
            self.image = [UIImage imageNamed:image];
            
        }
        else if ([image isKindOfClass:[UIImage class]]) {
            self.image = image;
            
        }else{
            //网络链接,根据实际情况自定义
            
        }
        
    }
    return self;
}

//imageView通用创建方法
- (UIImageView *)createImageViewWithRect:(CGRect)rect image:(id)image tag:(NSInteger)tag patternType:(NSString *)patternType
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.userInteractionEnabled = YES;
    
    if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];
        
    }
    else if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
        
    }
    switch ([patternType integerValue]) {
        case 0://默认方形
        {
            imageView.layer.borderWidth = 1;
            imageView.layer.borderColor = [UIColor redColor].CGColor;
            
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.layer.shouldRasterize = YES;
            imageView.clipsToBounds = NO;
            
        }
            break;
        case 1://圆形
        {
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = CGRectGetHeight(imageView.frame)/2.0;
            imageView.layer.borderWidth = 0.5;
            imageView.layer.borderColor = kC_LineColor.CGColor;
            imageView.layer.shouldRasterize = YES;
            imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
            imageView.clipsToBounds = NO;
            
        }
            break;
        case 2://带右下角icon
        {
            //小标志
            NSString * text = @"企";
            CGSize textSize = [self sizeWithText:text font:@(KFZ_Third) width:kScreen_width];
            CGFloat textWH = textSize.height > textSize.width ? textSize.height :textSize.width;
            textWH += 5;
            CGFloat offsetXY = CGRectGetHeight(rect)/2.0 * sin(45 * M_PI/180.0);
            
            CGPoint tipCenter = CGPointMake(CGRectGetHeight(rect)/2.0 + offsetXY, CGRectGetHeight(rect)/2.0 + offsetXY);
            //
            UILabel * labelTip = [UIView createTipLabelWithSize:CGSizeMake(textWH, textWH) tipCenter:tipCenter text:text textColor:kC_ThemeCOLOR tag:kTAG_LABEL font:KFZ_Third backgroudColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
            [imageView addSubview:labelTip];
            
        }
            break;
        default:
            break;
    }
    //    imageView.backgroundColor = kC_BackgroudColor;
    
//    imageView.layer.borderWidth = kW_LayerBorderWidth;
//    imageView.layer.borderColor = kC_LineColor.CGColor;
    
    return imageView;
}

//多图加手势
- (UIImageView *)createImageViewRect:(CGRect)rect image:(id)image tag:(NSInteger)tag target:(id)target aSelector:(SEL)aSelector
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.tag = tag;
    
    if ([image isKindOfClass:[UIImage class]]) {
        imageView.image = image;
        
    }
    else if ([image isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:image];
        
    }
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:target action:aSelector];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
    //    tapGesture.cancelsTouchesInView = NO;
    //    tapGesture.delaysTouchesEnded = NO;
    
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapGesture];
    
    return imageView;
}

- (UILabel *)createLabelWithRect:(CGRect)rect text:(id)text textColor:(UIColor *)textColor tag:(NSInteger)tag patternType:(NSString *)patternType font:(CGFloat)fontSize  backgroudColor:(UIColor *)backgroudColor alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[UILabel alloc] initWithFrame:rect];
    if ([text isKindOfClass:[NSString class]]) {
        label.text = text;
        label.textColor = textColor;
        
    }else if ([text isKindOfClass:[NSAttributedString class]]){
        label.attributedText = text;
        
    }
    label.tag = tag;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    
    switch ([patternType integerValue]) {
        case 0://无限折行
        {
            [label setNumberOfLines:0];
            [label setLineBreakMode:NSLineBreakByCharWrapping];
            
        }
            break;
        case 1://abc...
        {
            
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            
        }
            break;
        case 2://一行字体大小自动调节
        {
            [label setNumberOfLines:1];
            [label setLineBreakMode:NSLineBreakByTruncatingTail];
            
            label.adjustsFontSizeToFitWidth = YES;
            label.minimumScaleFactor = 0.8;
        }
            break;
        case 3://圆形
        {
            label.textAlignment = NSTextAlignmentCenter;
            
            [label setNumberOfLines:1];
            
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = CGRectGetWidth(rect)/2.0;
            
            label.layer.shouldRasterize = YES;
            label.layer.rasterizationScale = [UIScreen mainScreen].scale;
        }
            break;
        case 4://带边框的圆角矩形标签
        {
            [label setNumberOfLines:1];
            
            label.layer.borderColor = textColor.CGColor;
            label.layer.borderWidth = 1.0;
            label.layer.masksToBounds = YES;
            label.layer.cornerRadius = 2;
        }
            break;
        default:
            break;
    }
    
    
    //    label.backgroundColor = [UIColor greenColor];
    //    label.backgroundColor = [UIColor whiteColor];
    
    //    label.layer.borderWidth = 1;
    //    label.layer.borderColor = kC_RedColor.CGColor;
    
    return label;
}

@end
