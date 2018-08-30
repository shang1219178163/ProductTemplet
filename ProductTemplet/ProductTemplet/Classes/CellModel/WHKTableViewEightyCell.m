//
//  WHKTableViewEightyCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/8.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewEightyCell.h"

@implementation WHKTableViewEightyCell

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
    

    CGSize sizeItemsView = [self sizeItemsViewWidth:(kScreen_width - kX_GAP*2) items:self.itemsView.items numberOfRow:4 itemHeight:0.0 padding:kY_GAP];

    //控件2
    CGRect labelLeftRect = CGRectMake(kX_GAP, kY_GAP, kScreen_width - kX_GAP*2, CGRectGetHeight(self.contentView.frame) - sizeItemsView.height - kY_GAP*3);
    self.labelLeft.frame = labelLeftRect;

    CGRect viewRect = CGRectMake(kX_GAP, CGRectGetMaxY(labelLeftRect)+kY_GAP, sizeItemsView.width, sizeItemsView.height);
    self.itemsView.frame = viewRect;

    self.itemsView.hidden = self.itemsView.items.count == 0 ? YES : NO;
    
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    
//
//    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width - kXY_GAP*2];
//    //控件2
//    CGRect labelLeftRect = CGRectMake(kXY_GAP, kY_GAP, labLeftSize.width, labLeftSize.height);
//    self.labelLeft.frame = labelLeftRect;
//
//    CGRect viewRect = CGRectMake(kXY_GAP, CGRectGetMaxY(labelLeftRect)+kY_GAP, kScreen_width - kXY_GAP*2, 0);
//    self.itemsView.frame = viewRect;
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BN_ItemsView *)itemsView{
    if (!_itemsView) {
        _itemsView = [[BN_ItemsView alloc]initWithFrame:CGRectZero];
        
        _itemsView.numberOfRow = 4;
        _itemsView.itemHeight = 0.0;
        _itemsView.padding = 10;
        _itemsView.type = @0;
        
    }
    return _itemsView;
}


@end
