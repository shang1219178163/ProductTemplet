//
//  UICTViewCellEight.m
//  
//
//  Created by Bin Shang on 2019/8/21.
//  Copyright © 2019 irain. All rights reserved.
//

#import "UICTViewCellEight.h"
#import <NNCategoryPro/NNCategoryPro.h>
#import "Masonry.h"

@implementation UICTViewCellEight

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        /*
         文字
         图片
         文字
         */
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.labTop];
        [self.contentView addSubview:self.labBottom];

        self.imgView.backgroundColor = UIColor.whiteColor;
//        self.labTop.numberOfLines = 1;
//        self.labBottom.numberOfLines = 1;

        self.labTop.adjustsFontSizeToFitWidth = YES;
        self.labBottom.adjustsFontSizeToFitWidth = YES;

//        self.label.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.labTop sizeToFit];
    [self.labTop makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(self.labTop.sizeHeight);
    }];
    
    [self.labBottom sizeToFit];
    [self.labBottom makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(self.labBottom.sizeHeight);
    }];
    
    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labTop.bottom);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.labBottom.top);
    }];
    
}

#pragma mark - -layz

- (UILabel *)labTop{
    if (!_labTop) {
        _labTop = ({
            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            view.font = [UIFont systemFontOfSize:15];
            view.textColor = UIColor.grayColor;
            view.textAlignment = NSTextAlignmentCenter;
            
            view.numberOfLines = 0;
            view.userInteractionEnabled = YES;
            view.backgroundColor = UIColor.greenColor;
            view.tag = kTAG_LABEL;
            view;
        });
    }
    return _labTop;
}

- (UILabel *)labBottom{
    if (!_labBottom) {
        _labBottom = ({
            UILabel * view = [[UILabel alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
            
            view.font = [UIFont systemFontOfSize:15];
            view.textColor = UIColor.grayColor;
            view.textAlignment = NSTextAlignmentCenter;
            
            view.numberOfLines = 0;
            view.userInteractionEnabled = YES;
            view.backgroundColor = UIColor.greenColor;
            view.tag = kTAG_LABEL;
            view;
        });
    }
    return _labBottom;
}


@end

