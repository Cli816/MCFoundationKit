//
//  MCScanner.m
//  MCFoundationKit
//
//  Created by wang maocai on 2021/2/7.
//  Copyright © 2021 王茂. All rights reserved.
//

#import "MCScanner.h"

@implementation MCScanner

@synthesize
session = _session;

- (void)dealloc {
    [self onDealloc];
}

- (instancetype)initWithView:(UIView *)view delegate:(id<MCScannerDelegate>)delegate outputQueue:(dispatch_queue_t)outputQueue {
    if (self = [super init]) {
        _view = view;
        _delegate = delegate;
        _outputQueue = outputQueue;
        
        [self onInit];
    }
    return self;
}

#pragma mark - 实现方法，子类重载

- (void)onInit {
    NSLog(@"[%@ onInit]", [self class]);
}

- (void)onDealloc {
    NSLog(@"[%@ onDealloc]", [self class]);
    
    _delegate = nil;
    _outputQueue = nil;
    _layer = nil;
    _view = nil;
    _session = nil;
}

#pragma mark - 懒加载

- (AVCaptureSession *)session {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        NSError *error;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (input) {
            if (!_session) {
                _session = [[AVCaptureSession alloc] init];
                _session.sessionPreset = AVCaptureSessionPresetHigh;
                [_session addInput:input];
                AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
                //必须先addOutput再设置output，否则availableMetadataObjectTypes会不存在异常
                [_session addOutput:output];
                if (!_outputQueue) {
                    _outputQueue = dispatch_queue_create(kMCDefaultAVCaptureMetadataOutputQueue, DISPATCH_QUEUE_CONCURRENT);
                }
                [output setMetadataObjectsDelegate:self queue:self.outputQueue];
                output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                               AVMetadataObjectTypeEAN13Code,
                                               AVMetadataObjectTypeEAN8Code,
                                               AVMetadataObjectTypeUPCECode,
                                               AVMetadataObjectTypeCode39Code,
                                               AVMetadataObjectTypeCode39Mod43Code,
                                               AVMetadataObjectTypeCode93Code,
                                               AVMetadataObjectTypeCode128Code,
                                               AVMetadataObjectTypePDF417Code];
            }
        } else {
            NSLog(@"[AVCaptureDeviceInput error: %@]", error.description);
        }
    } else {
        NSLog(@"[AVCaptureDevice error: %@]", device);
    }
    return _session;
}

#pragma mark - 接口方法

- (void)startScanning:(void (^)(BOOL))complete {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                if (self.session &&
                    self.view) {
                    if (!self->_layer) {
                        self->_layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
                        self->_layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                        self->_layer.frame = self.view.layer.bounds;
                        [self.view.layer addSublayer:self->_layer];
                    }
                    [self.session startRunning];
                    if (complete) {
                        complete(YES);
                    }
                } else {
                    if (complete) {
                        complete(NO);
                    }
                }
            } else {
                if (complete) {
                    complete(NO);
                }
            }
        });
    }];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if ([_session isRunning]) {
        if ([self.delegate respondsToSelector:@selector(mc_captureOutput:didOutputMetadataObjects:fromConnection:)]) {
            [self.delegate mc_captureOutput:output didOutputMetadataObjects:metadataObjects fromConnection:connection];
        } else {
            if (metadataObjects.count > 0) {
                [_session stopRunning];
                
                AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
                NSString *result = metadataObject.stringValue;
                if ([self.delegate respondsToSelector:@selector(handleScanResult:)]) {
                    [self.delegate handleScanResult:result];
                }
            }
        }
    }
}

@end
