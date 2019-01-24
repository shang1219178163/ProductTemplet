//
//  AdapterViewController.m
//  ProductTemplet
//
//  Created by BIN on 2018/5/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "AdapterViewController.h"

#import "NSArray+Helper.h"
#import "UIView+Helper.h"

#import "AVPlayerProtocol.h"
#import "AVPlayer.h"
#import "PlayerAdapter.h"

@interface AdapterViewController ()

@property (nonatomic, strong) id<AVPlayerProtocol> player;

@property (nonatomic, strong) UIButton *btnIjkplayer;
@property (nonatomic, strong) UIButton *btnAVPlayer;

@property (nonatomic, strong) UILabel *lbState;


@property (nonatomic, strong) NSArray *itemList;

@end

@implementation AdapterViewController

-(NSArray *)itemList{
    if (!_itemList) {
        _itemList = [NSArray arrayItemPrefix:@"btn_" startIndex:0 count:6 type:@0];
        _itemList = @[@"AV",@"IJ",@"tip",@"...",@"...",@"...",];
    }
    return _itemList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect = CGRectMake(20, 20, kScreenWidth - 20*2, 0);
    UIView * containView = [UIView createViewRect:rect items:self.itemList numberOfRow:4 itemHeight:30 padding:10 type:@0 handler:^(id obj, id item, NSInteger idx) {
        [self handleActionBtn:item];
        
    }];
    
    
    containView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:containView];
    
    rect = CGRectMake((kScreenWidth - 200)/2.0, CGRectGetMaxY(containView.frame)+20, 200, 30);
    UILabel * label = [UIView createLabelRect:rect text:@"tips" textColor:nil tag:0 type:@0 font:16 backgroudColor:UIColor.greenColor alignment:NSTextAlignmentCenter];
    [self.view addSubview:label];
    self.lbState = label;
    
    self.btnAVPlayer = (UIButton *)containView.subviews[0];
    self.btnIjkplayer = (UIButton *)containView.subviews[1];

    [self.view getViewLayer];
    
    DDLog(@"%@",containView.subviews);
    
}

- (void)handleActionBtn:(UIButton *)sender{
    DDLog(@"__%@",@(sender.tag));
    switch (sender.tag) {
        case 0:
        {
            sender.selected = YES;
            _btnIjkplayer.selected = NO;
            
            if (_player) {
                _player = nil;
            }
            
            _player = [[AVPlayer alloc] init]; // 之前的旧代码
            [self.btnAVPlayer setTitle:@"AVPlayer" forState:UIControlStateSelected];
            
        }
            break;
        case 1:
        {
            sender.selected = YES;
            _btnAVPlayer.selected = NO;
            
            if (_player) {
                _player = nil;
            }
            Ijkplayer *ijkplayer = [[Ijkplayer alloc] init]; //新代码
            _player = [[PlayerAdapter alloc] initWithIjkplayer:ijkplayer];
            [self.btnIjkplayer setTitle:@"IJKPlayer" forState:UIControlStateSelected];

        }
            break;
        case 3:
        {
            self.lbState.text = _player ? [_player a_play] : @"播放器为空_"; // 之前的旧代码
 
        }
            break;
        case 4:
        {
            self.lbState.text = _player ? [_player a_pause] : @"播放器为空__"; // 之前的旧代码
        }
            break;
        case 5:
        {
            self.lbState.text = _player ? [_player a_stop] : @"播放器为空___"; // 之前的旧代码

        }
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
