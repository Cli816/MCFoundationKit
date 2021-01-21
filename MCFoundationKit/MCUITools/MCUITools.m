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

#pragma mark - 数据转换

+ (NSData *)convertHexStrToData:(NSString *)str
{
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:20];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

+ (NSInteger)convertHexStrToInt:(NSString *)str
{
    NSInteger lDataInt = 0;
    
    if ([str length] > 0) {
        lDataInt = strtoul(str.UTF8String, 0, 16);
    }
    
    return lDataInt;
}

+ (NSString *)convertHexStrToBinaryStr:(NSString *)hex {
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    
    NSString *binary = @"";
    for (int i=0; i<[hex length]; i++) {
        
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            
            binary = [binary stringByAppendingString:value];
        }
    }
    return binary;
}

+ (NSString *)convertDataToHexStr:(NSData *)data
{
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}

+ (NSString *)convertDataToString:(NSData *)data
{
    NSString *lDataStr = @"";
    
    lDataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *lC0Str = [NSString stringWithFormat:@"%C", 0];
    if ([lDataStr containsString:lC0Str]) {
        NSArray *lDataStrArray = [lDataStr componentsSeparatedByString:lC0Str];
        lDataStr = [lDataStrArray firstObject];
    }
    
    return lDataStr;
}

+ (NSString *)convertDataToStringPositional:(NSData *)data
{
    NSMutableString *lDataStr = [NSMutableString string];
    for (int i = 0; i < [data length]; i ++) {
        NSData *data1 = [data subdataWithRange:NSMakeRange(i, 1)];
        NSString *str1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
        NSString *lC0Str = [NSString stringWithFormat:@"%C", 0];
        if ([str1 isEqualToString:lC0Str]) {
            break;
        } else {
            [lDataStr appendString:str1];
        }
    }
    return lDataStr;
}

+ (NSInteger)convertDataToInt:(NSData *)data
{
    NSInteger lDataInt = 0;
    
    NSString *lDataStr = [self convertDataToHexStr:data];
    lDataInt = [self convertHexStrToInt:lDataStr];
    
    return lDataInt;
}

+ (NSInteger)convertDataToIntegerPositional:(NSData *)data
{
    NSInteger lDataInt = 0;
    
    NSString *lDataStr = [self convertDataToStringPositional:data];
    lDataInt = [self convertHexStrToInt:lDataStr];
    
    return lDataInt;
}

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

#pragma mark - 时间转换

+ (NSDate *)strToDate:(NSString*)strDate byFormat:(NSString *)formatStr byTimeZone:(NSTimeZone*)timeZone
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSDate *retDate = nil;
    if (strDate.length > 0) {
        if (timeZone != nil) {
            [dateFormatter setTimeZone:timeZone];
        }else{
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        }
        
        if (formatStr.length > 0) {
            [dateFormatter setDateFormat:formatStr];
        }
        retDate = [dateFormatter dateFromString:strDate];
    }
    return retDate;
}

+ (NSString *)dateToStr:(NSDate *)date byFormat:(NSString *)formatStr byTimeZone:(NSTimeZone*)timeZone
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    NSString *retStrDate = nil;
    if (date != nil) {
        if (timeZone != nil) {
            [dateFormatter setTimeZone:timeZone];
        }else{
            [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        }
        if (formatStr.length > 0) {
            [dateFormatter setDateFormat:formatStr];
        }
        retStrDate = [dateFormatter stringFromDate:date];
    }
    return retStrDate;
}

+ (NSDate *)timeStampToTime:(NSInteger)timeStamp
{
    NSDate *retDate = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return retDate;
}

+ (NSInteger)timeToTimeStamp:(NSDate *)time
{
    NSInteger retTimeInteger = [time timeIntervalSince1970];
    return retTimeInteger;
}

#pragma mark - Image

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize resultSize = CGSizeZero;
    if(str.length >0){
        if ([str respondsToSelector:@selector(sizeWithAttributes:)]) {
            NSMutableDictionary *atts = [[NSMutableDictionary alloc] init];
            [atts setObject:font forKey:NSFontAttributeName];
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:str attributes:atts];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){size.width, size.height}
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                       context:nil];
            resultSize = rect.size;
        } else {
            resultSize = [str boundingRectWithSize:CGSizeMake(size.width, size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        }
    }
    resultSize = CGSizeMake(resultSize.width + 1.f, resultSize.height + 1.f);
    return resultSize;
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size
{
    UIImage *theImage = nil;
    
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (UIImage *)imageWithCornerRadius:(CGFloat)radius image:(UIImage *)image
{
    UIImage *mImage = nil;
    
    CGRect rect = CGRectMake(0.f, 0.f, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    [image drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    mImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return mImage;
}

+ (UIImage *)imageTrimWithSize:(CGSize)size image:(UIImage *)image {
    UIImage *mImage = nil;
    
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [image drawInRect:rect];
    mImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return mImage;
}

+ (UIImage *)resizeImage:(UIImage *)image
{
    UIImage *resizeImg = image;
    
    resizeImg = [resizeImg resizableImageWithCapInsets:UIEdgeInsetsMake(resizeImg.size.height / 2.f, resizeImg.size.width / 2.f, resizeImg.size.height / 2.f, resizeImg.size.width / 2.f) resizingMode:UIImageResizingModeStretch];
    
    return resizeImg;
}

+ (void)changeButtonLayoutTypeTo:(UIToolsButtonLayoutType)type button:(UIButton *)button spacing:(CGFloat)spacing
{
    CGFloat buttonImageW = button.imageView.frame.size.width;
    CGFloat buttonImageH = button.imageView.frame.size.height;
    CGFloat buttonTitleW = button.titleLabel.frame.size.width;
    CGFloat buttonTitleH = button.titleLabel.frame.size.height;
    CGFloat buttonSpacing = spacing;
    
    switch (type) {
        case UIToolsButtonLayoutType_Vertical:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = buttonImageH / 2 + buttonSpacing / 2,
                .left = - (buttonImageW / 2),
                .bottom = - (buttonImageH / 2 + buttonSpacing / 2),
                .right = buttonImageW / 2
            };
            
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = - (buttonTitleH / 2 + buttonSpacing / 2),
                .left = buttonTitleW / 2,
                .bottom = buttonTitleH / 2 + buttonSpacing / 2,
                .right = - (buttonTitleW / 2)
            };
        }
            break;
        case UIToolsButtonLayoutType_Horizontal:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = buttonSpacing / 2,
                .bottom = 0,
                .right = - buttonSpacing / 2
            };
                
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = - buttonSpacing / 2,
                .bottom = 0,
                .right = buttonSpacing / 2
            };
        }
            break;
        case UIToolsButtonLayoutType_Cover:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = - (buttonImageW / 2),
                .bottom = 0,
                .right = buttonImageW / 2
            };
            
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = buttonTitleW / 2,
                .bottom = 0,
                .right = - (buttonTitleW / 2)
            };
        }
            break;
        case UIToolsButtonLayoutType_Reversal:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = - (buttonImageW + buttonSpacing / 2),
                .bottom = 0,
                .right = (buttonImageW + buttonSpacing / 2)
            };
                
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = (buttonTitleW + buttonSpacing / 2),
                .bottom = 0,
                .right = - (buttonTitleW + buttonSpacing / 2)
            };
        }
            break;
        case UIToolsButtonLayoutType_VerticalReversal:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = - (buttonImageH / 2 + buttonSpacing / 2),
                .left = - (buttonImageW / 2),
                .bottom = buttonImageH / 2 + buttonSpacing / 2,
                .right = buttonImageW / 2
            };
            
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = buttonTitleH / 2 + buttonSpacing / 2,
                .left = buttonTitleW / 2,
                .bottom = - (buttonTitleH / 2 + buttonSpacing / 2),
                .right = - (buttonTitleW / 2)
            };
        }
            break;
            
        default:
            break;
    }
}

+ (void)exitApplication
{
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
    [self dispatchAfterLittleOnMainQueue:^{
        exit(1);
    }];
}

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

+ (NSString *)getSystemLanguageCode
{
    NSString *languageCode = [[NSLocale preferredLanguages] firstObject];
    NSString *countryCode = [NSString stringWithFormat:@"-%@", [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode]];
    if (languageCode) {
        languageCode = [languageCode stringByReplacingOccurrencesOfString:countryCode withString:@""];
    }
    return languageCode;
}

+ (void)setLabelAttributedTexts:(NSArray<NSString *> *)texts fonts:(NSArray<UIFont *> *)fonts colors:(NSArray<UIColor *> *)colors label:(UILabel *)label {
    if (label != nil) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@""];
        for (int i = 0; i < [texts count]; i ++) {
            NSString *text = texts[i];
            if ([text length] > 0) {
                NSMutableAttributedString *lAttStr = [[NSMutableAttributedString alloc] initWithString:text];
                UIFont *font = nil;
                if (i < [fonts count]) {
                    font = fonts[i];
                }
                UIColor *color = nil;
                if (i < [colors count]) {
                    color = colors[i];
                }
                NSMutableDictionary *attStrDic = [NSMutableDictionary dictionary];
                if (font != nil) {
                    [attStrDic setObject:font forKey:NSFontAttributeName];
                }
                if (color != nil) {
                    [attStrDic setObject:color forKey:NSForegroundColorAttributeName];
                }
                if ([attStrDic count] > 0) {
                    [lAttStr addAttributes:attStrDic range:NSMakeRange(0, [text length])];
                }
                if ([lAttStr length] > 0) {
                    [attStr appendAttributedString:lAttStr];
                }
            }
        }
        label.attributedText = attStr;
    }
}

+ (NSInteger)getRandomInteger:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

+ (UIImage *)gifImageWithData:(NSData *)data {
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t count = CGImageSourceGetCount(source);
    if (count <= 1) {
        return [[UIImage alloc] initWithData:data];
    }
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval duration = 0.0f;
    for (size_t i = 0; i < count; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!imageRef) {
            continue;
        }
        @autoreleasepool {
            CGColorSpaceModel imageColorSpaceModel = CGColorSpaceGetModel(CGImageGetColorSpace(imageRef));
            CGColorSpaceRef colorspaceRef = CGImageGetColorSpace(imageRef);
            BOOL unsupportedColorSpace = (imageColorSpaceModel == kCGColorSpaceModelUnknown ||
                                          
                                          imageColorSpaceModel == kCGColorSpaceModelMonochrome ||
                                          
                                          imageColorSpaceModel == kCGColorSpaceModelCMYK ||
                                          
                                          imageColorSpaceModel == kCGColorSpaceModelIndexed);
            if (unsupportedColorSpace) {
                colorspaceRef = CGColorSpaceCreateDeviceRGB();
                CFAutorelease(colorspaceRef);
            }
            size_t width = CGImageGetWidth(imageRef);
            size_t height = CGImageGetHeight(imageRef);
            size_t bytesPerRow = 4 * width;
            CGContextRef context = CGBitmapContextCreate(NULL,width,height,8,bytesPerRow,colorspaceRef,kCGBitmapByteOrderDefault|kCGImageAlphaNoneSkipLast);
            if (context != NULL) {
                CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
                CGImageRef imageRefWithoutAlpha = CGBitmapContextCreateImage(context);
                CGContextRelease(context);
                CGImageRelease(imageRef);
                imageRef = imageRefWithoutAlpha;
            }
        }
        
        float frameDuration = 0.1f;
        CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, i, nil);
        NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
        NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
        NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
        if (delayTimeUnclampedProp) {
            frameDuration = [delayTimeUnclampedProp floatValue];
        } else {
            NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
            if (delayTimeProp) {
                frameDuration = [delayTimeProp floatValue];
            }
        }
        
        CFRelease(cfFrameProperties);
        duration += frameDuration;
        [images addObject:[UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
        CGImageRelease(imageRef);
    }
    
    if (!duration) {
        duration = (1.0f / 10.0f) * count;
    }
    UIImage *animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    
    CFRelease(source);
    
    return animatedImage;
}

+ (BOOL)isNumStr:(NSString*)str isStrictNum:(BOOL)isStrictNum decimal:(unsigned int)decimal maxValue:(NSNumber *)maxValue {
    NSString *iRegexStr = @"0123456789";
    if (decimal > 0) {
        iRegexStr = @"01234567890.";
    }
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:iRegexStr] invertedSet];
    NSString *filtered = [[str componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [str isEqualToString:filtered];
    if (canChange) {
        if (decimal > 0){
            NSArray *sperateArray = [str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
            if (sperateArray.count > 2) {
                return NO;
            }
            if (sperateArray.count == 2) {
                NSString *decimalStr = [sperateArray objectAtIndex:1];
                if (decimalStr.length > decimal) {
                    return NO;
                }
            }
        }
        if (isStrictNum == YES) {
            if (str.length > 0) {
                NSString *firstChar = [str substringWithRange:NSMakeRange(0, 1)];
                if ([firstChar isEqualToString:@"."]) {
                    return NO;
                }
            }
            if (str.length > 1) {
                NSString *firstChar = [str substringWithRange:NSMakeRange(0, 1)];
                if ([firstChar isEqualToString:@"0"]) {
                    NSString *secondChar = [str substringWithRange:NSMakeRange(1, 1)];
                    if (![secondChar isEqualToString:@"."]) {
                        return NO;
                    }
                }
            }
        }
        if (maxValue != nil) {
            if ([str floatValue] > [maxValue floatValue]) {
                return NO;
            }
        }
        return YES;
    } else {
        return NO;
    }
}

+ (void)textInputCheck:(UITextField *)textField maxStrLength:(int)maxStrLength
{
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    NSString *toBeString = textField.text;
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > maxStrLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxStrLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxStrLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxStrLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

+ (void)dispatchAfterLittleOnMainQueue:(void (^)(void))completeBlock {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.005 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completeBlock) {
            completeBlock();
        }
    });
}

+ (NSData *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength {
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (data.length > maxLength) {
        CGFloat max = 1;
        CGFloat min = 0;
        NSData *compressData = nil;
        for (int i = 0; i < 6; i ++) {
            CGFloat compression = (max + min) / 2;
            compressData = UIImageJPEGRepresentation(image, compression);
            if (compressData.length < maxLength * 0.9) {
                min = compression;
            } else if (compressData.length > maxLength) {
                max = compression;
            } else {
                break;
            }
        }
        if (compressData) {
            data = compressData;
        }
    }
    return data;
}

@end
