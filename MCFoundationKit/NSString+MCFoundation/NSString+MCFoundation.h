//
//  NSString+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/9/22.
//  Copyright © 2020 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
