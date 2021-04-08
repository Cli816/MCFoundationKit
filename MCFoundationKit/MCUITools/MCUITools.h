//
//  MCUITools.h
//  MCFoundationKit
//
//  Created by wang maocai on 2019/4/11.
//  Copyright © 2019 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MCUITools : NSObject

#pragma mark - 数据

/**
 * 获取一个随机整数，包含from，包含to
 */
+ (NSInteger)getRandomInteger:(NSInteger)from to:(NSInteger)to;

#pragma mark - 计时器

/**
 * 启动倒计时
   dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
   timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
 */
+ (void)startCountdownTimer:(dispatch_source_t)timer timeInterval:(NSTimeInterval)timeInterval complete:(void(^)(void))completeBlock progress:(void(^)(int second))progressBlock;

/**
 * 取消倒计时
*/
+ (void)cancelCountdownTimer:(dispatch_source_t)timer;

#pragma mark - 系统

/**
 * 平滑退出APP
*/
+ (void)exitApplication;

/**
 * 获取手机型号
*/
+ (NSString *)getCurrentDeviceModel;

/**
 * 获取当前系统语言
 */
+ (NSString *)getSystemLanguageCode;

#pragma mark - UI

/**
 * 获取最上层Normal Window
 */
+ (UIWindow *)topNormalWindow;

/**
 * 主线程微小的延迟，用作UI响应不及时的处理
 */
+ (void)dispatchAfterLittleOnMainQueue:(void(^)(void))completeBlock;

@end
