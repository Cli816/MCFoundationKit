//
//  UILabel+MCFoundationKit.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (MCFoundationKit)

/**
 * 设置Label AttributedText
 */
- (void)setAttributedTexts:(NSArray<NSString *> *)texts fonts:(NSArray<UIFont *> *)fonts colors:(NSArray<UIColor *> *)colors;

@end

NS_ASSUME_NONNULL_END
