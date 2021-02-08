//
//  MCScannerViewController.h
//  MVPBasicFrame
//
//  Created by wang maocai on 2021/2/8.
//

#import <UIKit/UIKit.h>
#import <MCFoundationKit/MCScanner.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MCScannerViewControllerDelegate <NSObject>

@optional

/**
 * 扫码得到解析字符串返回
 */
- (void)handleScanResult:(NSString *)result;

@end

@interface MCScannerViewController : UIViewController<MCScannerDelegate>

@property (nonatomic, strong, readonly) MCScanner *scanner;

@property (nonatomic, weak) id<MCScannerViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
