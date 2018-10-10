//
//  WRGCategoryModel.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/9/22.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGCategoryModel.h"

@implementation WRGCategoryModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.parent_uuid = [dic valueForKey:@"parent_uuid"];
        self.category_uuid = [dic valueForKey:@"category_uuid"];
        self.category_name = [dic valueForKey:@"category_name"];
        self.category_type = [dic valueForKey:@"category_type"];
        self.trsansaction_type = [dic valueForKey:@"transaction_type"];
        self.category_image = [dic valueForKey:@"image_name"];
        self.index = [dic valueForKey:@"category_index"];
        self.isHeaderOpen = NO;
        self.subcategory = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

@end
