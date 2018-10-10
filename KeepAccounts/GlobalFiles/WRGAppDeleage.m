//
//  WRGAppDeleage.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/18.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGAppDeleage.h"
#import "WRGTabBarController.h"

@implementation WRGAppDeleage

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    WRGTabBarController *tabBarVC = [[WRGTabBarController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = tabBarVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    dispatch_async(dispatch_queue_create("win.wangruiguo.db", DISPATCH_QUEUE_CONCURRENT), ^{
        [self creatDatabase];
    });
    
    return YES;
}

#pragma mark - 创建数据库
- (void)creatDatabase {
    NSLog(@"数据库地址：%@", DATABASE_PATH);
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userUUID = [userDefaults valueForKey:@"User_UUID"];
    
    if (userUUID != nil) {
        return;
    } else {
        userUUID = [NSString creatUUID];
        [userDefaults setValue:userUUID forKey:@"User_UUID"];
    }
    
    FMDatabase *database = [FMDatabase databaseWithPath:DATABASE_PATH];
    if ([database open]) {
        NSLog(@"打开数据库成功");
        
        if ([database executeUpdate:SQL_OPEN_FOREIGN_KEYS]) {
            NSLog(@"打开外键约束成功");
        } else {
            NSLog(@"打开外键约束失败");
        }
        
        if ([database executeUpdate:SQL_CREAT_TB_USER]) {
            NSLog(@"SQL_CREAT_TB_USER 成功");
        } else {
            NSLog(@"SQL_CREAT_TB_USER 失败");
        }
        
        if ([database executeUpdate:SQL_CREAT_TB_CATEGORY]) {
            NSLog(@"SQL_CREAT_TB_SORT 成功");
        } else {
            NSLog(@"SQL_CREAT_TB_SORT 失败");
        }
        
        if ([database executeUpdate:SQL_CREAT_TB_TRANSACTION]) {
            NSLog(@"SQL_CREAT_TB_TRANSACTION 成功");
        } else {
            NSLog(@"SQL_CREAT_TB_TRANSACTION 失败");
        }
        
        NSArray *userArgumentsArray = @[userUUID, @"Ruiguo Wang", @"wangruiguo@gmail.com", @"123456", [NSNumber numberWithDouble:2000.0]];
        if ([database executeUpdate:SQL_INSERT_TB_USER withArgumentsInArray:userArgumentsArray] ) {
            NSLog(@"SQL_INSERT_TB_USER 成功");
        } else {
            NSLog(@"SQL_INSERT_TB_USER 失败");
        }
        
        
        NSString *sortUUID0 = [NSString creatUUID];
        NSArray *sortArgumentsArray0 = @[sortUUID0, @"餐饮", @"0", @"0", [NSNull null], @"0", userUUID, @"category_selected_000"];
        if ([database executeUpdate:SQL_INSERT_TB_CATEGORY withArgumentsInArray:sortArgumentsArray0] ) {
            NSLog(@"SQL_INSERT_TB_SORT_0 成功");
        } else {
            NSLog(@"SQL_INSERT_TB_SORT_0 失败");
        }
        
        NSString *sortUUID1 = [NSString creatUUID];
        NSArray *sortArgumentsArray1 = @[sortUUID1, @"购物", @"1", @"0", [NSNull null], @"0", userUUID, @"category_selected_001"];
        if ([database executeUpdate:SQL_INSERT_TB_CATEGORY withArgumentsInArray:sortArgumentsArray1] ) {
            NSLog(@"SQL_INSERT_TB_SORT_1 成功");
        } else {
            NSLog(@"SQL_INSERT_TB_SORT_1 失败");
        }
        
        NSString *sortUUID2 = [NSString creatUUID];
        NSArray *sortArgumentsArray2 = @[sortUUID2, @"交通", @"2", @"0", [NSNull null], @"0", userUUID, @"category_selected_002"];
        if ([database executeUpdate:SQL_INSERT_TB_CATEGORY withArgumentsInArray:sortArgumentsArray2] ) {
            NSLog(@"SQL_INSERT_TB_SORT_2 成功");
        } else {
            NSLog(@"SQL_INSERT_TB_SORT_2 失败");
        }
        
        [database close];
        
    } else {
        database = nil;
        NSLog(@"打开数据库失败");
    }
}

@end
