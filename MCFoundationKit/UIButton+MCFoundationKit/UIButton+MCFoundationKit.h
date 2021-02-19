//
//  UIButton+MCFoundationKit.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 按钮布局类型
 */
typedef NS_OPTIONS(NSUInteger, UIToolsButtonLayoutType) {
    UIToolsButtonLayoutType_Vertical,   // 竖直
    UIToolsButtonLayoutType_Horizontal, // 水平
    UIToolsButtonLayoutType_Cover,  // 覆盖
    UIToolsButtonLayoutType_Reversal,    // 水平反转
    UIToolsButtonLayoutType_VerticalReversal    // 竖直反转
};

@interface UIButton (MCFoundationKit)

/**
 * 改变按钮的内部布局
 */
- (void)changeButtonLayoutTypeTo:(UIToolsButtonLayoutType)type spacing:(CGFloat)spacing;

@end

NS_ASSUME_NONNULL_END
