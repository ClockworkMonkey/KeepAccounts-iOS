//
//  WRGSubcategoryFlowLayout.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/8/29.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGSubcategoryFlowLayout.h"

CGFloat const kTBInset = kMargin;
CGFloat const kLRInset = kMargin * 1.5;
CGFloat const kCellWH = 45.f;
NSInteger const kNumOfRow = 4;      // 4行
NSInteger const kNumOfColumn = 5;   // 5列

@interface WRGSubcategoryFlowLayout ()
@property (nonatomic, assign) CGFloat minInteritemSpacing;
@property (nonatomic, assign) CGFloat minLineSpacing;
@end

@implementation WRGSubcategoryFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat viewH = self.collectionView.frame.size.height;
    CGFloat viewW = self.collectionView.frame.size.width;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(kCellWH, kCellWH);
    self.sectionInset = UIEdgeInsetsMake(kTBInset, kLRInset, kTBInset, kLRInset);
    self.minimumInteritemSpacing = (viewH - kCellWH * kNumOfRow - kTBInset * 2) / (kNumOfRow - 1);
    self.minimumLineSpacing = (viewW - kCellWH * kNumOfColumn - kLRInset * 2) / (kNumOfColumn - 1);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalArray = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *modifiedMArray = [NSMutableArray arrayWithCapacity:originalArray.count];
    for (UICollectionViewLayoutAttributes *attributes in originalArray) {
        [modifiedMArray addObject:[self layoutAttributesForItemAtIndexPath:attributes.indexPath]];
    }
    return modifiedMArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    NSInteger section = indexPath.section;
    NSInteger item = indexPath.item;
    CGFloat viewW = self.collectionView.frame.size.width;
    CGFloat x = kLRInset + (kCellWH + self.minimumLineSpacing) * (item % kNumOfColumn) + section * viewW;
    CGFloat y = kTBInset + (kCellWH + self.minimumInteritemSpacing) * (item / kNumOfColumn);
    attributes.frame = CGRectMake(x, y, kCellWH, kCellWH);
    return attributes;
}

@end
