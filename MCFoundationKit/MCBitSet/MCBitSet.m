//
//  MCBitSet.m
//  MCFoundationKit
//
//  Created by wang maocai on 2020/6/22.
//  Copyright © 2020 mc. All rights reserved.
//

#import "MCBitSet.h"
#import "MCUITools.h"

@interface MCBitSet ()

@property (nonatomic, strong) NSString *bitStr;

@end

@implementation MCBitSet

- (MCBitSet *)initWithLongArray:(NSArray *)longArray {
    self = [super init];
    if (self) {
        [self setLongArray:longArray];
    }
    return self;
}

- (void)setLongArray:(NSArray<NSNumber *> *)longArray {
    self.bitStr = nil;
    NSMutableString *bitSetStr = [NSMutableString string];
//    NSMutableData *bitSetData = [NSMutableData data];
    for (NSInteger i = [longArray count] - 1; i >= 0; i --) {
        NSNumber *num = longArray[i];
        long value = [num longValue];
        NSString *str = [NSString convertLongLongToHexStr:value];
        if ([str length] > 0) {
            [bitSetStr appendString:str];
        }
        /*
        NSData *data = [MCUITools longLongValueToData:value];
        if ([data length] > 0) {
            [bitSetData appendData:data];
        }
         */
    }
    if ([bitSetStr length] > 0) {
        self.bitStr = [bitSetStr convertHexStrToBinaryStr];
    }
    /*
    if ([bitSetData length] > 0) {
        NSString *hexStr = [MCUITools convertDataToHexStr:bitSetData];
        if ([hexStr length] > 0) {
            self.bitSr = [MCUITools convertHexStrToBinaryStr:hexStr];
        }
    }
     */
}

- (NSInteger)valueCount {
    return [self.bitStr length];
}

- (BOOL)getValue:(NSInteger)index {
    BOOL ret = NO;
    if (index >= 0 && index < [self.bitStr length]) {
        NSRange range = NSMakeRange([self.bitStr length] - index - 1, 1);
        NSString *subStr = [self.bitStr substringWithRange:range];
        ret = [subStr boolValue];
    }
    return ret;
}

- (NSString *)getAllFormatValue {
    NSMutableString *ret = [NSMutableString string];
    for (int i = 0; i < [self valueCount]; i ++) {
        NSString *str = [NSString stringWithFormat:@"%d:%@", i, [self getValue:i] ? @"true" : @"false"];
        [ret appendString:str];
        if (i != [self valueCount] - 1) {
            [ret appendString:@","];
        }
    }
    return ret;
}

@end
