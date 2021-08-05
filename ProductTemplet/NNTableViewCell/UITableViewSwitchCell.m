//
//  UITableViewSwitchCell.m
//  BNTableViewCell
//
//  Created by Bin Shang on 2018/12/14.
//

#import "UITableViewSwitchCell.h"

#import <NNGloble/NNGloble.h>
#import "NSString+Helper.h"
#import "NSObject+Helper.h"
#import "UIView+Helper.h"

/**
 开关
 */
@implementation UITableViewSwitchCell

-(void)dealloc{
    [self.switchView.labelLeft removeObserver:self forKeyPath:@"text" context:nil];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.switchView];
        
        [self.switchView.labelLeft addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        if (self.hasAsterisk) {
            [self.switchView.labelLeft appendAsteriskPrefix];
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.switchView.frame = self.contentView.bounds;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (NNSwitchView *)switchView{
    if (!_switchView) {
        _switchView = [[NNSwitchView alloc]initWithFrame:self.bounds];
        _switchView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    }
    return _switchView;
}

@end
