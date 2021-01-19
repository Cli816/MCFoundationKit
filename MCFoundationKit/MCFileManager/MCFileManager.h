//
//  MCFileManager.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/4/10.
//  Copyright © 2020 mc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCFileManager : NSObject

/**
 * 获取沙盒路径
 */
+ (NSString *)getDocumentDirectory;

/**
 * 获取缓存路径
 */
+ (NSString *)getCachesDirectory;

/**
 * 获取临时文件路径
 */
+ (NSString *)getTmpDirectory;

/**
 * 创建文件夹(文件路径)
 */
+ (void)createFilePath:(NSString *)path directory:(NSString *)directory;

/**
 * 保存文件
 */
+ (BOOL)saveDataToFile:(NSData *)data name:(NSString *)name path:(NSString *)path directory:(NSString *)directory;

/**
 * 获取目录下所有子目录
 */
+ (NSArray *)subpathsAtPath:(NSString *)path;

/**
 * 删除文件(文件、文件夹)
 */
+ (BOOL)deleteFileWithPath:(NSString *)path;

/**
 * 移动文件
 */
+ (BOOL)moveFileAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError *)error;

/**
 * 复制文件
 */
+ (BOOL)copyFileAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError *)error;

/**
 * 判断文件或文件夹是否存在
 */
+ (BOOL)fileExistsAtPath:(NSString *)path;

/**
 * 清除所有文件(Document、Caches、Tmp)
 */
+ (void)clearAllFile;

@end
