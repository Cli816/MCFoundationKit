//
//  NSDate+MCFoundation.m
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "NSDate+MCFoundation.h"

@implementation NSDate (MCFoundation)

- (NSString *)dateToStrByFormat:(NSString *)formatStr byTimeZone:(NSTimeZone*)timeZone {
    NSDate *date = self;
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

@end
