//
//  BN_BaseTableViewCell.h
//  HuiZhuBang
//
//  Created by hsf on 2018/4/27.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BN_TextField.h"
#import "BN_TextView.h"
#import "BN_RadioViewZero.h"

@interface BN_BaseTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize  imgViewLeftSize;

@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UIImageView * imgViewRight;

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelRight;

@property (nonatomic, strong) UILabel * labelLeftMark;
@property (nonatomic, strong) UILabel * labelLeftSub;
@property (nonatomic, strong) UILabel * labelLeftSubMark;

@property (nonatomic, strong) BN_TextField * textField;
@property (nonatomic, strong) UIButton * btn;
@property (nonatomic, strong) BN_TextView * textView;
@property (nonatomic, strong) BN_RadioViewZero * radioView;

@property (nonatomic, strong) UIView * lineTop;

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(instancetype)cellWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;

- (id)getTextFieldRightView:(NSString *)unitString;


@end
