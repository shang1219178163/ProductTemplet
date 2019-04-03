//
//  TextFromSpeechController.m
//  ProductTemplet
//
//  Created by Bin Shang on 2019/3/26.
//  Copyright © 2019 BN. All rights reserved.
//

#import "TextFromSpeechController.h"

#import <Speech/Speech.h>

#import <AVFoundation/AVFoundation.h>

//API_AVAILABLE(ios(10.0))
@interface TextFromSpeechController ()<SFSpeechRecognizerDelegate>

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) SFSpeechRecognizer *speechRecognizer;//语音识别器
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;//语音识别请求
@property (nonatomic, strong) SFSpeechRecognitionTask *recognitionTask;//语音任务管理器
@property (nonatomic, strong) AVAudioEngine *audioEngine;//语音控制器

@end


@implementation TextFromSpeechController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //发送语音认证请求(首先要判断设备是否支持语音识别功能)
//    [self requestJurisdiction];

    [UIApplication privacy:PrivacyTypeSpeech handler:^(BOOL response, NSString *name) {
        DDLog(@"privacy_%@_%@_",@(response), name);
        
    }];
    
    self.title = @"测试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.label];
    
    [self.view getViewLayer];
}

#pragma mark -SFSpeechRecognizerDelegate

/**
 当语音识别操作可用性发生改变时会被调用
 */
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available {
    self.btn.enabled = available;
    NSString *title = available ? @"开始录音" : @"语音识别不可用";
    [self.btn setTitle:title forState:UIControlStateNormal];

}

#pragma mark---停止录音
- (void)endRecording{
    [self.audioEngine stop];
    if (_recognitionRequest) {
        [_recognitionRequest endAudio];
    }
    
    if (_recognitionTask) {
        [_recognitionTask cancel];
        _recognitionTask = nil;
    }
    self.btn.enabled = NO;
}
#pragma mark---开始录音
- (void)startRecording{
    if (self.recognitionTask) {
        [self.recognitionTask cancel];
        self.recognitionTask = nil;
    }
    NSError *error;
//    bool audioBool = [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryRecord error:&error];
    bool audioBool = [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
    NSParameterAssert(!error);
    bool audioBool1= [AVAudioSession.sharedInstance setMode:AVAudioSessionModeMeasurement error:&error];
    NSParameterAssert(!error);
    bool audioBool2= [AVAudioSession.sharedInstance setActive:true withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&error];
    NSParameterAssert(!error);
    if(audioBool || audioBool1|| audioBool2) {
        NSLog(@"可以使用");
    }
    else{
        NSLog(@"这里说明有的功能不支持");
    }
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    
    self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
    self.recognitionRequest.shouldReportPartialResults = true;
    
    @weakify(self)
    //开始识别任务
    self.recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        @strongify(self);
        bool isFinal = false;
        if(result) {
            self.label.text = result.bestTranscription.formattedString;
            //语音转文本
            isFinal = result.isFinal;
        }
        if(error || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            self.recognitionRequest = nil;
            self.recognitionTask = nil;
            [self.btn setTitle:@"开始录音" forState:UIControlStateNormal];
            self.btn.enabled = true;
        }
    }];
    AVAudioFormat*recordingFormat = [inputNode outputFormatForBus:0];
    //在添加tap之前先移除上一个,不然有可能报"Terminating app due to uncaught exception 'com.apple.coreaudio.avfaudio',"之类的错误[inputNoderemoveTapOnBus:0];
    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer*_Nonnull buffer,AVAudioTime*_Nonnull when) {       @strongify(self);
        if(self.recognitionRequest) {
            [self.recognitionRequest appendAudioPCMBuffer:buffer];
        }
    }];
    [self.audioEngine prepare];
    bool startAudioEngine = [self.audioEngine startAndReturnError:&error];
    NSParameterAssert(!error);
    self.label.text = @"正在录音。。。";
    NSLog(@"%d",startAudioEngine);
}

#pragma mark---识别本地音频文件
- (void)recognizeLocalAudioFile:(UIButton*)sender {
    NSLocale *local = [NSLocale localeWithLocaleIdentifier:kLanguageCN];
    SFSpeechRecognizer *localRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:local];
    NSURL *url = [NSBundle.mainBundle URLForResource:@"录音.m4a" withExtension:nil];
    if(!url)return;
    SFSpeechURLRecognitionRequest *res =[[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
    @weakify(self)
    [localRecognizer recognitionTaskWithRequest:res resultHandler:^(SFSpeechRecognitionResult*_Nullable result,NSError*_Nullable error) {
        @strongify(self);
        if(error) {
            NSLog(@"语音识别解析失败,%@",error);
        }
        else{
            self.label.text = result.bestTranscription.formattedString;
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
#pragma mark -lazy

/**
 语音识别
 */
- (SFSpeechRecognizer*)speechRecognizer {
    if (!_speechRecognizer) {
        NSLocale *cale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-CN"];
        _speechRecognizer = [[SFSpeechRecognizer alloc]initWithLocale:cale];
        //设置代理
        _speechRecognizer.delegate = self;
    }
    return _speechRecognizer;
}

/**
 录音引擎
 */
- (AVAudioEngine *)audioEngine{
    if (!_audioEngine) {
        _audioEngine= [[AVAudioEngine alloc]init];
    }
    return _audioEngine;
}

- (UILabel *)label{
    if(!_label) {
        _label= [[UILabel alloc]init];
        _label.frame = CGRectMake(0, 140, UIScreen.mainScreen.bounds.size.width, 50);
        _label.font= [UIFont systemFontOfSize:16.0f];
        _label.numberOfLines = 0;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = UIColor.redColor;
    }
    return _label;
}

- (UIButton*)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(50,100,80,30);
        [_btn setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(handleActionBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_btn setTitle:@"开始录音" forState:UIControlStateNormal];
    }
    return _btn;
}

- (void)handleActionBtn:(id)sender{
    NSString * title = self.audioEngine.isRunning ? @"开始录音" : @"关闭";
    [_btn setTitle:title forState:UIControlStateNormal];
    
    if([self.audioEngine isRunning]) {
        [self endRecording];
    }
    else{
        [self startRecording];
    }
}


@end
    
   
