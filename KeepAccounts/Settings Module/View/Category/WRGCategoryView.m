//
//  WRGCategoryView.m
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/9/1.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGCategoryView.h"
#import "WRGCategoryFlowLayout.h"
#import "WRGCategoryCell.h"
#import "WRGAddSubcategoryCell.h"
#import "WRGCategoryHeaderView.h"

NSString *const kCategoryCellID = @"CategoryCell";
NSString *const kAddCategoryCellID = @"AddCategoryCell";
NSString *const kCategoryHeaderID = @"CategoryHeader";

@interface WRGCategoryView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation WRGCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCategoryViewWithHeight:frame.size.height];
    }
    return self;
}

- (void)setupCategoryViewWithHeight:(CGFloat)height {
    WRGCategoryFlowLayout *flowLayout = [[WRGCategoryFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[WRGCategoryCell class] forCellWithReuseIdentifier:kCategoryCellID];
    [self.collectionView registerClass:[WRGAddSubcategoryCell class] forCellWithReuseIdentifier:kAddCategoryCellID];
    [self.collectionView registerClass:[WRGCategoryHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCategoryHeaderID];
    self.collectionView.backgroundColor = COLOR_BG_WHITE;
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WRGCategoryHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCategoryHeaderID forIndexPath:indexPath];
    headerView.backgroundColor = COLOR_RANDOM;
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WRGCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCategoryCellID forIndexPath:indexPath];
    WRGAddSubcategoryCell *addCell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddCategoryCellID forIndexPath:indexPath];
    cell.backgroundColor = COLOR_RANDOM;
    if (indexPath.row == 9) {
        return addCell;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section = %ld // row = %ld", indexPath.section, indexPath.row);
}

@end
