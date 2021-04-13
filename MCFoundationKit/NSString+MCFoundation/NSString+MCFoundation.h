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
 * 字符串路径拼接
 * suffix -> 后缀名，例如"html"、"png"，可以为nil
 */
+ (NSString *)stringPathWithSuffix:(NSString *)suffix components:(NSString *)components, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * UTF8编码
 */
- (NSString *)utf8Encode;

/**
 * UTF8解码
 */
- (NSString *)utf8Decode;

/**
 * UTF8 Encode Url
 */
- (NSURL *)MCEncodeUrl;

/**
 * Json字符串转换成NSArray或NSDictionary
 */
- (id)MCJSONObject;

/**
 * 删除首尾空格和换行
 */
- (NSString *)removeHTSpaceAndNewlineCharacter;

/**
 * 删除所有空格和换行
 */
- (NSString *)removeAllSpaceAndNewlineCharacter;

/**
 * 计算字符串Size
 */
- (CGSize)strSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 * 时间字符串转NSDate
 */
- (NSDate *)strToDateByFormat:(NSString *)formatStr byTimeZone:(NSTimeZone *)timeZone;

/**
 * isStrictNum:严格数字检查，不能出现020，.2的情况
 * decimal:小数位数
 * maxValue: <=
 */
- (BOOL)checkNumByStrictNum:(BOOL)isStrictNum decimal:(unsigned int)decimal maxValue:(NSNumber *)maxValue;

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
 * 10进制转16进制
 * 32位机器的NSInteger为int和long一样都为4字节，有可能溢出，long long为8字节
 * 64位机器的NSInteger为long和long long一样都是8字节
 * 所以这里改为long long，不用NSInteger，多占用些空间，可以适配32位机器
 */
+ (NSString *)convertLongLongToHexStr:(long long)value;

/**
 * 颜色字符串转换成UIColor
 */
- (UIColor *)colorWithAlpha:(CGFloat)alpha;

/**
 * 首字母小写
 */
- (NSString *)MCFirstCharLower;

/**
 * 首字母大写
 */
- (NSString *)MCFirstCharUpper;

/**
 * 转换成半角字符
 */
- (NSString *)toSBCCode;

/**
 * 删除特殊表情符号
 */
- (NSString *)removeEmoji;

@end
