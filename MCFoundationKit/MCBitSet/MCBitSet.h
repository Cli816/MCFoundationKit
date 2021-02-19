//
//  MCBitSet.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/6/22.
//  Copyright © 2020 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MCFoundationKit/NSString+MCFoundation.h>

@interface MCBitSet : NSObject

/**
 * 初始化
 * longArray -> 需要转换的长整形数组
 */
- (MCBitSet *)initWithLongArray:(NSArray<NSNumber *> *)longArray;

/**
 * 需要转换的长整形数组
 */
- (void)setLongArray:(NSArray<NSNumber *> *)longArray;

/**
 * 转换后的数量
 */
- (NSInteger)valueCount;

/**
 * 获取指定位置的值
 */
- (BOOL)getValue:(NSInteger)index;

/**
 * 获取格式化后的全部值
 * 字符串例如，0:false,1:true,2:false,3:false
 */
- (NSString *)getAllFormatValue;

@end
