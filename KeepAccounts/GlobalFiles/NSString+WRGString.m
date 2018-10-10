//
//  NSString+WRGString.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/9/22.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "NSString+WRGString.h"

@implementation NSString (WRGString)
+ (NSString *)creatUUID {
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef stringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge NSString *)stringRef;
}
@end
