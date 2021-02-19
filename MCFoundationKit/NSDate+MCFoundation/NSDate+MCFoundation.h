//
//  NSDate+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (MCFoundation)

/**
 * NSDate转时间字符串
 */
- (NSString *)dateToStrByFormat:(NSString *)formatStr byTimeZone:(NSTimeZone*)timeZone;

@end

NS_ASSUME_NONNULL_END
