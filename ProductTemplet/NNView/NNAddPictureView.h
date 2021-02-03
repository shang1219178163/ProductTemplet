//
//  NNAddPictureView.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/28.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>
 
static const NSInteger kRowOfNumber = 4;

@interface NNAddPictureView : UIView

@property (nonatomic, strong) NSMutableArray *itemList;
@property (nonatomic, strong) UIViewController *parController;

@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, copy) void(^blockView)(NNAddPictureView * view, NSArray *itemList, CGSize itemSize);


@end
