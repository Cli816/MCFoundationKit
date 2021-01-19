//
//  MCUITools.h
//  MCFoundationKit
//
//  Created by wang maocai on 2019/4/11.
//  Copyright © 2019 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

/**
 * 动画类型定义
 */
typedef NS_OPTIONS(NSUInteger, UIToolsAnimationType) {
    UIToolsAnimationType_Move, // 移动
    UIToolsAnimationType_Rotation   // 旋转
};

@interface MCUITools : NSObject

#pragma mark- 类方法
/**
 * 颜色字符串转换成UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 * 计算字符串Size
 */
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 * 指定一个UIColor转换成UIImage
 */
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 指定一个UIView转换成UIImage
 */
+ (UIImage *)convertViewToImage:(UIView *)view;

/**
 * UIView切任意圆角
 */
+ (void)bezierPathWithRoundedView:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 * 图片切圆角
 * radius：圆角大小
 * image：原始图片
 */
+ (UIImage *)imageWithCornerRadius:(CGFloat)radius image:(UIImage *)image;

/**
 * 图片裁剪
 */
+ (UIImage *)imageTrimWithSize:(CGSize)size image:(UIImage *)image;

/**
 * 按UIImage中心拉伸图片
 */
+ (UIImage *)resizeImage:(UIImage *)image;

/**
 * 设置view的阴影
 * offset：阴影偏移，x>0 right，x<0 left，y>0 bottom，y<0 top
 * opacity：不透明度
 * radius：半径
 */
+ (void)shadowOfView:(UIView *)view color:(UIColor *)color offset:(CGSize)offset opacity:(float)opacity radius:(float)radius;

/**
 * 时间字符串转NSDate
 */
+ (NSDate *)strToDate:(NSString*)strDate byFormat:(NSString *)formatStr byTimeZone:(NSTimeZone*)timeZone;

/**
 * NSDate转时间字符串
 */
+ (NSString *)dateToStr:(NSDate *)date byFormat:(NSString *)formatStr byTimeZone:(NSTimeZone*)timeZone;

/**
* 时间戳转时间
*/
+ (NSDate *)timeStampToTime:(NSInteger)timeStamp;

/**
* 时间转时间戳
*/
+ (NSInteger)timeToTimeStamp:(NSDate *)time;

/**
 * CATransition动画
 * type:动作（kCATransitionPush）
 * subtype:方向（kCATransitionFromRight）
 * view:执行动画的view
 * duration:动画时长
 */
+ (void)transitionWithType:(NSString *)type withSubtype:(NSString *)subtype forView:(UIView *)view duration:(CGFloat)duration;

/**
 * UIView动画
 */
+ (void)animateWithView:(UIView *)view duration:(NSTimeInterval)duration value:(CGFloat)value type:(UIToolsAnimationType)type complete:(void(^)(void))completeBlock;

/**
 * 改变按钮的内部布局
 */
+ (void)changeButtonLayoutTypeTo:(UIToolsButtonLayoutType)type button:(UIButton *)button spacing:(CGFloat)spacing;

/**
 * 平滑退出APP
*/
+ (void)exitApplication;

/**
 * 16进制转NSData
*/
+ (NSData *)convertHexStrToData:(NSString *)str;

/**
 * 16进制转10进制
 */
+ (NSInteger)convertHexStrToInt:(NSString *)str;

/**
 * 16进制字符串转2进制字符串
 */
+ (NSString *)convertHexStrToBinaryStr:(NSString *)hex;

/**
 * NSData转16进制
 */
+ (NSString *)convertDataToHexStr:(NSData *)data;

/**
 * 转换NSData->16进制字符串
 * 如果存在\0，以\0为结束符
*/
+ (NSString *)convertDataToString:(NSData *)data;

/**
 * 按位转换NSData->16进制字符串
 * 如果存在\0，以\0为结束符
*/
+ (NSString *)convertDataToStringPositional:(NSData *)data;

/**
 * NSData转10进制
 */
+ (NSInteger)convertDataToInt:(NSData *)data;

/**
 * 按位转换NSData->10进制
*/
+ (NSInteger)convertDataToIntegerPositional:(NSData *)data;

/**
 * 10进制转16进制
 */
+ (NSString *)convertIntegerToHexStr:(NSInteger)integer;

/**
 * long转data
 * 按位转换，前面带补0
 */
+ (NSData *)longValueToData:(long)value;

/**
 * 启动倒计时
 */
+ (void)startCountdownTimer:(dispatch_source_t)timer timeInterval:(NSTimeInterval)timeInterval complete:(void(^)(void))completeBlock progress:(void(^)(int mSecond))progressBlock;

/**
 * 取消倒计时
*/
+ (void)cancelCountdownTimer:(dispatch_source_t)timer;

/**
 * 获取最上层window
 */
+ (UIWindow *)topLevelWindow;

/**
 * 获取手机型号
*/
+ (NSString *)getCurrentDeviceModel;

/**
 * 字符串路径拼接
 * suffix -> 后缀名，例如"html"、"png"，可以为nil
 */
+ (NSString *)stringPathWithSuffix:(NSString *)suffix components:(NSString *)components, ... NS_REQUIRES_NIL_TERMINATION;

/**
 * 获取当前系统语言
 */
+ (NSString *)getSystemLanguageCode;

/**
 * 设置Label AttributedText
 */
+ (void)setLabelAttributedTexts:(NSArray<NSString *> *)texts fonts:(NSArray<UIFont *> *)fonts colors:(NSArray<UIColor *> *)colors label:(UILabel *)label;

/**
 * 获取一个随机整数，包含from，包含to
 */
+ (NSInteger)getRandomInteger:(NSInteger)from to:(NSInteger)to;

/**
 * 加载gif为图片
 */
+ (UIImage *)gifImageWithData:(NSData *)data;

/**
 * isStrictNum:严格数字检查，不能出现020，.2的情况
 * decimal:小数位数
 */
+ (BOOL)isNumStr:(NSString*)str isStrictNum:(BOOL)isStrictNum decimal:(unsigned int)decimal maxValue:(NSNumber *)maxValue;

/**
 * 输入检测
 * 需要监听[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:TextField];
 */
+ (void)textInputCheck:(UITextField *)textField maxStrLength:(int)maxStrLength;

/**
 * 主线程微小的延迟，用作UI响应不及时的处理
 */
+ (void)dispatchAfterLittleOnMainQueue:(void(^)(void))completeBlock;

/**
 * 二分法压缩图片(JPEG)
 * PNG压缩完会变成无透明图
 * toByte -> 指定大小(B)，1KB = 1024B
 */
+ (NSData *)compressImageQuality:(UIImage *)image toByte:(NSInteger)maxLength;

@end
