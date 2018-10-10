//
//  WRGEditCategoryViewController.h
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/10/9.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRGCategoryModel;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, WRGEditCategory) {
    AddCategory,
    EditCategory,
    AddSubcategory,
    EditSubcategory
};

@interface WRGEditCategoryViewController : UIViewController
@property (nonatomic, assign) BOOL isAddCategory;
@property (nonatomic, strong) WRGCategoryModel *category;
@property (nonatomic, strong) WRGCategoryModel *subcategory;
@end

NS_ASSUME_NONNULL_END
