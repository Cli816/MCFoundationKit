//
//  UIViewController+MCFoundation.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/20.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MCFoundationKit/NSString+MCFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MCNavigationTitleView : UIView

@end

@interface UIViewController (MCFoundation)

#pragma mark - Navigation

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

#pragma mark - Alert

- (UIAlertController *)showAlertWithComplete:(void (^ _Nullable)(void))complete
                               clickedAction:(void (^ _Nullable)(UIAlertAction *action))clickedAction
                                       title:(nullable NSString *)title
                                     message:(nullable NSString *)message
                              preferredStyle:(UIAlertControllerStyle)preferredStyle
                           cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      destructiveButtonTitle:(nullable NSString *)destructiveButtonTitle
                           otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end

NS_ASSUME_NONNULL_END
