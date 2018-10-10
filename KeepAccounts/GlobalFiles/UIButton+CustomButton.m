//
//  UIButton+CustomButton.m
//  WRGExamples
//
//  Created by 王瑞果 on 2017/12/26.
//  Copyright © 2017年 王瑞果. All rights reserved.
//

#import "UIButton+CustomButton.h"

@implementation UIButton (CustomButton)
- (void)layoutButtonStyle:(CustomButtonStyle)buttonStyle imageTitleSpace:(CGFloat)space
{
    CGFloat halfSpace = space / 2;
    
    /* 获取按钮imageView的宽高 */
    CGFloat imageViewHeight = self.imageView.bounds.size.height;
    CGFloat imageViewWidth = self.imageView.bounds.size.width;
    
    /* 获取按钮titleLabel的宽高 */
    CGFloat labelHeight = self.titleLabel.bounds.size.height;
    CGFloat labelWidth = self.titleLabel.bounds.size.width;
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets titleEdgeInsets = UIEdgeInsetsZero;
    
    switch (buttonStyle) {
        case ButtonStyleImageTop:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, labelHeight + halfSpace, -labelWidth);
            titleEdgeInsets = UIEdgeInsetsMake(imageViewHeight + halfSpace, -imageViewWidth, 0, 0);
            break;
            
        case ButtonStyleImageLeft:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, halfSpace);
            titleEdgeInsets = UIEdgeInsetsMake(0, halfSpace, 0, 0);
            break;
            
        case ButtonStyleImageBottom:
            imageEdgeInsets = UIEdgeInsetsMake(labelHeight + halfSpace, 0, 0, -labelWidth);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageViewWidth, imageViewHeight + halfSpace, 0);
            break;
            
        case ButtonStyleImageRight:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -labelWidth * 2 - halfSpace);
            titleEdgeInsets = UIEdgeInsetsMake(0, -imageViewWidth * 2 - halfSpace, 0, 0);
            break;
            
        default:
            break;
    }
    
    self.imageEdgeInsets = imageEdgeInsets;
    self.titleEdgeInsets = titleEdgeInsets;
}
@end
