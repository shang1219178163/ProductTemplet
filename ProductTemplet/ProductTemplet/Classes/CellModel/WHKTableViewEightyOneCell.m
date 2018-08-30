
//
//  WHKTableViewEightyOneCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/9.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewEightyOneCell.h"

#import "BN_SegmentView.h"

@implementation WHKTableViewEightyOneCell

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
    
    
    CGFloat width = kScreen_width;
    UIView * view = [BN_SegmentView viewWithRect:CGRectMake(kXY_GAP, 0, width, 40) items:self.itemManger type:@1];
    view.tag = kTAG_VIEW;
    [self.contentView addSubview:view];
    
    view.blockObject = ^(id obj, id item, NSInteger idx) {
        UIView * itemView = item;
        UIImageView * imgView = [itemView viewWithTag:kTAG_IMGVIEW];
        UILabel * label = [itemView viewWithTag:kTAG_LABEL];
        
        NSMutableDictionary * dic = self.itemManger[idx];
        [dic setObject:@(imgView.selected) forKey:BN_ItemSelected];
        
        if (self.block) {
            self.block(imgView, label, idx);
        }
    };
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz


@end
