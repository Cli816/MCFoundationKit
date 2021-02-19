//
//  MCUITools.m
//  MCFoundationKit
//
//  Created by wang maocai on 2019/4/11.
//  Copyright © 2019 mc. All rights reserved.
//

#import "MCUITools.h"

#import <sys/utsname.h>

@implementation MCUITools

#pragma mark - 数据

+ (NSString *)convertIntegerToHexStr:(NSInteger)integer
{
    NSString *hexStr = [NSString stringWithFormat:@"%1lx", integer];
    return hexStr;
}

+ (NSData *)longValueToData:(long)value {
    Byte *byte = (Byte *)malloc(sizeof(value));
    
    byte[0] = ((value >> 56) & 0xFF);
    byte[1] = ((value >> 48) & 0xFF);
    byte[2] = ((value >> 40) & 0xFF);
    byte[3] = ((value >> 32) & 0xFF);
    byte[4] = ((value >> 24) & 0xFF);
    byte[5] = ((value >> 16) & 0xFF);
    byte[6] = ((value >> 8) & 0xFF);
    byte[7] = (value & 0xFF);
    
    NSData *data = [NSData dataWithBytes:byte length:sizeof(byte)];
    return data;
}

+ (NSInteger)getRandomInteger:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

#pragma mark - 字符串

+ (NSString *)stringPathWithSuffix:(NSString *)suffix components:(NSString *)components, ... NS_REQUIRES_NIL_TERMINATION
{
    NSMutableString *lRetStr = [NSMutableString string];
    
    NSMutableArray *lMuComponentsArray = [NSMutableArray array];
    if (components) {
//        [lMuComponentsArray addObject:components];
        [lRetStr appendString:components];
        
        va_list args;
        va_start(args, components);
        NSString *otherString = nil;
        while ((otherString = va_arg(args, NSString *)) != nil) {
            [lMuComponentsArray addObject:otherString];
        }
        va_end(args);
    }
    
    if ([lMuComponentsArray count] > 0) {
        NSString *lComponentsStr = [NSString pathWithComponents:lMuComponentsArray];
        if ([lComponentsStr length] > 0) {
//            [lRetStr appendString:lComponentsStr];
            [lRetStr appendFormat:@"/%@", lComponentsStr];
        }
    }
    if ([suffix length] > 0) {
        [lRetStr appendString:@"."];
        [lRetStr appendString:suffix];
    }
    
    return lRetStr;
}

#pragma mark - 计时器

+ (void)startCountdownTimer:(dispatch_source_t)timer timeInterval:(NSTimeInterval)timeInterval complete:(void(^)(void))completeBlock progress:(void(^)(int mSecond))progressBlock
{
    int seconds = timeInterval;
    
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    dispatch_source_set_event_handler(timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        if (interval <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                completeBlock();
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                progressBlock(interval);
            });
        }
    });
    dispatch_resume(timer);
}

+ (void)cancelCountdownTimer:(dispatch_source_t)timer
{
    if (timer) {
        dispatch_source_cancel(timer);
        timer = nil;
    }
}

#pragma mark - 系统

+ (void)exitApplication
{
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
    [self dispatchAfterLittleOnMainQueue:^{
        exit(1);
    }];
}

+ (NSString *)getCurrentDeviceModel {
   struct utsname systemInfo;
   uname(&systemInfo);
   
   NSString *deviceModel = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([deviceModel isEqualToString:@"iPhone10,1"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,4"])   return @"iPhone_8";
    if ([deviceModel isEqualToString:@"iPhone10,2"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,5"])   return @"iPhone_8_Plus";
    if ([deviceModel isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    if ([deviceModel isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    if ([deviceModel isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([deviceModel isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch (5 Gen)";
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2 (Cellular)";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4 (LTE)";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9";

    if ([deviceModel isEqualToString:@"AppleTV2,1"])      return @"Apple TV 2";
    if ([deviceModel isEqualToString:@"AppleTV3,1"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV3,2"])      return @"Apple TV 3";
    if ([deviceModel isEqualToString:@"AppleTV5,3"])      return @"Apple TV 4";

    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceModel;
}

+ (NSString *)getSystemLanguageCode
{
    NSString *languageCode = [[NSLocale preferredLanguages] firstObject];
    NSString *countryCode = [NSString stringWithFormat:@"-%@", [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]];
    if (languageCode) {
        languageCode = [languageCode stringByReplacingOccurrencesOfString:countryCode withString:@""];
    }
    return languageCode;
}

#pragma mark - UI

+ (UIWindow *)topLevelWindow
{
    UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    for (UIWindow *win in [[UIApplication sharedApplication].windows reverseObjectEnumerator]) {
        if ([win isEqual:topWindow]) {
            continue;
        }
        if (win.windowLevel > topWindow.windowLevel && win.hidden != YES) {
            topWindow = win;
        }
    }
    return topWindow;
}

+ (void)dispatchAfterLittleOnMainQueue:(void (^)(void))completeBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completeBlock) {
            completeBlock();
        }
    });
}

@end
