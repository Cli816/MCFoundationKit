//
//  MCCollectionManager.h
//  MCFoundationKit
//
//  Created by wang maocai on 2020/9/7.
//  Copyright © 2020 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface MCCollectionManager : NSObject

/**
 * 获取CollectionViewCell的size
 * collectionView -> collectionView
 * spacingSize -> 间距，需要指定minimumInteritemSpacingForSectionAtIndex返回0
 * rowCount -> 每行数量
 * originalSize -> 原始尺寸，用作算比例
 */
+ (CGSize)getCollectionViewItemSize:(UICollectionView *)collectionView spacingSize:(CGSize)spacingSize rowCount:(NSInteger)rowCount originalSize:(CGSize)originalSize;

/**
 * 获取CollectionView全展开时的高度
 * collectionView -> collectionView
 * spacingSize -> 间距，需要指定minimumInteritemSpacingForSectionAtIndex返回0
 * rowCount -> 每行数量
 * originalSize -> 原始尺寸，用作算比例
 * sourceCount -> 数据源数量
 */
+ (CGFloat)getCollectionContentHeight:(UICollectionView *)collectionView spacingSize:(CGSize)spacingSize rowCount:(NSInteger)rowCount originalSize:(CGSize)originalSize sourceCount:(NSInteger)sourceCount;

@end
