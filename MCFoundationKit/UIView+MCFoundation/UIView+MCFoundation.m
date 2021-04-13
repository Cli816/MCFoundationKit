//
//  UIView+MCFoundation.m
//  MCFoundationKit
//
//  Created by wang maocai on 2021/1/21.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "UIView+MCFoundation.h"

@implementation UIView (MCFoundation)

- (UIImage *)convertViewToImage {
    typeof(self) view = self;
    CGSize s = view.bounds.size;
    //第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)bezierPathWithRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    typeof(self) view = self;
    CGRect mRect = view.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:mRect byRoundingCorners:corners cornerRadii:cornerRadii];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = mRect;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

- (void)shadowOfColor:(UIColor *)color offset:(CGSize)offset opacity:(float)opacity radius:(float)radius {
    typeof(self) view = self;
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOffset = offset;
    view.layer.shadowOpacity = opacity;
    view.layer.shadowRadius = radius;
}

- (void)transitionWithType:(NSString *)type withSubtype:(NSString *)subtype duration:(CGFloat)duration {
    typeof(self) view = self;
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = duration;
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    animation.timingFunction = fn;
    [view.layer addAnimation:animation forKey:@"animation"];
}

@end
