//
//  MCUserDefaultsManager.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/4/10.
//  Copyright © 2020 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCUserDefaultsManager : NSObject

/**
 * 储存数据
 */
+ (void)setData:(id)data forKey:(NSString *)key;

/**
 * 取出数据
 */
+ (id)getDataForKey:(NSString *)key;

/**
 * 删除数据
 */
+ (void)removeDataForKey:(NSString *)key;

/**
 * 清除所有数据
 */
+ (void)clearAllData;

@end
