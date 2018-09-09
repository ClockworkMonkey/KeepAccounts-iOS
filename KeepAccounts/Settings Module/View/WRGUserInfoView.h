//
//  WRGUserInfoView.h
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/23.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TapViewBlock)(id sender);

@interface WRGUserInfoView : UIView
- (void)addTapAction:(TapViewBlock)block;
@end
