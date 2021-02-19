//
//  UINavigationController+MCFoundation.m
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "UINavigationController+MCFoundation.h"

@implementation MCNavigationTitleView

@end

@implementation UINavigationController (MCFoundation)

- (void)setNavigationTitle:(NSString *)title icon:(UIImage *)icon font:(UIFont *)font color:(UIColor *)color {
    UINavigationBar *navigationBar = self.navigationBar;
    if (navigationBar != nil) {
        CGRect navigationBarFrame = navigationBar.frame;
        
        for (UIView *view in [navigationBar subviews]) {
            if ([view isKindOfClass:[MCNavigationTitleView class]]) {
                [view removeFromSuperview];
            }
        }
        
        CGFloat spaceWidth = 10;
        if (nil == icon) {
            spaceWidth = 0;
        }
        
        CGSize imageSize = icon.size;
        if (imageSize.height > navigationBarFrame.size.height) {
            imageSize.width = imageSize.width * (navigationBarFrame.size.height / imageSize.height);
            imageSize.height = navigationBarFrame.size.height;
        }
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = icon;
        
        UIFont *iFont = [UIFont boldSystemFontOfSize:18];
        if (font) {
            iFont = font;
        }
        CGSize labelSize = [title sizeWithFont:iFont constrainedToSize:CGSizeMake(navigationBarFrame.size.width / 2, navigationBarFrame.size.height)];
        UILabel *label = [[UILabel alloc] init];
        label.font = iFont;
        UIColor *iColor = [UIColor blackColor];
        if (color) {
            iColor = color;
        }
        label.textColor = iColor;
        label.text = title;
        
        [imageView setFrame:CGRectMake(0, (navigationBarFrame.size.height - imageSize.height) / 2, imageSize.width, imageSize.height)];
        [label setFrame:CGRectMake(imageView.frame.origin.x + imageView.frame.size.width + spaceWidth, (navigationBarFrame.size.height - labelSize.height) / 2, labelSize.width, labelSize.height)];
        
        MCNavigationTitleView *customView = [[MCNavigationTitleView alloc] init];
        [customView setFrame:CGRectMake((navigationBarFrame.size.width - (imageView.frame.size.width + spaceWidth + label.frame.size.width)) / 2, 0, imageView.frame.size.width + spaceWidth + label.frame.size.width, navigationBarFrame.size.height)];
        
        [customView addSubview:imageView];
        [customView addSubview:label];

        [navigationBar addSubview:customView];
    }
}

- (void)setNavigationItemLeft:(NSString *)title icon:(UIImage *)image font:(UIFont *)font color:(UIColor *)color target:(id)target action:(SEL)action {
    if (title == nil &&
        image == nil) {
        self.navigationItem.leftBarButtonItems = nil;
    } else {
        UIView *barItemView = [self createNavigationItemView:title icon:image type:0 font:font color:color target:target action:action];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:barItemView];
        self.navigationItem.leftBarButtonItems = @[barItem];
    }
}

- (void)setNavigationItemRight:(NSString *)title icon:(UIImage *)image font:(UIFont *)font color:(UIColor *)color target:(id)target action:(SEL)action {
    if (title == nil &&
        image == nil) {
        self.navigationItem.rightBarButtonItems = nil;
    } else {
        UIView *barItemView = [self createNavigationItemView:title icon:image type:1 font:font color:color target:target action:action];
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:barItemView];
        self.navigationItem.rightBarButtonItems = @[barItem];
    }
}

- (void)setNavigationItemLeftCustomViews:(UIView *)customViews, ... {
    NSMutableArray *lMuViewsArray = [NSMutableArray array];
    if (customViews) {
        [lMuViewsArray addObject:customViews];
        va_list args;
        va_start(args, customViews);
        UIView *otherView = nil;
        while ((otherView = va_arg(args, UIView *)) != nil) {
            [lMuViewsArray addObject:otherView];
        }
        va_end(args);
    }
    
    NSMutableArray *lMuBarItemsArray = [NSMutableArray array];
    for (UIView *view in lMuViewsArray) {
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        [lMuBarItemsArray addObject:barItem];
    }
    self.navigationItem.leftBarButtonItems = lMuBarItemsArray;
}

- (void)setNavigationItemRightCustomViews:(UIView *)customViews, ... {
    NSMutableArray *lMuViewsArray = [NSMutableArray array];
    if (customViews) {
        [lMuViewsArray addObject:customViews];
        va_list args;
        va_start(args, customViews);
        UIView *otherView = nil;
        while ((otherView = va_arg(args, UIView *)) != nil) {
            [lMuViewsArray addObject:otherView];
        }
        va_end(args);
    }
    
    NSMutableArray *lMuBarItemsArray = [NSMutableArray array];
    for (UIView *view in lMuViewsArray) {
        UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:view];
        [lMuBarItemsArray addObject:barItem];
    }
    self.navigationItem.rightBarButtonItems = lMuBarItemsArray;
}

#pragma mark - 自定义方法

- (UIView *)createNavigationItemView:(NSString *)title icon:(UIImage *)image type:(int)type font:(UIFont *)font color:(UIColor *)color target:(id)target action:(SEL)action {
    UIView *barItemView = nil;
    
    UINavigationBar *navigationBar = self.navigationBar;
    if (navigationBar != nil) {
        CGRect navigationBarFrame = navigationBar.frame;
        
        barItemView = [[UIView alloc] init];
        [barItemView setFrame:CGRectMake(0, 0, navigationBarFrame.size.width / 4, navigationBarFrame.size.height)];
        
        UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [barButton setFrame:CGRectMake(0, 0, barItemView.frame.size.width, barItemView.frame.size.height)];
        [barItemView addSubview:barButton];
        
        UIFont *iFont = [UIFont systemFontOfSize:14];
        if (font) {
            iFont = font;
        }
        barButton.titleLabel.font = iFont;
        UIColor *iColor = [UIColor blackColor];
        if (color) {
            iColor = color;
        }
        [barButton setTitleColor:iColor forState:UIControlStateNormal];
        [barButton setTitle:title forState:UIControlStateNormal];
        [barButton setImage:image forState:UIControlStateNormal];
        
        if (type == 0) {
            if (action) {
                [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            }
            [barButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        } else {
            if (action) {
                [barButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
            }
            [barButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        }
    }
    
    return barItemView;
}

@end
