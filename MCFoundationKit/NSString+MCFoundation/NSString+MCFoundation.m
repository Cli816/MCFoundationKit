//
//  NSString+MCFoundation.m
//  MCFoundationKit
//
//  Created by wang maocai on 2020/9/22.
//  Copyright © 2020 mc. All rights reserved.
//

#import "NSString+MCFoundation.h"

@implementation NSString (MCFoundation)

+ (NSString *)stringPathWithSuffix:(NSString *)suffix components:(NSString *)components, ... NS_REQUIRES_NIL_TERMINATION {
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

- (NSString *)utf8Encode {
    NSString *string = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return string;
}

- (NSString *)utf8Decode {
    NSString *string = [self stringByRemovingPercentEncoding];
    return string;
}

- (NSURL *)MCEncodeUrl {
    return [NSURL URLWithString:[self utf8Encode]];
}

- (id)MCJSONObject {
    return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
}

- (NSString *)removeHTSpaceAndNewlineCharacter {
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return string;
}

- (NSString *)removeAllSpaceAndNewlineCharacter {
    NSString *string = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return string;
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    NSString *str = self;
    CGSize resultSize = CGSizeZero;
    if(str.length > 0){
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
    resultSize = CGSizeMake(resultSize.width, resultSize.height);
//    resultSize = CGSizeMake(resultSize.width + 1, resultSize.height + 1);
    return resultSize;
}

- (NSDate *)strToDateByFormat:(NSString *)formatStr byTimeZone:(NSTimeZone *)timeZone {
    NSString *strDate = self;
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

- (BOOL)checkNumByStrictNum:(BOOL)isStrictNum decimal:(unsigned int)decimal maxValue:(NSNumber *)maxValue {
    NSString *str = self;
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

- (NSData *)convertHexStrToData {
    NSString *str = self;
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

- (NSInteger)convertHexStrToInt {
    NSString *str = self;
    NSInteger lDataInt = 0;
    
    if ([str length] > 0) {
        lDataInt = strtoul(str.UTF8String, 0, 16);
    }
    
    return lDataInt;
}

- (NSString *)convertHexStrToBinaryStr {
    NSString *hex = self;
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

+ (NSString *)convertIntegerToHexStr:(NSInteger)integer {
    NSString *hexStr = [NSString stringWithFormat:@"%1lx", integer];
    return hexStr;
}

- (UIColor *)colorWithAlpha:(CGFloat)alpha {
    NSString *color = self;
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

- (NSString *)MCFirstCharLower {
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

- (NSString *)MCFirstCharUpper {
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

- (NSString *)toSBCCode {
    NSMutableString *string = [NSMutableString stringWithUTF8String:""];
    for (NSInteger index = 0; index < [self length]; index ++) {
        unichar tChar = [self characterAtIndex:index];
        if (tChar > 65248) {
            tChar -= 65248;
            [string appendString:[NSString stringWithFormat:@"%c",tChar]];
        } else {
            [string appendString:[self substringWithRange:NSMakeRange(index, 1)]];
        }
    }
    return string;
}

- (NSString *)removeEmoji {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *string = [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:@""];
    return string;
}

@end
