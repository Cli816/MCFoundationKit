//
//  UILabel+MCFoundation.m
//  MCFoundation
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "UILabel+MCFoundation.h"

@implementation UILabel (MCFoundation)

- (void)setAttributedTexts:(NSArray<NSString *> *)texts fonts:(NSArray<UIFont *> *)fonts colors:(NSArray<UIColor *> *)colors {
    UILabel *label = self;
    if (label != nil) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@""];
        for (int i = 0; i < [texts count]; i ++) {
            NSString *text = texts[i];
            if ([text length] > 0) {
                NSMutableAttributedString *lAttStr = [[NSMutableAttributedString alloc] initWithString:text];
                UIFont *font = nil;
                if (i < [fonts count]) {
                    font = fonts[i];
                }
                UIColor *color = nil;
                if (i < [colors count]) {
                    color = colors[i];
                }
                NSMutableDictionary *attStrDic = [NSMutableDictionary dictionary];
                if (font != nil) {
                    [attStrDic setObject:font forKey:NSFontAttributeName];
                }
                if (color != nil) {
                    [attStrDic setObject:color forKey:NSForegroundColorAttributeName];
                }
                if ([attStrDic count] > 0) {
                    [lAttStr addAttributes:attStrDic range:NSMakeRange(0, [text length])];
                }
                if ([lAttStr length] > 0) {
                    [attStr appendAttributedString:lAttStr];
                }
            }
        }
        label.attributedText = attStr;
    }
}

@end
