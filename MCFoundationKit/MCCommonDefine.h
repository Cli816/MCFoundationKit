//
//  MCCommonDefine.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/4/10.
//  Copyright © 2020 mc. All rights reserved.
//

#ifndef MCCommonDefine_h
#define MCCommonDefine_h

#pragma mark - 项目信息

/**
 * 获取项目名称
 */
#define kMCBundleExecutableKey [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleExecutableKey]

/**
 * 获取bundle id
 */
#define kMCBundleIdentifier [[NSBundle mainBundle] bundleIdentifier]

/**
 * 获取版本号
 */
#define kMCBundleShortVersionString [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]

/**
 * 获取build号
 */
#define kMCBundleVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]

/**
 * 获取最终显示的DisplayName
 */
#define kMCBundleFinalDisplayName [NSLocalizedStringFromTableInBundle(@"CFBundleDisplayName", @"InfoPlist", [NSBundle mainBundle], nil) isEqualToString:@"CFBundleDisplayName"] ? [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"] : NSLocalizedStringFromTableInBundle(@"CFBundleDisplayName", @"InfoPlist", [NSBundle mainBundle], nil)

#pragma mark - UI

/**
 * 16进制字符串转颜色
 */
#define kMCColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#endif /* MCCommonDefine_h */
