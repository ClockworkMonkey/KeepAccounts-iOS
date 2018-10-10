//
//  WRGCategoryHeaderView.h
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/9/1.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRGCategoryModel;

@interface WRGCategoryHeaderView : UICollectionReusableView
@property (nonatomic, strong) WRGCategoryModel *model;
- (void)setupHeaderViewWithCategoryModel:(WRGCategoryModel *)model;
@end
