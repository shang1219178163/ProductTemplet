//
//  UITableViewSevenCell.m
//  
//
//  Created by BIN on 2017/8/18.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewSevenCell.h"
#import "BN_Globle.h"
#import "NSObject+Helper.h"

@interface UITableViewSevenCell ()

@end

@implementation UITableViewSevenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //平行多个label
    
    [self.contentView addSubview:self.groupView];

}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.groupView.frame = self.contentView.frame;
    self.groupView.itemSize = CGSizeMake(CGRectGetWidth(self.groupView.frame)/self.groupView.titleList.count, self.contentView.maxY);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - - layz

- (BN_LabGroupView *)groupView{
    if (!_groupView) {
        _groupView = [[BN_LabGroupView alloc]initWithFrame:self.contentView.frame];
        
    }
    return _groupView;
}

@end
