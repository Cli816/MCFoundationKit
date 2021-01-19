//
//  MCAudioManager.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/11/5.
//  Copyright © 2020 王茂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MCAudioManager : NSObject

/**
 * 播放系统铃声
 * url：指定铃声URL
 * soundId：系统音频id，如果url为空取soundId播放
 * loop：是否循环
 * alert：是否同时震动
 */
+ (void)playSystemSound:(NSURL *)url soundId:(SystemSoundID)soundId loop:(BOOL)loop alert:(BOOL)alert;
/**
 * 停止播放系统铃声
 */
+ (void)stopSystemSound;

@end
