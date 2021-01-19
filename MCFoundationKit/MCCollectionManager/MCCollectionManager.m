//
//  MCCollectionManager.m
//  MCFoundationKit
//
//  Created by wang maocai on 2020/9/7.
//  Copyright © 2020 mc. All rights reserved.
//

#import "MCCollectionManager.h"

@implementation MCCollectionManager

+ (CGSize)getCollectionViewItemSize:(UICollectionView *)collectionView spacingSize:(CGSize)spacingSize rowCount:(NSInteger)rowCount originalSize:(CGSize)originalSize
{
    CGSize itemSize = CGSizeZero;
    
    CGFloat collectionWidth = collectionView.frame.size.width;
    CGFloat itemWidth = (collectionWidth - spacingSize.width * (rowCount - 1)) / rowCount;
    CGFloat itemHeight = itemWidth / originalSize.width * originalSize.height;
    itemSize = CGSizeMake(itemWidth, itemHeight);
    
    return itemSize;
}

+ (CGFloat)getCollectionContentHeight:(UICollectionView *)collectionView spacingSize:(CGSize)spacingSize rowCount:(NSInteger)rowCount originalSize:(CGSize)originalSize sourceCount:(NSInteger)sourceCount
{
    CGFloat height = 0;
    
    CGSize itemSize = [self getCollectionViewItemSize:collectionView spacingSize:spacingSize rowCount:rowCount originalSize:originalSize];
    NSInteger totalCount = sourceCount / rowCount;
    if (sourceCount % rowCount > 0) {
        totalCount += 1;
    }
    height = (totalCount) * itemSize.height + (totalCount - 1) * spacingSize.height;
    
    return height;
}

@end
