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

#endif /* MCCommonDefine_h */
