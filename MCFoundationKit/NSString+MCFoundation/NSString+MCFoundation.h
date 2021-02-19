//
//  NSString+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/9/22.
//  Copyright © 2020 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (MCFoundation)

/**
 * 转换成半角字符
 */
- (NSString *)toSBCCode;

/**
 * 删除特殊表情符号
 */
- (NSString *)removeEmoji;

/**
 * UTF8编码
 */
- (NSString *)utf8Encode;

/**
 * UTF8解码
 */
- (NSString *)utf8Decode;

/**
 * 删除首尾空格和换行
 */
- (NSString *)removeHTSpaceAndNewlineCharacter;

/**
 * 删除所有空格和换行
 */
- (NSString *)removeAllSpaceAndNewlineCharacter;

/**
 * Json字符串转换成NSArray或NSDictionary
 */
- (id)MCJSONObject;

/**
 * 首字母小写
 */
- (NSString *)MCFirstCharLower;

/**
 * 首字母大写
 */
- (NSString *)MCFirstCharUpper;

/**
 * UTF8 Encode Url
 */
- (NSURL *)MCEncodeUrl;

/**
 * 16进制转NSData
*/
- (NSData *)convertHexStrToData;

/**
 * 16进制转10进制
 */
- (NSInteger)convertHexStrToInt;

/**
 * 16进制字符串转2进制字符串
 */
- (NSString *)convertHexStrToBinaryStr;

/**
 * 时间字符串转NSDate
 */
- (NSDate *)strToDateByFormat:(NSString *)formatStr byTimeZone:(NSTimeZone *)timeZone;

/**
 * 颜色字符串转换成UIColor
 */
- (UIColor *)colorWithAlpha:(CGFloat)alpha;

/**
 * 计算字符串Size
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 * isStrictNum:严格数字检查，不能出现020，.2的情况
 * decimal:小数位数
 * maxValue: <=
 */
- (BOOL)checkNumByStrictNum:(BOOL)isStrictNum decimal:(unsigned int)decimal maxValue:(NSNumber *)maxValue;

@end
