//
//  UIImage+MCFoundation.m
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "UIImage+MCFoundation.h"

@implementation UIImage (MCFoundation)

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    UIImage *mImage = nil;
    
    CGRect rect = CGRectMake(0.f, 0.f, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    [self drawInRect:rect];
    CGContextDrawPath(context, kCGPathFillStroke);
    mImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return mImage;
}

- (UIImage *)imageTrimWithSize:(CGSize)size {
    UIImage *mImage = nil;
    
    CGRect rect = CGRectMake(0.f, 0.f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:rect];
    mImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return mImage;
}

- (UIImage *)resizeImage {
    UIImage *resizeImg = self;
    
    resizeImg = [resizeImg resizableImageWithCapInsets:UIEdgeInsetsMake(resizeImg.size.height / 2.f, resizeImg.size.width / 2.f, resizeImg.size.height / 2.f, resizeImg.size.width / 2.f) resizingMode:UIImageResizingModeStretch];
    
    return resizeImg;
}

- (NSData *)compressImageQualityToByte:(NSInteger)maxLength {
    UIImage *image = self;
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (data.length > maxLength) {
        CGFloat max = 1;
        CGFloat min = 0;
        NSData *compressData = nil;
        for (int i = 0; i < 6; i ++) {
            CGFloat compression = (max + min) / 2;
            compressData = UIImageJPEGRepresentation(image, compression);
            if (compressData.length < maxLength * 0.9) {
                min = compression;
            } else if (compressData.length > maxLength) {
                max = compression;
            } else {
                break;
            }
        }
        if (compressData) {
            data = compressData;
        }
    }
    return data;
}

@end
