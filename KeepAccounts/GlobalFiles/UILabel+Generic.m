//
//  UILabel+Generic.m
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/7/23.
//  Copyright © 2018 王瑞果. All rights reserved.
//

#import "UILabel+Generic.h"

@implementation UILabel (Generic)
+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = [UIColor whiteColor];
    return label;
}
@end
