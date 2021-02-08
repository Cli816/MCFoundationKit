//
//  MCScannerViewController.m
//  MVPBasicFrame
//
//  Created by wang maocai on 2021/2/8.
//

#import "MCScannerViewController.h"

@interface MCScannerViewController ()

@end

@implementation MCScannerViewController

@synthesize scanner = _scanner;

- (void)dealloc {
    [self onDealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self onViewDidLoad];
}

#pragma mark - 实现方法，子类重载

- (void)onViewDidLoad {
    NSLog(@"[%@ onViewDidLoad]", [self class]);
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.scanner startScanning:^(BOOL result) {
        
    }];
}

- (void)onDealloc {
    NSLog(@"[%@ onDealloc]", [self class]);
    
    _delegate = nil;
    _scanner = nil;
}

#pragma mark - 懒重载

- (MCScanner *)scanner {
    if (!_scanner) {
        _scanner = [[MCScanner alloc] initWithView:self.view delegate:self outputQueue:nil];
    }
    return _scanner;
}

#pragma mark - MCScannerDelegate

- (void)handleScanResult:(NSString *)result {
    NSLog(@"handleScanResult: %@", result);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(handleScanResult:)]) {
                [self.delegate handleScanResult:result];
            }
        }];
    });
}

@end
