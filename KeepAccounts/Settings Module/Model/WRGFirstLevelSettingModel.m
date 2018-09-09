//
//  WRGFirstLevelSettingModel.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/24.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGFirstLevelSettingModel.h"

@implementation WRGFirstLevelSettingModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        self.imageName = [dic valueForKey:@"imageName"];
        self.settingName = [dic valueForKey:@"settingName"];
        self.settingDescription = [dic valueForKey:@"settingDescription"];
    }
    return self;
}

+ (instancetype)modelWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

@end
