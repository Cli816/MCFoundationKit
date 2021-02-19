//
//  UIButton+MCFoundation.m
//  MCFoundation
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "UIButton+MCFoundation.h"

@implementation UIButton (MCFoundation)

- (void)changeButtonLayoutTypeTo:(UIToolsButtonLayoutType)type spacing:(CGFloat)spacing {
    UIButton *button = self;
    CGFloat buttonImageW = button.imageView.frame.size.width;
    CGFloat buttonImageH = button.imageView.frame.size.height;
    CGFloat buttonTitleW = button.titleLabel.frame.size.width;
    CGFloat buttonTitleH = button.titleLabel.frame.size.height;
    CGFloat buttonSpacing = spacing;
    
    switch (type) {
        case UIToolsButtonLayoutType_Vertical:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = buttonImageH / 2 + buttonSpacing / 2,
                .left = - (buttonImageW / 2),
                .bottom = - (buttonImageH / 2 + buttonSpacing / 2),
                .right = buttonImageW / 2
            };
            
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = - (buttonTitleH / 2 + buttonSpacing / 2),
                .left = buttonTitleW / 2,
                .bottom = buttonTitleH / 2 + buttonSpacing / 2,
                .right = - (buttonTitleW / 2)
            };
        }
            break;
        case UIToolsButtonLayoutType_Horizontal:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = buttonSpacing / 2,
                .bottom = 0,
                .right = - buttonSpacing / 2
            };
                
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = - buttonSpacing / 2,
                .bottom = 0,
                .right = buttonSpacing / 2
            };
        }
            break;
        case UIToolsButtonLayoutType_Cover:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = - (buttonImageW / 2),
                .bottom = 0,
                .right = buttonImageW / 2
            };
            
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = buttonTitleW / 2,
                .bottom = 0,
                .right = - (buttonTitleW / 2)
            };
        }
            break;
        case UIToolsButtonLayoutType_Reversal:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = - (buttonImageW + buttonSpacing / 2),
                .bottom = 0,
                .right = (buttonImageW + buttonSpacing / 2)
            };
                
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = 0,
                .left = (buttonTitleW + buttonSpacing / 2),
                .bottom = 0,
                .right = - (buttonTitleW + buttonSpacing / 2)
            };
        }
            break;
        case UIToolsButtonLayoutType_VerticalReversal:
        {
            button.titleEdgeInsets = (UIEdgeInsets) {
                .top = - (buttonImageH / 2 + buttonSpacing / 2),
                .left = - (buttonImageW / 2),
                .bottom = buttonImageH / 2 + buttonSpacing / 2,
                .right = buttonImageW / 2
            };
            
            button.imageEdgeInsets = (UIEdgeInsets) {
                .top = buttonTitleH / 2 + buttonSpacing / 2,
                .left = buttonTitleW / 2,
                .bottom = - (buttonTitleH / 2 + buttonSpacing / 2),
                .right = - (buttonTitleW / 2)
            };
        }
            break;
            
        default:
            break;
    }
}

@end
