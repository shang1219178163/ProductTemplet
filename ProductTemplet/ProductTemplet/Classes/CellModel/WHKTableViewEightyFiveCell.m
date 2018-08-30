//
//  WHKTableViewEightyFiveCell.m
//  HuiZhuBang
//
//  Created by hsf on 2018/5/18.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#import "WHKTableViewEightyFiveCell.h"

@implementation WHKTableViewEightyFiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createControls];
        
    }
    return self;
}

- (void)createControls{
    
    
    [self.contentView addSubview:self.turnView];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    self.turnView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - -layz

-(BN_TurnView *)turnView{
    if (!_turnView) {
        _turnView = ({
            BN_TurnView * view = [[BN_TurnView alloc]initWithFrame:CGRectMake(kXY_GAP, kY_GAP, kScreen_width - kXY_GAP*2, 60)];
            view.backgroundColor = [UIColor greenColor];
            view.imgView.image = [UIImage imageNamed:@"测试图标.png"];
            view.list = @[@"aaaaaaaaaaaaaa",];
            view.list = @[@"11111111111",@"222222222222",@"333333333333",@"444444444444",@"555555555",@"66666666666",];
            view.interval = 1.5;
            
            view;
        });
    }
    return _turnView;
}

@end
