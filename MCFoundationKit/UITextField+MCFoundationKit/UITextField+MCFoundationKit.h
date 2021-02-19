//
//  UITextField+MCFoundationKit.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (MCFoundationKit)

/**
 * 输入检测
 * 需要监听[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:TextField];
 */
- (void)textInputCheckByMaxStrLength:(int)maxStrLength;

@end

NS_ASSUME_NONNULL_END
