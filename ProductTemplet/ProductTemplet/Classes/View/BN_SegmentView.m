//
//  BN_SegmentView.m
//  HuiZhuBang
//
//  Created by hsf on 2018/3/29.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "BN_SegmentView.h"

@interface BN_SegmentView()

@property (nonatomic, strong, readwrite) NSArray *items;
//@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

@property (nonatomic, strong, readwrite) NSMutableArray *itemViewList;

@end

@implementation BN_SegmentView

-(NSMutableArray *)itemViewList{
    if (!_itemViewList) {
        _itemViewList = [NSMutableArray arrayWithCapacity:0];
    }
    return _itemViewList;
    
}

+ (instancetype)viewWithRect:(CGRect)frame items:(NSArray *)items type:(NSNumber *)type{
    BN_SegmentView * view = [[BN_SegmentView alloc]initWithFrame:frame items:items type:type];
    return view;
    
}

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items type:(NSNumber *)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _items = items;
        
        self.backgroundColor = [UIColor whiteColor];
//        self.backgroundColor = [UIColor greenColor];
        
        CGFloat itemWidth = CGRectGetWidth(frame)/_items.count;
        for (NSInteger i = 0; i <  items.count; i ++) {
            NSDictionary * dict = items[i];
            
            UIColor * titleColor = [dict[BN_ItemTitleColor_N] isKindOfClass:[UIColor class]] ? dict[BN_ItemTitleColor_N] : [UIColor lightGrayColor];
            
            NSString * imgName_H = dict[BN_ItemImage_H] ? : dict[BN_ItemImage_N];
            NSString * imgName = [dict[BN_ItemSelected] boolValue] == YES ? imgName_H : dict[BN_ItemImage_N];
            UIView * itemView = [self createBtnViewWithRect:CGRectMake(i*itemWidth, 0, itemWidth, CGRectGetHeight(frame)) imgName:imgName imgHeight:kH_LABEL title:dict[BN_ItemTitle] titleColor:titleColor patternType:[type stringValue]];
            itemView.tag = kTAG_VIEW + i;
            
 
            CALayer * layer = [itemView createLayerType:@3 color:kC_LineColor width:1 paddingScale:0.2];
            [itemView.layer addSublayer:layer];

            [self addSubview:itemView];
            [self.itemViewList addObject:itemView];
            //
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleActionTap:)];
            [itemView addGestureRecognizer:tap];
        }
    }
    return self;
}

- (void)handleActionTap:(UITapGestureRecognizer *)tap{
    self.selectedIndex = tap.view.tag - kTAG_VIEW;
    
    UIImageView * imgView = [tap.view viewWithTag:kTAG_IMGVIEW];
    
    imgView.selected = !imgView.selected;
    
    NSDictionary * dic = self.items[self.selectedIndex];
    NSString * imgName_H = dic[BN_ItemImage_H] ? : dic[BN_ItemImage_N];
    NSString * imgName = imgView.selected == YES ? imgName_H : dic[BN_ItemImage_N];
    imgView.image = [UIImage imageNamed:imgName];

}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;

    UIView * itemView = [self viewWithTag:(selectedIndex + kTAG_VIEW)];
    [self handleItemView:itemView];

    if (self.blockObject) self.blockObject(_items[selectedIndex], self.itemViewList[selectedIndex], _selectedIndex);
    
}

-(void)handleItemView:(UIView *)itemView{
    
    for (UIView * view in self.subviews) {
        NSDictionary * dict = _items[view.tag - kTAG_VIEW];
        
        UIImageView * imgView = [view viewWithTag:kTAG_IMGVIEW];
        UILabel * lable = [view viewWithTag:kTAG_LABEL];
        
        if (view.tag == itemView.tag) {
            NSString * imageName = dict[BN_ItemImage_H] ? : dict[BN_ItemImage_N];
            imgView.image = [UIImage imageNamed:imageName];
            
            UIColor * titleColor_H = [dict[BN_ItemTitleColor_H] isKindOfClass:[UIColor class]] ? dict[BN_ItemTitleColor_H] : dict[BN_ItemTitleColor_N];
            lable.textColor = titleColor_H;
            
        }else{
            imgView.image = [UIImage imageNamed:dict[BN_ItemImage_N]];
            UIColor * titleColor_N = [dict[BN_ItemTitleColor_N] isKindOfClass:[UIColor class]] ? dict[BN_ItemTitleColor_N] : [UIColor lightGrayColor];
            lable.textColor = titleColor_N;
            
        }
    }
}

- (UIView *)createBtnViewWithRect:(CGRect)rect imgName:(NSString *)imgName imgHeight:(CGFloat)imgHeight title:(NSString *)title titleColor:(UIColor *)titleColor patternType:(NSString *)patternType
{
    
    UIView * backgroudView = [[UIView alloc]initWithFrame:rect];
    
    if (imgName == nil || ![imgName validObject]) {
        UILabel * lab = [[UILabel alloc]initWithFrame:rect];
        lab.text = title;
        lab.textColor = titleColor;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:KFZ_Second];
        lab.numberOfLines = 1;
        lab.lineBreakMode = NSLineBreakByTruncatingTail;
        lab.tag = kTAG_LABEL;
        
        lab.adjustsFontSizeToFitWidth = YES;
        lab.minimumScaleFactor = 0.5;
        
        [backgroudView addSubview:lab];
        return backgroudView;
    }
    
    UIImageView * imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgName]];
    imgV.contentMode = UIViewContentModeScaleAspectFit;
    imgV.userInteractionEnabled = YES;
    imgV.tag = kTAG_IMGVIEW;
    
    CGRect labRect = CGRectZero;
    switch ([patternType integerValue]) {
        case 0://图上字下
        {
            CGSize imgSize = CGSizeMake(35, 35);
            
            labRect = CGRectMake(0, imgSize.height, CGRectGetWidth(rect), kH_LABEL);
            imgV.frame = CGRectMake((CGRectGetWidth(rect) - imgSize.width)/2.0, 0, imgSize.width, imgSize.height);
            
        }
            break;
        case 1://图左字右
        {
            CGSize imgSize = CGSizeMake(25, 25);
            CGSize labSize = CGSizeMake(17*title.length, imgSize.height);
            
            CGFloat xGap = (CGRectGetWidth(rect) - (imgSize.width + labSize.width + kPadding))/2.0;
            CGFloat YGap = (CGRectGetHeight(rect) - imgSize.height)/2.0;
            imgV.frame = CGRectMake(xGap, YGap, imgSize.width, imgSize.height);
            labRect = CGRectMake(CGRectGetMaxX(imgV.frame)+kPadding, YGap, labSize.width, labSize.height);
            
        }
            break;
        case 2://图下字上
        {
            CGSize imgSize = CGSizeMake(35, 35);
            
            labRect = CGRectMake(0, 0, CGRectGetWidth(rect), kH_LABEL);
            imgV.frame = CGRectMake((CGRectGetWidth(rect) - imgSize.width)/2.0, CGRectGetMaxY(labRect), imgSize.width, imgSize.height);
       
        }
            break;
        case 3://图右字左
        {
            CGSize imgSize = CGSizeMake(25, 25);
            CGSize labSize = CGSizeMake(17*title.length, imgSize.height);
            
            CGFloat xGap = (CGRectGetWidth(rect) - (imgSize.width + labSize.width + kPadding))/2.0;
            CGFloat YGap = (CGRectGetHeight(rect) - imgSize.height)/2.0;
            
            labRect = CGRectMake(xGap, YGap, labSize.width, labSize.height);
            imgV.frame = CGRectMake(CGRectGetMaxX(labRect)+kPadding, YGap, imgSize.width, imgSize.height);
        }
            break;
        default:
            break;
    }
    UILabel * lab = [[UILabel alloc]initWithFrame:labRect];
    lab.text = title;
    lab.textColor = titleColor;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:KFZ_Second];
    lab.numberOfLines = 1;
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    lab.tag = kTAG_LABEL;
    
    lab.adjustsFontSizeToFitWidth = YES;
    lab.minimumScaleFactor = 0.5;
    
    //    DDLog(@"imgV.frame %@ labRect  %@",NSStringFromCGRect(imgV.frame),NSStringFromCGRect(labRect));
    //    imgV.backgroundColor = [UIColor redColor];
    //    lab.backgroundColor = [UIColor yellowColor];
    //    backgroudView.backgroundColor = [UIColor greenColor];
    //    backgroudView.layer.borderColor = kC_LineColor.CGColor;
    //    backgroudView.layer.borderWidth = kW_LayerBorderWidth;
    
    [backgroudView addSubview:imgV];
    [backgroudView addSubview:lab];
    
    return backgroudView;
}



@end
