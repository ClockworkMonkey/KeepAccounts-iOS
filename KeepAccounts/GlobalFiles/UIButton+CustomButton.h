//
//  UIButton+CustomButton.h
//  WRGExamples
//
//  Created by 王瑞果 on 2017/12/26.
//  Copyright © 2017年 王瑞果. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CustomButtonStyle) {
    ButtonStyleImageTop,
    ButtonStyleImageLeft,
    ButtonStyleImageBottom,
    ButtonStyleImageRight
};

@interface UIButton (CustomButton)
- (void)layoutButtonStyle:(CustomButtonStyle)buttonStyle imageTitleSpace:(CGFloat)space;
@end
