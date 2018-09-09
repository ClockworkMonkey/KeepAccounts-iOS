//
//  WRGSubcategoryView.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/8/29.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGSubcategoryView.h"
#import "WRGSubcategoryFlowLayout.h"
#import "WRGSubcategoryViewCell.h"

CGFloat const kPageControlH = 20.f;
CGFloat const kColloctionViewH = 230.f;
CGFloat const kViewH = kPageControlH + kColloctionViewH;
NSInteger const kItemOfAll = 148;   // 总共143个
NSInteger const kItemOfLine = 4;    // 4行
NSInteger const kItemOfRow = 5;     // 5列
NSInteger const kItemOfPage = kItemOfRow * kItemOfLine;                              // 每页
NSInteger const kNumberOfSection = kItemOfAll / (kItemOfRow * kItemOfLine) + 1;      // 页数
NSInteger const kSurplusItem = kItemOfAll % kItemOfPage;
NSString * const kCellID = @"SubcategoryViewCell";

@interface WRGSubcategoryView ()
<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation WRGSubcategoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubcategoryViewWithHeight:frame.size.height];
    }
    return self;
}

- (void)setupSubcategoryViewWithHeight:(CGFloat)height {
    WRGSubcategoryFlowLayout *flowLayout = [[WRGSubcategoryFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    [self addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[WRGSubcategoryViewCell class] forCellWithReuseIdentifier:kCellID];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = COLOR_BG_WHITE;
    
    self.pageControl = [[UIPageControl alloc] init];
    [self addSubview:self.pageControl];
    self.pageControl.numberOfPages = 5;
    self.pageControl.backgroundColor = COLOR_RANDOM;
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kViewH);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(kColloctionViewH);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.left.bottom.right.equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return kNumberOfSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return kItemOfPage;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WRGSubcategoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    NSInteger index = indexPath.section * 20 + indexPath.row;
    NSString *imageName = [NSString stringWithFormat:@"category_selected_%03ld", index];
    [cell setupIconWithName:imageName color:COLOR_CATEGORY_BLUE];
    cell.hidden = (indexPath.section == (kNumberOfSection - 1)) && (indexPath.row >= kSurplusItem);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section == %ld, row == %ld", (long)indexPath.section, (long)indexPath.row);
}

@end
