
//
//  UICTViewCellOne.m
//  
//
//  Created by BIN on 2018/4/13.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "UICTViewCellOne.h"
#import <NNCategoryPro/NNCategoryPro.h>
#import "Masonry.h"

@implementation UICTViewCellOne

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        /*
         图片
         文字
         */
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.label];
        
        self.imgView.backgroundColor = UIColor.whiteColor;
        self.label.numberOfLines = 1;
        self.label.adjustsFontSizeToFitWidth = YES;
        self.label.backgroundColor = UIColor.whiteColor;
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];

    if (!self.label.text || self.label.hidden == true){
        [self.imgView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        return;
    }
    
    if (!self.imgView.image || self.imgView.hidden == true){
        [self.label makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        return;
    }
    
    if (self.contentView.sizeWidth == self.contentView.sizeHeight) {
        [self.label makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    else{
        if (self.contentView.sizeWidth < self.contentView.sizeHeight) {
            [self.imgView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.left.right.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView).offset(-kH_LABEL);
            }];

            [self.label makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imgView.bottom);
                make.left.right.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView);
            }];
        }
        else{
            [self.imgView makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.left.bottom.equalTo(self.contentView);
                make.width.equalTo(self.contentView.sizeHeight);
            }];

            [self.label makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView);
                make.left.equalTo(self.imgView.right).offset(5);
                make.right.equalTo(self.contentView);
                make.bottom.equalTo(self.contentView);
            }];
        }
    }
}


//-(void)drawRect:(CGRect)rect{
//    [super drawRect:rect];
//
//    [[UIImage imageNamed:@"bug.png"] drawInRect:rect];
//
//}

#pragma mark - -layz

@end
