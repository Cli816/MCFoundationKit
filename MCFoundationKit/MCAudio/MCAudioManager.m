//
//  MCAudioManager.m
//  MCFoundationKit
//
//  Created by wang maocai on 2020/11/5.
//  Copyright © 2020 王茂. All rights reserved.
//

#import "MCAudioManager.h"

static SystemSoundID mSystemSoundId;

@implementation MCAudioManager

void mc_systemAudioCallback(SystemSoundID sound_id, void *user_data) {
    BOOL alert = user_data;
    if (alert) {
        AudioServicesPlayAlertSound(sound_id);
    } else {
        AudioServicesPlaySystemSound(sound_id);
    }
}

+ (void)playSystemSound:(NSURL *)url soundId:(SystemSoundID)soundId loop:(BOOL)loop alert:(BOOL)alert {
    [self stopSystemSound];
    if (url) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &mSystemSoundId);
    } else {
        mSystemSoundId = soundId;
    }
    if (loop) {
        AudioServicesAddSystemSoundCompletion(mSystemSoundId, NULL, NULL, mc_systemAudioCallback, (void *)alert);
    }
    mc_systemAudioCallback(mSystemSoundId, (void *)alert);
}

+ (void)stopSystemSound {
    AudioServicesRemoveSystemSoundCompletion(mSystemSoundId);
    AudioServicesDisposeSystemSoundID(mSystemSoundId);
}

@end
