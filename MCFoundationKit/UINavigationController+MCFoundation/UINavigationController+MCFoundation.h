//
//  UINavigationController+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCFoundationKit/NSString+MCFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCNavigationTitleView : UIView

@end

@interface UINavigationController (MCFoundation)

/**
 * 设置导航栏标题
 */
- (void)setNavigationTitle:(nullable NSString *)title icon:(nullable UIImage *)icon font:(nullable UIFont *)font color:(nullable UIColor *)color;

/**
 * 设置NavigationBar左侧按钮
 */
- (void)setNavigationItemLeft:(nullable NSString *)title icon:(nullable UIImage *)image font:(nullable UIFont *)font color:(nullable UIColor *)color target:(nullable id)target action:(nullable SEL)action;

/**
 * 设置NavigationBar右侧按钮
 */
- (void)setNavigationItemRight:(nullable NSString *)title icon:(nullable UIImage *)image font:(nullable UIFont *)font color:(nullable UIColor *)color target:(nullable id)target action:(nullable SEL)action;

/**
 * 设置NavigationBar左侧自定义Views，从左->右
*/
- (void)setNavigationItemLeftCustomViews:(nullable UIView *)customViews, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * 设置NavigationBar右侧自定义Views，从右->左
*/
- (void)setNavigationItemRightCustomViews:(nullable UIView *)customViews, ... NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
