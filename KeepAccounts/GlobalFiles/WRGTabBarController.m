//
//  WRGTabBarController.m
//  
//
//  Created by 王瑞果 on 2018/7/18.
//

#import "WRGTabBarController.h"
#import "WRGNavigationController.h"
#import "WRGHomePageViewController.h"
#import "WRGBillViewController.h"
#import "WRGMeViewController.h"

@interface WRGTabBarController ()

@end

@implementation WRGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTabBarItems];
}

- (void)addTabBarItems {
    [self addChildViewController:[[WRGNavigationController alloc] initWithRootViewController:[[WRGHomePageViewController alloc] init]]
                           title:@"首页"
                     normalImage:@""
                   selectedImage:@""];
    
    [self addChildViewController:[[WRGNavigationController alloc] initWithRootViewController:[[WRGBillViewController alloc] init]]
                           title:@"账单"
                     normalImage:@""
                   selectedImage:@""];
    
    [self addChildViewController:[[WRGNavigationController alloc] initWithRootViewController:[[WRGMeViewController alloc] init]]
                           title:@"我"
                     normalImage:@""
                   selectedImage:@""];
}

- (void)addChildViewController:(UIViewController *)childViewController title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage {
    childViewController.tabBarItem.title = title;
//    childViewController.tabBarItem.image = [UIImage imageNamed:normalImage];
//    childViewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:childViewController];
}

@end
