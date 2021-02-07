//
//  MCScanner.h
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/7.
//  Copyright © 2021 王茂. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCScannerDelegate <NSObject>

@optional
- (void)mc_captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection;
- (void)handleScanResult:(NSString *)result;

@end

@interface MCScanner : NSObject<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong, readonly) AVCaptureSession *session;
@property (nonatomic, strong, readonly) UIView *view;
@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *layer;

@property (nonatomic, strong, readonly) id<MCScannerDelegate> delegate;

#pragma mark - 实现方法，子类重载

/**
 * 初始化
 */
- (void)onInit;

/**
 * 释放
 */
- (void)onDealloc;

#pragma mark - 接口方法

- (instancetype)initWithView:(UIView *)view delegate:(id<MCScannerDelegate>)delegate;

- (void)startScanning:(void (^ _Nullable)(BOOL result))complete;

@end

NS_ASSUME_NONNULL_END
