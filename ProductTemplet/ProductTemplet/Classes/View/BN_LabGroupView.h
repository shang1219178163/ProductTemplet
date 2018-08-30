//
//  BN_LabGroupView.h
//  ChildViewControllers
//
//  Created by hsf on 2018/4/11.
//  Copyright © 2018年 BIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BN_LabGroupView : UIView

@property (nonatomic, strong) NSArray *titleList;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, strong) NSNumber *style;

@property (nonatomic, copy) void(^block)(BN_LabGroupView * view, UILabel * label, NSInteger idx);

-(instancetype)initWithFrame:(CGRect)frame;


@end
