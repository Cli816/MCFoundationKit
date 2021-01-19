//
//  MCModalDialog.m
//  MCFoundationKit
//
//  Created by wang maocai on 2019/5/7.
//  Copyright © 2019 mc. All rights reserved.
//

#import "MCModalDialog.h"

#define DefaultAnimationDuration 0.2f

@implementation MCModalDialogWindow

@end

@implementation MCModalDialogParam

@end

@interface MCModalDialog()

@property (nonatomic, strong) NSMutableArray<MCModalDialogParam *> *params;

@end

@implementation MCModalDialog

#pragma mark- 线程安全的单例模式
static MCModalDialog *_instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [MCModalDialog shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [MCModalDialog shareInstance];
}

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.params = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

#pragma mark - 使用方法
+ (void)showModalViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)(void))completeBlock
{
    [self showModalViewController:viewController animated:animated style:MCModalDialogShowStyle_Bottom complete:completeBlock];
}

+ (void)showModalViewController:(UIViewController *)viewController animated:(BOOL)animated style:(MCModalDialogShowStyle)style complete:(void(^)(void))completeBlock
{
    [[MCModalDialog shareInstance] _showModalViewController:viewController animated:animated style:style complete:completeBlock];
}

+ (void)closeModalViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)(void))completeBlock
{
    [[MCModalDialog shareInstance] _closeModalViewController:viewController animated:animated complete:completeBlock];
}

+ (void)closeAllModalViewControllerComplete:(void(^)(void))completeBlock
{
    [[MCModalDialog shareInstance] _closeAllModalViewControllerComplete:completeBlock];
}

#pragma mark - 实现方法
- (void)_showModalViewController:(UIViewController *)viewController animated:(BOOL)animated style:(MCModalDialogShowStyle)style complete:(void(^)(void))completeBlock
{
    MCModalDialogWindow *window = [[MCModalDialogWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController = viewController;
    [window setHidden:NO];
    [window makeKeyAndVisible];
    
    MCModalDialogParam *param = [[MCModalDialogParam alloc] init];
    param.window = window;
    param.style = style;
    
    [self.params addObject:param];
    
    if (animated) {
        if (style == MCModalDialogShowStyle_FadeInOut) {
            viewController.view.alpha = 0.0;
            [UIView animateWithDuration:DefaultAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^ {
                viewController.view.alpha = 1.0;
            } completion:^(BOOL finished) {
                if (completeBlock) {
                    completeBlock();
                }
            }];
        } else {
            CGRect beginFrame = viewController.view.frame;
            float offsetX = 0.f;
            float offsetY = 0.f;
            float offsetW = 0.f;
            float offsetH = 0.f;
            CGRect endFrame = viewController.view.frame;
            switch (style) {
                case MCModalDialogShowStyle_Left:
                {
                    offsetX = - beginFrame.size.width;
                }
                    break;
                case MCModalDialogShowStyle_Right:
                {
                    offsetX = beginFrame.size.width;
                }
                    break;
                case MCModalDialogShowStyle_Top:
                {
                    offsetY = - beginFrame.size.height;
                }
                    break;
                case MCModalDialogShowStyle_Bottom:
                {
                    offsetY = beginFrame.size.height;
                }
                    break;
                    
                default:
                    break;
            }
            beginFrame = CGRectMake(beginFrame.origin.x + offsetX, beginFrame.origin.y + offsetY, beginFrame.size.width + offsetW, beginFrame.size.height + offsetH);
            
            viewController.view.frame = beginFrame;
            
            [UIView animateWithDuration:DefaultAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 viewController.view.frame = endFrame;
                             }
                             completion:^(BOOL finished){
                                 if (completeBlock) {
                                     completeBlock();
                                 }
                             }
             ];
        }
    }
}

- (void)_closeModalViewController:(UIViewController *)viewController animated:(BOOL)animated complete:(void(^)(void))completeBlock
{
    MCModalDialogParam *mParam = nil;
    for (MCModalDialogParam *mp in self.params) {
        UIWindow *mw = mp.window;
        if (viewController == mw.rootViewController) {
            mParam = mp;
            break;
        }
    }
    
    if (mParam != nil) {
        if (animated) {
            if (mParam.style == MCModalDialogShowStyle_FadeInOut) {
                viewController.view.alpha = 1.0;
                [UIView animateWithDuration:DefaultAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^ {
                    viewController.view.alpha = 0.0;
                }completion:^(BOOL finished) {
                    [self _clostParam:mParam complete:^{
                        if (completeBlock) {
                            completeBlock();
                        }
                    }];
                }];
            } else {
                CGRect beginFrame = viewController.view.frame;
                float offsetX = 0.f;
                float offsetY = 0.f;
                float offsetW = 0.f;
                float offsetH = 0.f;
                CGRect endFrame = viewController.view.frame;
                switch (mParam.style) {
                    case MCModalDialogShowStyle_Left:
                    {
                        offsetX = - beginFrame.size.width;
                    }
                        break;
                    case MCModalDialogShowStyle_Right:
                    {
                        offsetX = beginFrame.size.width;
                    }
                        break;
                    case MCModalDialogShowStyle_Top:
                    {
                        offsetY = - beginFrame.size.height;
                    }
                        break;
                    case MCModalDialogShowStyle_Bottom:
                    {
                        offsetY = beginFrame.size.height;
                    }
                        break;
                        
                    default:
                        break;
                }
                endFrame = CGRectMake(beginFrame.origin.x + offsetX, beginFrame.origin.y + offsetY, beginFrame.size.width + offsetW, beginFrame.size.height + offsetH);
                
                viewController.view.frame = beginFrame;
                
                [UIView animateWithDuration:DefaultAnimationDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
                    viewController.view.frame = endFrame;
                } completion:^(BOOL finished) {
                    [self _clostParam:mParam complete:^{
                        if (completeBlock) {
                            completeBlock();
                        }
                    }];
                }
                 ];
            }
        } else {
            [self _clostParam:mParam complete:^{
                if (completeBlock) {
                    completeBlock();
                }
            }];
        }
    }
}

- (void)_closeAllModalViewControllerComplete:(void(^)(void))completeBlock
{
    NSArray *lparams = [self.params copy];
    if ([lparams count] > 0) {
        for (int i = 0; i < [lparams count]; i ++) {
            MCModalDialogParam *mParam = lparams[i];
            [self _clostParam:mParam complete:^{
                if (i == [lparams count] - 1) {
                    if (completeBlock) {
                        completeBlock();
                    }
                }
            }];
        }
    } else {
        if (completeBlock) {
            completeBlock();
        }
    }
}

- (void)_clostParam:(MCModalDialogParam *)param complete:(void(^)(void))completeBlock {
    if (param.window.rootViewController.presentedViewController != nil) {
        [param.window.rootViewController dismissViewControllerAnimated:YES completion:^{
            [self __clostParam:param complete:completeBlock];
        }];
    } else {
        [self __clostParam:param complete:completeBlock];
    }
}

- (void)__clostParam:(MCModalDialogParam *)param complete:(void(^)(void))completeBlock {
    [param.window resignKeyWindow];
    param.window.windowLevel = -1000;
    param.window.hidden = YES;
    param.window.rootViewController = nil;
    param.window = nil;
    [self.params removeObject:param];
    if (completeBlock) {
        completeBlock();
    }
}

@end
