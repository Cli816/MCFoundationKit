//
//  UIView+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/1/21.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 动画类型定义
 */
typedef NS_OPTIONS(NSUInteger, UIToolsAnimationType) {
    UIToolsAnimationType_Move, // 移动
    UIToolsAnimationType_Rotation   // 旋转
};

@interface UIView (MCFoundation)

/**
 * 指定一个UIView转换成UIImage
 */
- (UIImage *)convertViewToImage;

/**
 * UIView切任意圆角
 */
- (void)bezierPathWithRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 * 设置view的阴影
 * offset：阴影偏移，x>0 right，x<0 left，y>0 bottom，y<0 top
 * opacity：不透明度
 * radius：半径
 */
- (void)shadowOfColor:(UIColor *)color offset:(CGSize)offset opacity:(float)opacity radius:(float)radius;

/**
 * CATransition动画
 * type:动作（kCATransitionPush）
 * subtype:方向（kCATransitionFromRight）
 * view:执行动画的view
 * duration:动画时长
 */
- (void)transitionWithType:(NSString *)type withSubtype:(NSString *)subtype duration:(CGFloat)duration;

/**
 * UIView动画
 */
- (void)animateWithType:(UIToolsAnimationType)type duration:(NSTimeInterval)duration value:(CGFloat)value complete:(void(^ _Nullable)(void))completeBlock;

@end

NS_ASSUME_NONNULL_END
