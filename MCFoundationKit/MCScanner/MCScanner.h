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

/**
 * 默认output queue
 */
#define kMCDefaultAVCaptureMetadataOutputQueue "com.mcqueue.AVCaptureMetadataOutput"

@protocol MCScannerDelegate <NSObject>

@optional

/**
 * 扫码得到解析字符串返回
 */
- (void)handleScanResult:(NSString *)result;

/**
 * 原始扫码数据返回
 * 如果实现了此回调自己处理数据，则handleScanResult回调就不会走了
 */
- (void)mc_captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection;

@end

@interface MCScanner : NSObject<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong, readonly) AVCaptureSession *session;
@property (nonatomic, strong, readonly) UIView *view;
@property (nonatomic, strong, readonly) AVCaptureVideoPreviewLayer *layer;
@property (nonatomic, strong, readonly) dispatch_queue_t outputQueue;

@property (nonatomic, weak, readonly) id<MCScannerDelegate> delegate;

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

/**
 * 必须调用此方法进行初始化
 * view: 承载扫码的父view
 * delegate: 接收扫码回调的代理
 * outputQueue: 扫码输出队列，nil为默认队列kMCDefaultAVCaptureMetadataOutputQueue
 */
- (instancetype)initWithView:(UIView *)view delegate:(nullable id<MCScannerDelegate>)delegate outputQueue:(nullable dispatch_queue_t)outputQueue;

/**
 * 开始扫码
 * complete: YES -> 成功，NO -> 失败
 */
- (void)startScanning:(void (^ _Nullable)(BOOL complete))completeBlock;

@end

NS_ASSUME_NONNULL_END
