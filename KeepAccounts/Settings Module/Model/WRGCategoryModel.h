//
//  WRGCategoryModel.h
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/9/22.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WRGCategoryModel : NSObject
@property (nonatomic, copy) NSString *category_uuid;
@property (nonatomic, copy) NSString *category_name;
@property (nonatomic, copy) NSString *category_image;
@property (nonatomic, copy) NSString *category_type;
@property (nonatomic, copy) NSString *parent_uuid;
@property (nonatomic, copy) NSString *trsansaction_type;
@property (nonatomic, copy) NSString *index;
@property (nonatomic, strong) NSMutableArray *subcategory;
@property (nonatomic, assign) BOOL isHeaderOpen;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
