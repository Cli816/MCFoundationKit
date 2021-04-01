//
//  NSData+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MCFoundationKit/NSString+MCFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (MCFoundation)

/**
 * NSData转16进制
 */
- (NSString *)convertDataToHexStr;

/**
 * 转换NSData->16进制字符串
 * 如果存在\0，以\0为结束符
*/
- (NSString *)convertDataToString;

/**
 * 按位转换NSData->16进制字符串
 * 如果存在\0，以\0为结束符
*/
- (NSString *)convertDataToStringPositional;

/**
 * NSData转10进制
 */
- (NSInteger)convertDataToInt;

/**
 * 按位转换NSData->10进制
*/
- (NSInteger)convertDataToIntegerPositional;

/**
 * long转data
 * 按位转换，前面带补0
 */
+ (NSData *)longValueToData:(long)value;

/**
 * 加载gif data为图片
 */
- (UIImage *)gifImage;

@end

NS_ASSUME_NONNULL_END
