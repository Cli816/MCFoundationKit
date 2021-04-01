//
//  NSData+MCFoundation.m
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "NSData+MCFoundation.h"

@implementation NSData (MCFoundation)

- (NSString *)convertDataToHexStr {
    NSData *data = self;
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

- (NSString *)convertDataToString {
    NSData *data = self;
    NSString *lDataStr = @"";
    
    lDataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *lC0Str = [NSString stringWithFormat:@"%C", 0];
    if ([lDataStr containsString:lC0Str]) {
        NSArray *lDataStrArray = [lDataStr componentsSeparatedByString:lC0Str];
        lDataStr = [lDataStrArray firstObject];
    }
    
    return lDataStr;
}

- (NSString *)convertDataToStringPositional {
    NSData *data = self;
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

- (NSInteger)convertDataToInt {
    NSInteger lDataInt = 0;
    
    NSString *lDataStr = [self convertDataToHexStr];
    lDataInt = [lDataStr convertHexStrToInt];
    
    return lDataInt;
}

- (NSInteger)convertDataToIntegerPositional {
    NSInteger lDataInt = 0;
    
    NSString *lDataStr = [self convertDataToStringPositional];
    lDataInt = [lDataStr convertHexStrToInt];
    
    return lDataInt;
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

- (UIImage *)gifImage {
    NSData *data = self;
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

@end
