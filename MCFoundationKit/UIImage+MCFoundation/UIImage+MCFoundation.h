//
//  UIImage+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (MCFoundation)

/**
 * 图片切圆角
 * radius：圆角大小
 * image：原始图片
 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/**
 * 图片裁剪
 */
- (UIImage *)imageTrimWithSize:(CGSize)size;

/**
 * 按UIImage中心拉伸图片
 */
- (UIImage *)resizeImage;

/**
 * 二分法压缩图片(JPEG)
 * PNG压缩完会变成无透明图
 * toByte -> 指定大小(B)，1KB = 1024B
 */
- (NSData *)compressImageQualityToByte:(NSInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
