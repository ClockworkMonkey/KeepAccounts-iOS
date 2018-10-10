//
//  WRGCategoryView.h
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/9/1.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRGCategoryModel;

@protocol WRGCategoryViewDelegate <NSObject>
@optional
- (void)didSelectItemWithCategoryModel:(WRGCategoryModel *)categoryModel subcategoryModel:(WRGCategoryModel *)subcategoryModel;
@end

@interface WRGCategoryView : UIView
@property (nonatomic, weak) id <WRGCategoryViewDelegate> delegate;
@end
