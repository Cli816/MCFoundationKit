//
//  MCFileManager.m
//  MCFoundationKit
//
//  Created by wang maocai on 2020/4/10.
//  Copyright © 2020 mc. All rights reserved.
//

#import "MCFileManager.h"

@implementation MCFileManager

+ (NSString *)getDocumentDirectory {
    NSArray *lDomainPathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *lDocumentDirectory = [lDomainPathArray objectAtIndex:0];
    return lDocumentDirectory;
}

+ (NSString *)getCachesDirectory {
    NSArray *lDomainPathArray = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *lCachesDirectory = [lDomainPathArray objectAtIndex:0];
    return lCachesDirectory;
}

+ (NSString *)getTmpDirectory {
    NSString *lTmpDirectory = NSTemporaryDirectory();
    return lTmpDirectory;
}

+ (void)createFilePath:(NSString *)path directory:(NSString *)directory {
    NSString *lFilePath = [directory stringByAppendingPathComponent:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL lFilePathIsDir = NO;
    BOOL lFilePathExisted = [fileManager fileExistsAtPath:lFilePath isDirectory:&lFilePathIsDir];
    BOOL ret = YES;
    if (!(lFilePathIsDir == YES && lFilePathExisted == YES)) {
        NSArray *arr = [path componentsSeparatedByString:@"/"];
        
        BOOL isDir = NO;
        NSString *tempPath = directory;
        for (int i = 0; i < [arr count]; i++) {
            NSString *str = [arr objectAtIndex:i];
            if ([str length] == 0) {
                continue;
            }
            tempPath = [tempPath stringByAppendingPathComponent:str];
            BOOL existed = [fileManager fileExistsAtPath:tempPath isDirectory:&isDir];
            if (!(isDir == YES && existed == YES)) {
                ret = [fileManager createDirectoryAtPath:tempPath withIntermediateDirectories:YES attributes:nil error:nil];
            }
        }
    }
}

+ (BOOL)saveDataToFile:(NSData *)data name:(NSString *)name path:(NSString *)path directory:(NSString *)directory {
    [self createFilePath:path directory:directory];
    NSString *filePath = [directory stringByAppendingPathComponent:path];
    NSString *fileName = [filePath stringByAppendingPathComponent:name];
    BOOL ret = [data writeToFile:fileName atomically:YES];
    return ret;
}

+ (NSArray *)subpathsAtPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *ret = [fileManager subpathsAtPath:path];
    return ret;
}

+ (BOOL)deleteFileWithPath:(NSString *)path {
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    BOOL ret = YES;
    if (existed == YES) {
        ret = [fileManager removeItemAtPath:path error:nil];
    }
    return ret;
}

+ (BOOL)moveFileAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError *)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL ret = NO;
    if ([path length] > 0 &&
        [toPath length] > 0 &&
        [self fileExistsAtPath:path]) {
        if ([self fileExistsAtPath:toPath]) {
            [self deleteFileWithPath:toPath];
        }
        ret = [fileManager moveItemAtPath:path toPath:toPath error:&error];
    }
    return ret;
}

+ (BOOL)copyFileAtPath:(NSString *)path toPath:(NSString *)toPath error:(NSError *)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL ret = NO;
    if ([path length] > 0 &&
        [toPath length] > 0 &&
        [self fileExistsAtPath:path]) {
        if ([self fileExistsAtPath:toPath]) {
            [self deleteFileWithPath:toPath];
        }
        ret = [fileManager copyItemAtPath:path toPath:toPath error:&error];
    }
    return ret;
}

+ (BOOL)fileExistsAtPath:(NSString *)path {
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    return existed;
}

+ (void)clearAllFile {
    [self deleteFileWithPath:[self getDocumentDirectory]];
    [self deleteFileWithPath:[self getCachesDirectory]];
    [self deleteFileWithPath:[self getTmpDirectory]];
}

@end
