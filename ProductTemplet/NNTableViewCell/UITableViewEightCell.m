//
//  UITableViewEightCell.m
//  
//
//  Created by BIN on 2017/8/18.
//  Copyright © 2017年 SHANG. All rights reserved.
//

#import "UITableViewEightCell.h"
#import <NNGloble/NNGloble.h>

//#define MAS_SHORTHAND
//#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface UITableViewEightCell ()
 
 
@end

@implementation UITableViewEightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    //文字1+图片+箭头
    //文字2
    [self.contentView addSubview:self.imgViewRight];
    [self.contentView addSubview:self.imgView];
    
    [self.contentView addSubview:self.labelLeft];
    [self.contentView addSubview:self.labelLeftSub];
    
    self.imgViewRight.hidden = false;
    
    self.labelLeft.font = [UIFont systemFontOfSize:15];
    self.labelLeftSub.font = [UIFont systemFontOfSize:13];        
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imgViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-kX_GAP);
        make.size.equalTo(kSizeArrow);
    }];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kPadding);
        make.bottom.equalTo(self.contentView).offset(-kPadding);
        make.right.equalTo(self.imgViewRight.left).offset(-kPadding);
        make.width.equalTo(60);
    }];
    
    NSArray *list = @[self.labelLeft, self.labelLeftSub];
    //    [list mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:kY_GAP leadSpacing:0 tailSpacing:kY_GAP];
    [list mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0 leadSpacing:kY_GAP tailSpacing:kY_GAP];
    [list makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.contentView).offset(kY_GAP);
        //        make.bottom.equalTo(self.contentView).offset(-kY_GAP);
        make.left.equalTo(self.contentView).offset(kX_GAP);
        make.right.equalTo(self.imgView.left).offset(-kPadding);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark -lazy
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.userInteractionEnabled = YES;
            view.backgroundColor = UIColor.blackColor;
            view.image = [UIImage imageNamed:@"img_failedDefault"];
            
            view;
        });
    };
    return _imgView;
}

@end
