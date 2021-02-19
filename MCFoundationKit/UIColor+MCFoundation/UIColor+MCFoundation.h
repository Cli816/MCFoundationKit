//
//  UIColor+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MCFoundation)

/**
 * 指定一个UIColor转换成UIImage
 */
- (UIImage *)createImageWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
