//
//  UITableViewSegmentCell.m
//  Utilis
//
//  Created by BIN on 2018/10/22.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "UITableViewSegmentCell.h"
#import <NNGloble/NNGloble.h>
#import "NSObject+Helper.h"
//#import "UIView+AddView.h"
#import "UIView+Helper.h"
#import "UISegmentedControl+Helper.h"

#import "NSString+Helper.h"

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

/**
 文字+segment
 */
@implementation UITableViewSegmentCell

- (void)dealloc{
    [self.labelLeft removeObserver:self forKeyPath:@"text"];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.labelLeft];
        [self.contentView addSubview:self.segmentCtl];
        
        [self.labelLeft addObserver:self forKeyPath:@"text" options: NSKeyValueObservingOptionNew context:nil];

    }
    return self;
}

#pragma mark -observe
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        if (self.hasAsterisk) {
            [self.labelLeft appendAsteriskPrefix];
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self setupConstraint];
}

-(void)setupConstraint{
    CGSize labelLeftSize = [self.labelLeft sizeThatFits:CGSizeMake(CGFLOAT_MAX, 35)];
    [self.labelLeft makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(kX_GAP);
        make.size.equalTo(labelLeftSize);
    }];
    
    CGFloat width = self.contentView.sizeWidth - self.labelLeft.maxX - kX_GAP;
    CGFloat ctlWidth = width*0.7;
    
    [self.segmentCtl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kX_GAP);
        make.width.equalTo(ctlWidth);
        make.height.equalTo(30);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UISegmentedControl *)segmentCtl{
    if (!_segmentCtl) {
        _segmentCtl = [[UISegmentedControl alloc]initWithItems:@[@"是",@"否"]];
        _segmentCtl.selectedSegmentIndex = 0;
        
    }
    return _segmentCtl;
}

@end
