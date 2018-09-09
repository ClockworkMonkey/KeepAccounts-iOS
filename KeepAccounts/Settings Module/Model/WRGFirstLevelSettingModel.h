//
//  WRGFirstLevelSettingModel.h
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/24.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WRGFirstLevelSettingModel : NSObject
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *settingName;
@property (nonatomic, copy) NSString *settingDescription;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)modelWithDic:(NSDictionary *)dic;
@end
