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
#import "WRGCategoryModel.h"

NSString *const kCategoryCellID = @"CategoryCell";
NSString *const kAddCategoryCellID = @"AddCategoryCell";
NSString *const kCategoryHeaderID = @"CategoryHeader";

@interface WRGCategoryView ()
<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *categoryMArray;
@end

@implementation WRGCategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        dispatch_async(dispatch_queue_create("win.wangruiguo.db.query.category", DISPATCH_QUEUE_CONCURRENT), ^{
            [self queryCategoryInfoWith:@"0"];
        });
    }
    return self;
}

- (void)setupCategoryView {
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
    return self.categoryMArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    WRGCategoryModel *model = self.categoryMArray[section];
    return model.isHeaderOpen ? (model.subcategory.count + 1) : 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    WRGCategoryHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kCategoryHeaderID forIndexPath:indexPath];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionHeaderViewTapAction:)];
    [headerView addGestureRecognizer:tapGesture];
    [headerView setupHeaderViewWithCategoryModel:self.categoryMArray[indexPath.section]];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WRGCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCategoryCellID forIndexPath:indexPath];
    WRGAddSubcategoryCell *addCell = [collectionView dequeueReusableCellWithReuseIdentifier:kAddCategoryCellID forIndexPath:indexPath];
    WRGCategoryModel *model = self.categoryMArray[indexPath.section];
    return  (model.subcategory.count == 0) || (indexPath.row == model.subcategory.count) ? addCell : cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didSelectItemWithCategoryModel:subcategoryModel:)]) {
        WRGCategoryModel *category = self.categoryMArray[indexPath.section];
        if (category.subcategory.count == indexPath.row) {
            [self.delegate didSelectItemWithCategoryModel:category subcategoryModel:nil];
        } else {
            WRGCategoryModel *subcategory = category.subcategory[indexPath.row];
            [self.delegate didSelectItemWithCategoryModel:category subcategoryModel:subcategory];
        }
    }
}

- (void)collectionHeaderViewTapAction:(UITapGestureRecognizer *)sender {
    WRGCategoryHeaderView *headerView = (WRGCategoryHeaderView *)sender.view;
    NSUInteger index = headerView.model.index.integerValue;
    WRGCategoryModel *model = self.categoryMArray[index];
    model.isHeaderOpen = !model.isHeaderOpen;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:index];
    [self.collectionView reloadSections:indexSet];
}



- (void)queryCategoryInfoWith:(NSString *)type {
    FMDatabase *database = [FMDatabase databaseWithPath:DATABASE_PATH];
    if ([database open]) {
        NSLog(@"打开数据库成功");
        
        self.categoryMArray = [[NSMutableArray alloc] init];
        
        /** 查询父类 */
        FMResultSet *parentSet = [database executeQuery:SQL_SELECT_CATEGORY withArgumentsInArray:@[type]];
        while ([parentSet next]) {
            [self.categoryMArray addObject:[WRGCategoryModel modelWithDic:parentSet.resultDictionary]];
        }

        /** 查询每个父类下的子类 */
        for (WRGCategoryModel *category in self.categoryMArray) {
            FMResultSet *subcategorySet = [database executeQuery:SQL_SELECT_SUBCATEGORY withArgumentsInArray:@[category.category_uuid]];
            NSMutableArray *mArray = [[NSMutableArray alloc] init];
            while ([subcategorySet next]) {
                [mArray addObject:[WRGCategoryModel modelWithDic:subcategorySet.resultDictionary]];
            }
            category.subcategory = mArray;
        }
        
        if ([database close]) {
            NSLog(@"关闭数据库成功");
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setupCategoryView];
            });
        } else {
            NSLog(@"关闭数据库失败");
        }

    } else {
        NSLog(@"打开数据库失败");
    }
}

@end
