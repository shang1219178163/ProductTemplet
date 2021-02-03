//
//  UITableViewEightyCell.m
//  
//
//  Created by BIN on 2018/5/8.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UITableViewEightyCell.h"
#import <NNGloble/NNGloble.h>
#import "NSObject+Helper.h"
#import "UIView+Helper.h"
#import <Masonry/Masonry.h>

@implementation UITableViewEightyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //图片
    //文字
    
    [self.contentView addSubview:self.labelLeft];
    
    [self.contentView addSubview:self.itemsView];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.itemsView.hidden = self.itemsView.items.count == 0 ? YES : NO;
    if (self.itemsView.hidden) {
        [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(5);
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        return;
    }
    
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(20);
    }];
    
    [self.itemsView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelLeft.bottom).offset(5);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(NNItemsView *)itemsView{
    if (!_itemsView) {
        _itemsView = [[NNItemsView alloc]initWithFrame:CGRectZero];
        _itemsView.numberOfRow = 4;
        _itemsView.padding = 10;
    }
    return _itemsView;
}


@end
