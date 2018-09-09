//
//  WRGHomePageViewController.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/8/3.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGHomePageViewController.h"
#import "WRGRecordViewController.h"
#import "WRGOverviewView.h"
#import "WRGRecentBillView.h"

@interface WRGHomePageViewController ()
@property (nonatomic, strong) WRGOverviewView *overviewView;
@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, strong) WRGRecentBillView *recentBillView;
@end

@implementation WRGHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_RANDOM;
    
    [self setupHomePageView];
}

- (void)setupHomePageView {
    self.overviewView = [[WRGOverviewView alloc] init];
    [self.view addSubview:self.overviewView];
    
    self.recordButton = [[UIButton alloc] init];
    [self.view addSubview:self.recordButton];
    self.recordButton.titleLabel.textColor = [UIColor whiteColor];
    self.recordButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    self.recordButton.backgroundColor = COLOR_RANDOM;
    [self.recordButton setTitle:@"记一笔" forState:UIControlStateNormal];
    [self.recordButton addTarget:self action:@selector(recordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.recentBillView = [[WRGRecentBillView alloc] init];
    [self.view addSubview:self.recentBillView];
    
    [self.overviewView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            // Fallback on earlier versions
        }
    }];
    
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.overviewView.mas_bottom).offset(10);
        make.left.right.equalTo(self.view).inset(10);
    }];
    
    [self.recentBillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recordButton.mas_bottom).offset(10.f);
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (void)recordButtonAction {
    WRGRecordViewController *recordVC = [[WRGRecordViewController alloc] init];
    [self presentViewController:recordVC animated:YES completion:^{
        
    }];
}

@end
