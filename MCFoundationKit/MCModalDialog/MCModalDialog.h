//
//  MCModalDialog.h
//  MCFoundationKit
//
//  Created by wang maocai on 2019/5/7.
//  Copyright © 2019 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * 自定义window
 */
@interface MCModalDialogWindow : UIWindow

@end

@interface MCModalDialogParam : NSObject

/**
 * 弹出动画类型，由xx开始
 */
typedef NS_OPTIONS(NSUInteger, MCModalDialogShowStyle) {
    MCModalDialogShowStyle_Left,    // →
    MCModalDialogShowStyle_Right,   // ←
    MCModalDialogShowStyle_Top, // ↓
    MCModalDialogShowStyle_Bottom,  // ↑
    MCModalDialogShowStyle_FadeInOut    // 淡入淡出
};

@property (nonatomic, strong) MCModalDialogWindow *window;
@property (nonatomic, assign) MCModalDialogShowStyle style;

@end

@interface MCModalDialog : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<MCModalDialogParam *> *params;

/**
 * 弹出，默认（↑）MCModalDialogShowStyle_Bottom
 */
+ (void)showModalViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)(void))completeBlock;

/**
 * 弹出，自定义动画类型
 */
+ (void)showModalViewController:(UIViewController *)viewController animated:(BOOL)animated style:(MCModalDialogShowStyle)style complete:(void(^)(void))completeBlock;

/**
 * 关闭
 */
+ (void)closeModalViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)(void))completeBlock;

/**
 * 关闭所有
 */
+ (void)closeAllModalViewControllerComplete:(void(^)(void))completeBlock;

@end
