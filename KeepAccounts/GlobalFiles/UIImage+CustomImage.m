//
//  UIImage+CustomImage.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/24.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "UIImage+CustomImage.h"

@implementation UIImage (CustomImage)

+ (UIImage *)imageWithSize:(CGSize)imageSize name:(NSString *)imageName {
    UIImage *initialImage = [UIImage imageNamed:imageName];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.f, 0.f, imageSize.width, imageSize.height);
    [initialImage drawInRect:imageRect];
    UIImage *modifiedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return modifiedImage;
}

@end
