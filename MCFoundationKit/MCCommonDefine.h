//
//  MCCommonDefine.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/4/10.
//  Copyright © 2020 mc. All rights reserved.
//

#ifndef MCCommonDefine_h
#define MCCommonDefine_h

#pragma mark - 系统

#pragma mark - 屏幕
#define kMCScreenSize [UIScreen mainScreen].bounds.size   // 屏幕size
#define kIS_iPhoneX (kMCScreenSize.height == 812 ? YES : NO)  // 是否是iPhoneX屏幕
#define kIS_iPhoneXR (kMCScreenSize.height == 896 ? YES : NO) // 是否是iPhoneXR屏幕
#define kIS_iPhoneXUp ((kIS_iPhoneX || kIS_iPhoneXR) ? YES : NO)    // 是否是iPhoneX以上的屏幕
#define kSafeAreaTopHeight (kIS_iPhoneXUp ? 88 : 64)    // Top安全高度
#define kSafeAreaBottomHeight (kIS_iPhoneXUp ? 34 : 0)  // Bottom安全高度

#define kNoSafeAreaTopHeight 64    // 没有安全区（iOS11以前）的Top高度，有NavigationBar的，为StatusBar+NavigationBar
#define kNoSafeAreaNoNaviTopHeight 20    // 没有安全区（iOS11以前）的Top高度，没有NavigationBar的，为StatusBar
#define kNoSafeAreaBottomHeight -49  // 没有安全区（iOS11以前）的Bottom高度，有TabBar的，为-49
#define kNoSafeAreaNoTabBottomHeight 0  // 没有安全区（iOS11以前）的Bottom高度，没有TabBar的，为0

#pragma mark - 工程
#define kBundleIdentifier [[NSBundle mainBundle] bundleIdentifier]  // 获取Bundle id
#define kBundleDisplayName [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"]   // 获取Info.plist中未本地化的DisplayName
#define kBundleLocalizedDisplayName NSLocalizedStringFromTableInBundle(@"CFBundleDisplayName", @"InfoPlist", [NSBundle mainBundle], nil)   // 获取InfoPlist.strings中本地化的DisplayName
#define kBundleFinalDisplayName [kBundleLocalizedDisplayName isEqualToString:@"CFBundleDisplayName"] ? kBundleDisplayName : kBundleLocalizedDisplayName   // 获取最终显示的DisplayName
#define kBundleShortVersionString [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] // 获取版本号
#define kBundleVersion [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"]   // 获取build号

#pragma mark - UI
#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]   // 16进制字符串转颜色
#define kUIColorFromRGBA(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]   // 16进制字符串转颜色
#define kRGBColor(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]  // r, g, b转颜色
#define kRGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]    // r, g, b, a转颜色

#endif /* MCCommonDefine_h */
