//
//  WRGAccountViewController.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/9/20.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGAccountViewController.h"

@interface WRGAccountViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation WRGAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"我的账号";
    [self setupAccountView];
}

- (void)setupAccountView {
    self.view.backgroundColor = COLOR_UI_WHITE;
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UIView *contentView = [[UIView alloc] init];
    [self.scrollView addSubview:contentView];
    
    UIButton *logoutButton = [[UIButton alloc] init];
    [self.view addSubview:logoutButton];
    [logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [logoutButton setTitleColor:COLOR_TEXT_WHITE forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    logoutButton.backgroundColor = COLOR_UI_RED;
    
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50.f);
    }];
}

- (void)logoutButtonAction {
    
}

@end
