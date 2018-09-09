//
//  WRGFirstLevelSettingView.h
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/24.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WRGFirstLevelSettingModel;
@class WRGFirstLevelSettingView;

@protocol WRGFirstLevelSettingDelegate <NSObject>
- (void)firstLevelSettingView:(WRGFirstLevelSettingView *)firstLevelSettingView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface WRGFirstLevelSettingView : UIView
@property (nonatomic, weak) id <WRGFirstLevelSettingDelegate> delegate;
/**
 带TableView的一级设置菜单View
 Cell高度 = (View高度 / dataSource.count)

 @param dataSource 设置模型数组 (imageName, settingName, settingDescription)
 @return 自定义设置菜单View
 */
- (instancetype)initWithDataArray:(NSArray <WRGFirstLevelSettingModel*> *)dataSource;

@end
