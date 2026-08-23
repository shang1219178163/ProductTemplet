//
//  NNGridMenuView.m
//  ProductTemplet
//
//  Created by BIN on 2026/8/8.
//  Copyright © 2026 BN. All rights reserved.
//

#import "NNGridMenuView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation NNGridMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _numberOfColumn = 3;
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

+ (CGFloat)heightWithItemCount:(NSInteger)count
                         width:(CGFloat)width
               numberOfColumn:(NSInteger)numberOfColumn {
    if (count <= 0 || width <= 0 || numberOfColumn <= 0) {
        return 0;
    }
    NSInteger rows = (count + numberOfColumn - 1) / numberOfColumn;
    CGFloat itemSide = floor(width / numberOfColumn);
    return itemSide * rows;
}

- (void)setItems:(NSArray<NSArray *> *)items {
    _items = [items copy];
    [self reloadItems];
}

- (void)setNumberOfColumn:(NSInteger)numberOfColumn {
    _numberOfColumn = MAX(1, numberOfColumn);
    [self reloadItems];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutItemFrames];
}

- (void)reloadItems {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    NSInteger colCount = MAX(1, self.numberOfColumn);
    CGFloat width = CGRectGetWidth(self.bounds);
    if (width <= 0) {
        width = UIScreen.mainScreen.bounds.size.width;
    }
    CGFloat itemSide = floor(width / colCount);
    NSInteger rows = (self.items.count + colCount - 1) / colCount;
    CGRect frame = self.frame;
    frame.size.height = itemSide * rows;
    frame.size.width = width;
    self.frame = frame;

    for (NSInteger i = 0; i < self.items.count; i++) {
        NSArray *array = self.items[i];
        if (array.count < 2) { continue; }

        CGFloat x = itemSide * (i % colCount);
        CGFloat y = itemSide * (i / colCount);
        UIView *sender = [[UIView alloc] initWithFrame:CGRectMake(x, y, itemSide, itemSide)];
        sender.tag = i;
        sender.layer.borderWidth = 0.5;
        sender.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;

        CGFloat iconSide = 48;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((itemSide - iconSide) / 2.0, 18, iconSide, iconSide)];
        NSString *imageObj = [NSString stringWithFormat:@"%@", array[1]];
        if ([imageObj hasPrefix:@"http"]) {
            [icon sd_setImageWithURL:[NSURL URLWithString:imageObj] placeholderImage:nil];
        } else {
            icon.image = [UIImage imageNamed:imageObj];
        }
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [sender addSubview:icon];

        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(4, CGRectGetMaxY(icon.frame) + 8, itemSide - 8, 20)];
        lab.text = [NSString stringWithFormat:@"%@", array[0]];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = UIColor.darkTextColor;
        lab.adjustsFontSizeToFitWidth = YES;
        [sender addSubview:lab];

        __weak typeof(self) weakSelf = self;
        [sender addGestureTap:^(UITapGestureRecognizer * _Nonnull reco) {
            __strong typeof(weakSelf) self = weakSelf;
            if (!self.block) { return; }
            NSInteger idx = reco.view.tag;
            if (idx < 0 || idx >= (NSInteger)self.items.count) { return; }
            self.block(self, idx, self.items[idx]);
        }];
        [self addSubview:sender];
    }
}

- (void)layoutItemFrames {
    NSInteger colCount = MAX(1, self.numberOfColumn);
    CGFloat width = CGRectGetWidth(self.bounds);
    if (width <= 0 || self.items.count == 0) { return; }

    CGFloat itemSide = floor(width / colCount);
    for (UIView *sender in self.subviews) {
        NSInteger i = sender.tag;
        CGFloat x = itemSide * (i % colCount);
        CGFloat y = itemSide * (i / colCount);
        sender.frame = CGRectMake(x, y, itemSide, itemSide);

        UIImageView *icon = nil;
        UILabel *lab = nil;
        for (UIView *sub in sender.subviews) {
            if ([sub isKindOfClass:UIImageView.class]) { icon = (UIImageView *)sub; }
            if ([sub isKindOfClass:UILabel.class]) { lab = (UILabel *)sub; }
        }
        CGFloat iconSide = 48;
        icon.frame = CGRectMake((itemSide - iconSide) / 2.0, 18, iconSide, iconSide);
        lab.frame = CGRectMake(4, CGRectGetMaxY(icon.frame) + 8, itemSide - 8, 20);
    }
}

@end
