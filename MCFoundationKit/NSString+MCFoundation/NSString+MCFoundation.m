//
//  NSString+MCFoundation.m
//  MCFoundationKit
//
//  Created by wang maocai on 2020/9/22.
//  Copyright © 2020 mc. All rights reserved.
//

#import "NSString+MCFoundation.h"

@implementation NSString (MCFoundation)

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

- (NSString *)utf8Encode {
    NSString *string = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return string;
}

- (NSString *)utf8Decode {
    NSString *string = [self stringByRemovingPercentEncoding];
    return string;
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

- (id)MCJSONObject {
    return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
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

- (NSURL *)MCEncodeUrl {
    return [NSURL URLWithString:[self utf8Encode]];
}

@end
