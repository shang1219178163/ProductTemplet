//
//  UITableViewOneCell.m
//  
//
//  Created by BIN on 2017/8/8.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewOneCell.h"
#import "BN_Globle.h"
#import "NSObject+Helper.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface UITableViewOneCell ()

@end

@implementation UITableViewOneCell

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
    self.imgViewRight.frame = CGRectMake(kScreenWidth - arrowSize.width - kX_GAP, (self.contentView.maxY - arrowSize.height)/2.0, arrowSize.width, arrowSize.height);
    
    //图片左
    if (self.imgViewLeft.image) {
        CGFloat scale = UIScreen.mainScreen.scale;
        CGSize imgSize = CGSizeMake(self.imgViewLeft.image.size.width/scale, self.imgViewLeft.image.size.height/scale);
        if (imgSize.height < kH_LABEL) imgSize = CGSizeMake(imgSize.width*(kH_LABEL/imgSize.height), kH_LABEL);
        self.imgViewLeft.frame = CGRectMake(kX_GAP, (self.contentView.maxY - imgSize.height)*0.5, imgSize.width, imgSize.height);
        
        //        self.imgViewLeft.frame = CGRectMake(kX_GAP, kY_GAP, self.contentView.maxY - kY_GAP*2, self.contentView.maxY - kY_GAP*2);
        
    }
    
    //labelRight右对齐
    if (self.type.integerValue == 0) {
        CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
        
        CGFloat X_right = self.imgViewRight.hidden == NO ? CGRectGetMinX(self.imgViewRight.frame) - padding - labRightSize.width : self.contentView.maxX - kX_GAP - labRightSize.width;
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
        CGSize labSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
        
        CGFloat X_left = self.imgViewLeft.image != nil ? CGRectGetMaxX(self.imgViewLeft.frame) + padding : kX_GAP;
        self.labelLeft.frame = CGRectMake(X_left, CGRectGetMinY(self.imgViewRight.frame), labSize.width, CGRectGetHeight(self.imgViewRight.frame));
        
        CGFloat w_maxRight = self.imgViewRight.hidden == NO ? CGRectGetMinX(self.imgViewRight.frame) : self.contentView.maxX;
        self.labelRight.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), w_maxRight - kPadding - kX_GAP - CGRectGetMaxX(self.labelLeft.frame), CGRectGetHeight(self.imgViewRight.frame));
        
    }
}

//- (void)setupConstraint{

//    //箭头不隐藏
//    if (self.imgViewRight.isHidden == false) {
//
//        [self.imgViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView);
//            make.right.equalTo(self.contentView).offset(-kX_GAP);
//            make.size.equalTo(kSizeArrow);
//        }];
//        
//        self.imgViewRight.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-kX_GAP)
//            make.size.equalTo(kSizeArrow)
//        }
//
//        self
//        //头像不为空
//        if self.imgViewLeft.image != nil {
//            self.imgViewLeft.snp.makeConstraints { (make) in
//                make.centerY.equalToSuperview()
//                make.left.equalToSuperview().offset(kX_GAP)
//                make.width.height.equalTo(contentView.frame.height - kY_GAP*2)
//            }
//
//            if type == 0 {
//                //右边文字优先展示
//                labelRight.sizeToFit();
//                labelRight.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.right.equalTo(self.imgViewRight.snp.left).offset(-kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//                labelLeft.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalTo(self.imgViewLeft.snp.right).offset(kPadding)
//                    make.right.equalTo(labelRight.snp.left).offset(-kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//            } else {
//                //左边文字优先展示
//                labelLeft.sizeToFit();
//                labelLeft.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalTo(self.imgViewLeft.snp.right).offset(kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//                labelRight.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalTo(labelLeft.snp.right).offset(kPadding)
//                    make.right.greaterThanOrEqualTo(self.imgViewRight.snp.left).offset(-kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//            }
//
//        } else {
//            //头像为空
//            self.imgViewLeft.snp.makeConstraints { (make) in
//                make.centerY.equalToSuperview()
//                make.left.equalToSuperview().offset(kX_GAP)
//                make.width.height.equalTo(0.0)
//            }
//
//            if type == 0 {
//                labelRight.sizeToFit();
//                labelRight.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.right.equalTo(self.imgViewRight.snp.left).offset(-kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//                labelLeft.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalToSuperview().offset(kX_GAP)
//                    make.right.equalTo(labelRight.snp.left).offset(-kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//            } else {
//                labelLeft.sizeToFit();
//                labelLeft.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalToSuperview().offset(kX_GAP)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//                labelRight.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalTo(labelLeft.snp.right).offset(kPadding)
//                    make.right.equalTo(self.imgViewRight.snp.left).offset(-kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//            }
//        }
//
//    } else {
//        //头像不为空
//        if self.imgViewLeft.image != nil {
//            self.imgViewLeft.snp.makeConstraints { (make) in
//                make.centerY.equalToSuperview()
//                make.left.equalToSuperview().offset(kX_GAP)
//                make.width.height.equalTo(contentView.frame.height - kY_GAP*2)
//            }
//
//            if type == 0 {
//                //右边文字优先展示
//                labelRight.sizeToFit();
//                labelRight.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.right.equalToSuperview().offset(-kX_GAP);
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//                labelLeft.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalTo(self.imgViewLeft.snp.right).offset(kPadding)
//                    make.right.equalTo(labelRight.snp.left).offset(-kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//            } else {
//                //左边文字优先展示
//                labelLeft.sizeToFit();
//                labelLeft.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalTo(self.imgViewLeft.snp.right).offset(kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//                labelRight.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalTo(labelLeft.snp.right).offset(kPadding)
//                    make.right.equalToSuperview().offset(-kX_GAP)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//            }
//
//        } else {
//            self.imgViewLeft.snp.makeConstraints { (make) in
//                make.centerY.equalToSuperview()
//                make.left.equalToSuperview().offset(kX_GAP)
//                make.width.height.equalTo(0.0)
//            }
//            if type == 0 {
//                //右边文字优先展示
//                labelRight.sizeToFit();
//                labelRight.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.right.equalToSuperview().offset(-kX_GAP);
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//                labelLeft.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalToSuperview().offset(kX_GAP)
//                    make.right.equalTo(labelRight.snp.left).offset(-kPadding)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//            } else {
//                //左边文字优先展示
//                labelLeft.sizeToFit();
//                labelLeft.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalToSuperview().offset(kX_GAP)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//
//                labelRight.snp.makeConstraints { (make) in
//                    make.centerY.equalToSuperview()
//                    make.left.equalTo(labelLeft.snp.right).offset(kPadding)
//                    make.right.equalToSuperview().offset(-kX_GAP)
//                    make.height.equalTo(kSizeArrow.height)
//                }
//            }
//        }
//    }
//
//}

//-(void)layoutSubviews{
//    [super layoutSubviews];
//
//
//    //图片+文字+文字+图片
//    self.type = self.type != nil ? self.type : @0;
//
//    CGSize arrowSize = CGSizeMake(25, 25);
//    CGFloat padding = kPadding;
//
//    //图片右
//    self.imgViewRight.frame = CGRectMake(kScreenWidth - arrowSize.width - kX_GAP, (self.contentView.maxY - arrowSize.height)/2.0, arrowSize.width, arrowSize.height);
//
//    //图片左
//    if (self.imgViewLeft.image) {
//        CGFloat scale = UIScreen.mainScreen.scale;
//        CGSize imgSize = CGSizeMake(self.imgViewLeft.image.size.width/scale, self.imgViewLeft.image.size.height/scale);
//        if (imgSize.height < kH_LABEL) imgSize = CGSizeMake(imgSize.width*(kH_LABEL/imgSize.height), kH_LABEL);
//        self.imgViewLeft.frame = CGRectMake(kX_GAP, (self.contentView.maxY - imgSize.height)*0.5, imgSize.width, imgSize.height);
//
////        self.imgViewLeft.frame = CGRectMake(kX_GAP, kY_GAP, self.contentView.maxY - kY_GAP*2, self.contentView.maxY - kY_GAP*2);
//
//    }
//
//    //labelRight右对齐
//    if (self.type.integerValue == 0) {
//        CGSize labRightSize = [self sizeWithText:self.labelRight.text font:self.labelRight.font width:CGFLOAT_MAX];
//
//        CGFloat X_right = self.imgViewRight.hidden == NO ? CGRectGetMinX(self.imgViewRight.frame) - padding - labRightSize.width : self.contentView.maxX - kX_GAP - labRightSize.width;
//        self.labelRight.frame = CGRectMake(X_right, CGRectGetMinY(self.imgViewRight.frame), labRightSize.width, CGRectGetHeight(self.imgViewRight.frame));
//
//        if (self.imgViewLeft.image) {
//            //控件1
//            self.labelLeft.frame = CGRectMake(CGRectGetMaxX(self.imgViewLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), CGRectGetMinX(self.labelRight.frame) - CGRectGetMaxX(self.imgViewLeft.frame) - padding*2, CGRectGetHeight(self.imgViewRight.frame));
//
//        }
//        else{
//            //控件1
//            self.labelLeft.frame = CGRectMake(kX_GAP, CGRectGetMinY(self.imgViewRight.frame), CGRectGetMinX(self.labelRight.frame) - padding - kX_GAP, CGRectGetHeight(self.imgViewRight.frame));
//
//        }
//
//    }
//    else{
//        //labelRight左对齐
//        CGSize labSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:CGFLOAT_MAX];
//
//        CGFloat X_left = self.imgViewLeft.image != nil ? CGRectGetMaxX(self.imgViewLeft.frame) + padding : kX_GAP;
//        self.labelLeft.frame = CGRectMake(X_left, CGRectGetMinY(self.imgViewRight.frame), labSize.width, CGRectGetHeight(self.imgViewRight.frame));
//
//        CGFloat w_maxRight = self.imgViewRight.hidden == NO ? CGRectGetMinX(self.imgViewRight.frame) : self.contentView.maxX;
//        self.labelRight.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame) + padding, CGRectGetMinY(self.imgViewRight.frame), w_maxRight - kPadding - kX_GAP - CGRectGetMaxX(self.labelLeft.frame), CGRectGetHeight(self.imgViewRight.frame));
//
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
