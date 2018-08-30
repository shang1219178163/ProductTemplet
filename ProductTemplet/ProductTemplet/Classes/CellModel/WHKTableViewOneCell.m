//
//  WHKTableViewOneCell.m
//  HuiZhuBang
//
//  Created by 晁进 on 2017/8/8.
//  Copyright © 2017年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewOneCell.h"

@interface WHKTableViewOneCell ()

@end

@implementation WHKTableViewOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片+文字+文字+图片
    [self.contentView addSubview:self.imgViewLeft];
    [self.contentView addSubview:self.imgViewRight];
    
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelRight];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //图片+文字+文字+图片
    self.type = self.type != nil ? self.type : @0;
    
    CGSize arrowSize = CGSizeMake(25, 25);
    CGFloat padding = kPadding;
    
    //图片右
    self.imgViewRight.frame = CGRectMake(kScreen_width - arrowSize.width - kX_GAP, (self.height - arrowSize.height)/2.0, arrowSize.width, arrowSize.height);

    //图片左
    if (self.imgViewLeft.image) {
        CGFloat scale = [[UIScreen mainScreen]scale];
        CGSize imgSize = CGSizeMake(self.imgViewLeft.image.size.width/scale, self.imgViewLeft.image.size.height/scale);
        
        self.imgViewLeft.frame = CGRectMake(kX_GAP, (self.height - imgSize.height)*0.5, imgSize.width, imgSize.height);
    }
    
    //labelRight右对齐
    if ([self.type integerValue] == 0) {
        CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:kScreen_width];
        
        CGFloat X_right = self.imgViewRight.hidden == NO ? CGRectGetMinX(self.imgViewRight.frame) - padding - labRightSize.width : self.width - kX_GAP - labRightSize.width;
        self.labelRight.frame = CGRectMake(X_right, CGRectGetMinY(self.imgViewRight.frame), labRightSize.width, CGRectGetHeight(self.imgViewRight.frame));
        
        if (self.imgViewLeft.image) {
            //控件1
            self.labelLeft.frame = CGRectMake(CGRectGetMaxX(self.imgViewLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), CGRectGetMinX(self.labelRight.frame) - CGRectGetMaxX(self.imgViewLeft.frame) - padding*2, CGRectGetHeight(self.imgViewRight.frame));
            
        }
        else{
            //控件1
            self.labelLeft.frame = CGRectMake(kX_GAP, CGRectGetMinY(self.imgViewRight.frame), CGRectGetMinX(self.labelRight.frame) - padding - kX_GAP, CGRectGetHeight(self.imgViewRight.frame));
            
        }
        
    }
    else{
        //labelRight左对齐
        CGSize labSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];

        CGFloat X_left = self.imgViewLeft.image != nil ? CGRectGetMaxX(self.imgViewLeft.frame) + padding : kX_GAP;
        self.labelLeft.frame = CGRectMake(X_left, CGRectGetMinY(self.imgViewRight.frame), labSize.width, CGRectGetHeight(self.imgViewRight.frame));
        
        CGFloat w_maxRight = self.imgViewRight.hidden == NO ? CGRectGetMinX(self.imgViewRight.frame) : self.width;
        self.labelRight.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), w_maxRight - kPadding - kX_GAP - CGRectGetMaxX(self.labelLeft.frame), CGRectGetHeight(self.imgViewRight.frame));
       
    }
}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//
//    //图片+文字+文字+图片
//    self.type = self.type != nil ? self.type : @0;
//
//    CGSize arrowSize = CGSizeMake(25, 25);
//    CGFloat YGap = CGRectGetMidY(self.contentView.frame) - arrowSize.height/2.0;
//    CGFloat padding = kPadding;
//
//    self.imgViewRight.frame = CGRectMake(kScreen_width - arrowSize.width - kX_GAP, CGRectGetMidY(self.contentView.frame) - arrowSize.height/2.0, arrowSize.width, arrowSize.height);
//
//
//    if ([self.type integerValue] == 0) {
//        CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:kScreen_width];
//
//
//        CGFloat originX = self.imgViewRight.hidden == NO ? CGRectGetMinX(self.imgViewRight.frame) - padding - labRightSize.width : self.width - kX_GAP - labRightSize.width;
//        self.labelRight.frame = CGRectMake(originX, CGRectGetMinY(self.imgViewRight.frame), labRightSize.width, CGRectGetHeight(self.imgViewRight.frame));
//
//        if (self.imgViewLeft.image) {
//            CGFloat scale = [[UIScreen mainScreen]scale];
//            CGSize imgSize = CGSizeMake(self.imgViewLeft.image.size.width/scale, self.imgViewLeft.image.size.height/scale);
//
//            self.imgViewLeft.frame = CGRectMake(kX_GAP, (self.height - imgSize.height)*0.5, imgSize.width, imgSize.height);
//
//            //控件1
//            self.labelLeft.frame = CGRectMake(CGRectGetMaxX(self.imgViewLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), CGRectGetMinX(self.labelRight.frame) - CGRectGetMaxX(self.imgViewLeft.frame) - padding*2, CGRectGetHeight(self.imgViewRight.frame));
//
//        }
//        else{
//            //控件1
//            self.labelLeft.frame = CGRectMake(kX_GAP, YGap, CGRectGetMinX(self.labelRight.frame) - padding, CGRectGetHeight(self.imgViewRight.frame));
//
//        }
//
//    }
//    else{
//        CGSize labSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
//
//        if (self.imgViewLeft.image) {
//            CGFloat scale = [[UIScreen mainScreen]scale];
//            CGSize imgSize = CGSizeMake(self.imgViewLeft.image.size.width/scale, self.imgViewLeft.image.size.height/scale);
//
//            self.imgViewLeft.frame = CGRectMake(kX_GAP, (self.height - imgSize.height)*0.5, imgSize.width, imgSize.height);
//            self.labelLeft.frame = CGRectMake(CGRectGetMaxX(self.imgViewLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), labSize.width, CGRectGetHeight(self.imgViewRight.frame));
//            self.labelRight.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), CGRectGetMinX(self.imgViewRight.frame) - CGRectGetMaxX(self.labelLeft.frame) - padding*2, CGRectGetHeight(self.imgViewRight.frame));
//
//        }
//        else{
//            //控件1
//            self.labelLeft.frame = CGRectMake(kX_GAP, YGap, CGRectGetMinX(self.labelRight.frame) - padding, CGRectGetHeight(self.imgViewRight.frame));
//            self.labelRight.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), CGRectGetMinX(self.imgViewRight.frame) - CGRectGetMaxX(self.labelLeft.frame) - padding*2, CGRectGetHeight(self.imgViewRight.frame));
//
//        }
//    }
//}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//    
//
//    //图片+文字+文字+图片
//
//    if (self.imgViewLeft.image) {
//        if (CGSizeEqualToSize(self.imgViewLeftSize, CGSizeZero)){
//            self.imgViewLeftSize = CGSizeMake(self.imgViewLeft.image.size.width/2.0, self.imgViewLeft.image.size.height/2.0);
//        }
//
//
//        CGFloat YGap = (CGRectGetHeight(self.contentView.frame) - self.imgViewLeftSize.height)/2.0;
//        CGFloat padding = kPadding;
//
//        CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:kScreen_width];
//
//
//        CGSize imgViewRightSize = CGSizeMake(25, 25);
//        //控件1
//        CGRect imgViewLeftRect = CGRectMake(YGap, YGap, self.imgViewLeftSize.width, self.imgViewLeftSize.height);
//
//        //控件4
//        CGRect imgViewRightRect = CGRectMake(kScreen_width - imgViewRightSize.width -  kX_GAP, CGRectGetMidY(imgViewLeftRect) - imgViewRightSize.height/2.0, imgViewRightSize.width, imgViewRightSize.height);
//        //控件3
//        CGRect titleSubRect = CGRectMake(CGRectGetMinX(imgViewRightRect) - padding - labRightSize.width, CGRectGetMinY(imgViewRightRect), labRightSize.width, CGRectGetHeight(imgViewRightRect));
//        //控件2
//        CGRect titleRect = CGRectMake(CGRectGetMaxX(imgViewLeftRect) + padding, CGRectGetMinY(imgViewRightRect), CGRectGetMinX(titleSubRect) - CGRectGetMaxX(imgViewLeftRect) - padding*2, CGRectGetHeight(titleSubRect));
//
//        self.imgViewLeft.frame = imgViewLeftRect;
//        self.imgViewRight.frame = imgViewRightRect;
//        self.labelLeft.frame = titleRect;
//        self.labelRight.frame = titleSubRect;
//    }
//    else{
//        CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:kScreen_width];
//
//        CGSize arrowSize = CGSizeMake(25, 25);
//        CGFloat YGap = CGRectGetMidY(self.contentView.frame) - arrowSize.height/2.0;
//        CGFloat padding = kPadding;
//
//        //控件1
//
//        //控件4
//        CGRect arrowRect = CGRectMake(kScreen_width - arrowSize.width -  kX_GAP, CGRectGetMidY(self.contentView.frame) - arrowSize.height/2.0, arrowSize.width, arrowSize.height);
//        //控件3
//        CGRect titleSubRect = CGRectMake(CGRectGetMinX(arrowRect) - padding - labRightSize.width, CGRectGetMinY(arrowRect), labRightSize.width, CGRectGetHeight(arrowRect));
//        //控件2
//        CGRect titleRect = CGRectMake(YGap, YGap, CGRectGetMinX(titleSubRect) - padding, CGRectGetHeight(titleSubRect));
//
//        self.imgViewRight.frame = arrowRect;
//        self.labelLeft.frame = titleRect;
//        self.labelRight.frame = titleSubRect;
//
//    }
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
