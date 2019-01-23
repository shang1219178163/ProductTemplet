
//
//  UITableViewEightyOneCell.m
//  
//
//  Created by BIN on 2018/5/9.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewEightyOneCell.h"

#import "BN_Globle.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

#import "BN_SegmentView.h"

@implementation UITableViewEightyOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGFloat width = kScreenWidth;
    UIView * view = [BN_SegmentView viewRect:CGRectMake(kX_GAP, 0, width, 40) items:self.itemManger type:@1];
    view.tag = kTAG_VIEW;
    [self.contentView addSubview:view];
    
    view.blockObject = ^(id obj, id item, NSInteger idx) {
        UIView * itemView = item;
        UIImageView * imgView = [itemView viewWithTag:kTAG_IMGVIEW];
        UILabel * label = [itemView viewWithTag:kTAG_LABEL];
        
        NSMutableDictionary * dic = self.itemManger[idx];
        [dic setObject:@(imgView.selected) forKey:BN_ItemSelected];
        
        if (self.block) {
            self.block(self ,imgView, label, idx);
        }
    };
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz


@end
