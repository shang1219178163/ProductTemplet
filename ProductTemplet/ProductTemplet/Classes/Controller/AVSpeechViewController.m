//
//  AVSpeechViewController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/3/20.
//  Copyright © 2019 BN. All rights reserved.
//

#import "AVSpeechViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AVSpeechSynthesizer+Helper.h"


@interface AVSpeechViewController ()<AVSpeechSynthesizerDelegate>
@property (nonatomic, strong) NSArray *strArray;
@property (nonatomic, strong) NSArray *voiceArray;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *btn;


@end

@implementation AVSpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.btn];
    
    [self.view getViewLayer];
    
    self.strArray = @[@"单车欲问边，属国过居延。",
                     @"征蓬出汉塞，归雁入胡天。",
                     @"大漠孤烟直，长河落日圆，",
                     @"萧关逢候骑，都护在燕然。",
                     @"A solitary carriage to the frontiers bound,",
                     @"An envoy with no retinue around,",
                     @"A drifting leaf from proud Cathy,",
                     @"With geese back north on a hordish day.",
                     @"A smoke hangs straight on the desert vast,",
                     @"A sun sits round on the endless stream.",
                     @"A horseman bows by a fortress passed:",
                     @"The general’s at the north extreme!"];

}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.label.superview);
        make.width.equalTo(self.label.superview);
        make.height.equalTo(40);
    }];
    
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.bottom).offset(50);
        make.left.right.height.equalTo(self.label);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (int i = 0; i < self.strArray.count;  i ++) {
        NSString * voiceLanguge = i < 8 ? @"zh-CN" : @"en-US";
        AVSpeechUtterance *utterance = AVSpeechUtteranceDefault(self.strArray[i], voiceLanguge);
        //开始播放
        [self.synthesizer speakUtterance:utterance];
    }
}


#pragma mark - -AVSpeechSynthesizerDelegate
//开始朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
//    NSLog(@"%@->%@",NSStringFromSelector(_cmd),utterance.speechString);
}
//结束朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
//    NSLog(@"%@->%@",NSStringFromSelector(_cmd),utterance.speechString);
    
}
//暂停朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
//    NSLog(@"%@->%@",NSStringFromSelector(_cmd),utterance.speechString);
}
//继续朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
//    NSLog(@"%@->%@",NSStringFromSelector(_cmd),utterance.speechString);
}
//取消朗读的代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
//    NSLog(@"%@->%@",NSStringFromSelector(_cmd),utterance.speechString);
}
//将要播放的语音文字
- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    NSLog(@"%@_%@_%@_%@_",NSStringFromSelector(_cmd),NSStringFromRange(characterRange),utterance.speechString, [utterance.speechString substringWithRange:characterRange]);
    self.label.text = utterance.speechString;
}
#pragma mark - - lazy

-(AVSpeechSynthesizer *)synthesizer{
    if (!_synthesizer) {
        _synthesizer = [[AVSpeechSynthesizer alloc]init];
        _synthesizer.delegate = self;
        
    }
    return _synthesizer;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

-(UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"Pause" forState:UIControlStateNormal];
        [_btn setTitleColor:UIColor.themeColor forState:UIControlStateNormal];

        @weakify(self);
        [_btn addActionHandler:^(UIControl * _Nonnull control) {
            @strongify(self);
            UIButton * view = (UIButton *)control;
            view.selected = !view.isSelected;

            if (view.isSelected == false) {
                [view setTitle:@"Pause" forState:UIControlStateNormal];
                [self.synthesizer continueSpeaking];
                
            } else {
                [view setTitle:@"Play" forState:UIControlStateNormal];
                [self.synthesizer pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end
