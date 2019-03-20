//
//  AVSpeechSynthesizer+Helper.h
//  AVFoundation-语音朗读
//
//  Created by Bin Shang on 2019/3/20.
//  Copyright © 2019 Frank.Zhang. All rights reserved.
//

//#import <AVFAudio/AVFAudio.h>
#import <AVFoundation/AVFoundation.h>


@interface AVSpeechSynthesizer (Helper)

/**
 [源]发音
 
 @param speechString 发音字符串
 @param voiceLanguage 默认 @"zh-CN"
 @param rate 语速0.0f~1.0f
 @param volume 音量
 @param pitchMultiplier 声音的音调0.5f~2.0f
 @param preUtteranceDelay 播放上一句之前需要多久
 @param postUtteranceDelay 播放下下一句话的时候有多长时间的延迟
 @return 发音实例
 */
AVSpeechUtterance * AVSpeechUtteranceParam(NSString *speechString, NSString *voiceLanguage, float rate, float volume, float pitchMultiplier, NSTimeInterval preUtteranceDelay, NSTimeInterval postUtteranceDelay);

/**
 发音(默认语速,音量,音调)
 */
AVSpeechUtterance * AVSpeechUtteranceDefault(NSString *speechString, NSString *voiceLanguage);

@end

