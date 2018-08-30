//
//  WHKTableViewFiftyFiveCell.m
//  HuiZhuBang
//
//  Created by BIN on 2018/3/26.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewFiftyFiveCell.h"

@interface WHKTableViewFiftyFiveCell ()

@end

@implementation WHKTableViewFiftyFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
     if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字+segment
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.segmentCtrl];
    
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    //
    CGSize labLeftSize = [self sizeWithText:self.labelLeft.text font:self.labelLeft.font width:kScreen_width];
    if (self.labelLeft.attributedText) {
        labLeftSize = [self sizeWithText:self.labelLeft.attributedText font:self.labelLeft.font width:kScreen_width];
    }
    //控件
    CGFloat XGap = kX_GAP;
//    CGFloat YGap = kY_GAP;
//    CGFloat padding = 10;
    CGFloat height = 35;

    CGFloat lableLeftH = kH_LABEL;
    self.labelLeft.frame = CGRectMake(XGap, CGRectGetMidY(self.contentView.frame) - lableLeftH/2.0, labLeftSize.width, lableLeftH);
    self.segmentCtrl.frame = CGRectMake(CGRectGetMaxX(self.labelLeft.frame)+30, CGRectGetMidY(self.contentView.frame) - height/2.0, CGRectGetWidth(self.contentView.frame) - CGRectGetMaxX(self.labelLeft.frame) -30*2, height);
    
    
    CGFloat width = CGRectGetWidth(self.segmentCtrl.frame)/self.segmentCtrl.numberOfSegments;
    if (self.segmentItems.count <= self.segmentCtrl.numberOfSegments) {
        for (NSInteger i = 0; i < self.segmentCtrl.numberOfSegments; i++) {
            if (i < self.segmentItems.count) {
//                [self.segmentCtrl setTitle:self.segmentItems[i] forSegmentAtIndex:i];
                [self.segmentCtrl setWidth:width forSegmentAtIndex:i];
            }else{
//                [self.segmentCtrl removeSegmentAtIndex:i animated:YES];
            }
        }
        
    }else{
        for (NSInteger i = 0; i < self.segmentItems.count; i++) {
            if (i < self.segmentCtrl.numberOfSegments) {
//                [self.segmentCtrl setTitle:self.segmentItems[i] forSegmentAtIndex:i];
                [self.segmentCtrl setWidth:width forSegmentAtIndex:i];
            }else{
//                [self.segmentCtrl insertSegmentWithTitle:self.segmentItems[i] atIndex:i animated:YES];
            }
        }
    }

    
}

-(void)setSegmentItems:(NSArray *)segmentItems{
    _segmentItems = segmentItems;
    
//    DDLog(@"%@_%@",@(_segmentItems.count),@(self.segmentCtrl.numberOfSegments));
    
    if (_segmentItems.count <= self.segmentCtrl.numberOfSegments) {
        for (NSInteger i = 0; i < self.segmentCtrl.numberOfSegments; i++) {
            if (i < _segmentItems.count) {
                [self.segmentCtrl setTitle:_segmentItems[i] forSegmentAtIndex:i];
                
            }else{
                [self.segmentCtrl removeSegmentAtIndex:i animated:NO];
            }
        }
        
    }else{
        for (NSInteger i = 0; i < _segmentItems.count; i++) {
            if (i < self.segmentCtrl.numberOfSegments) {
                [self.segmentCtrl setTitle:_segmentItems[i] forSegmentAtIndex:i];
                
            }else{
                [self.segmentCtrl insertSegmentWithTitle:_segmentItems[i] atIndex:i animated:NO];
            }
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(UISegmentedControl *)segmentCtrl{
    if (!_segmentCtrl) {
        _segmentCtrl = [UIView createSegmentCtlWithRect:CGRectMake(0, 0, kScreen_width, 44) items:@[@"是",@"否"] selectedIndex:0 type:@"0"];
        _segmentCtrl.selectedSegmentIndex = 0;
        
    }
    return _segmentCtrl;
}

@end
