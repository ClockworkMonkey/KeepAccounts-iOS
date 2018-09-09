//
//  WRGCategoryFlowLayout.m
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/9/9.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGCategoryFlowLayout.h"

CGFloat const kItemWH = 50.f;

@implementation WRGCategoryFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(kItemWH, kItemWH);
    self.sectionInset = UIEdgeInsetsMake(10, 15, 15, 15);
    self.minimumInteritemSpacing = 10.f;
    self.minimumLineSpacing = 20.f;
    self.headerReferenceSize = CGSizeMake(self.collectionView.bounds.size.width, 50);
}

@end
