//
//  UITextField+MCFoundation.m
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/19.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "UITextField+MCFoundation.h"

@implementation UITextField (MCFoundation)

- (void)textInputCheckByMaxStrLength:(int)maxStrLength {
    UITextField *textField = self;
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    NSString *toBeString = textField.text;
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > maxStrLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxStrLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxStrLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxStrLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

@end
