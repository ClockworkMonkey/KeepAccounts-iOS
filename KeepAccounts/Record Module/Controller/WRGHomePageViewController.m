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
@property (nonatomic, strong) UIButton *addAssetButton;
@property (nonatomic, strong) WRGRecentBillView *recentBillView;
@end

@implementation WRGHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = COLOR_RANDOM;
    
    [self setupHomePageView];
}

- (void)setupHomePageView {
    self.overviewView = [[WRGOverviewView alloc] init];
    [self.view addSubview:self.overviewView];
    
    UIView *recordView = [[UIView alloc] init];
    [self.view addSubview:recordView];
    recordView.backgroundColor = COLOR_RANDOM;
    
    UIView *separatorView = [[UIView alloc] init];
    [recordView addSubview:separatorView];
    separatorView.backgroundColor = COLOR_UI_WHITE;
    
    self.recordButton = [[UIButton alloc] init];
    [recordView addSubview:self.recordButton];
    self.recordButton.titleLabel.textColor = [UIColor whiteColor];
    self.recordButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    self.recordButton.backgroundColor = COLOR_RANDOM;
    [self.recordButton setTitle:@"记一笔" forState:UIControlStateNormal];
    [self.recordButton addTarget:self action:@selector(recordButtonAction) forControlEvents:UIControlEventTouchUpInside];

    self.addAssetButton = [[UIButton alloc] init];
    [recordView addSubview:self.addAssetButton];
    self.addAssetButton.titleLabel.textColor = [UIColor whiteColor];
    self.addAssetButton.titleLabel.font = [UIFont systemFontOfSize:12.f];
    self.addAssetButton.backgroundColor = COLOR_RANDOM;
    [self.addAssetButton setTitle:@"添加资产" forState:UIControlStateNormal];
    [self.addAssetButton addTarget:self action:@selector(recordButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.recentBillView = [[WRGRecentBillView alloc] init];
    [self.view addSubview:self.recentBillView];
    
    [self.overviewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
    }];
    
    [recordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.overviewView.mas_bottom).offset(kMargin);
        make.left.right.equalTo(self.view).inset(kMargin);
        make.height.mas_equalTo(30.f);
    }];
    
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(recordView).inset(kMargin * 0.5f);
        make.width.mas_equalTo(1.f);
        make.centerX.equalTo(recordView).multipliedBy(1.5f);
        make.centerY.equalTo(recordView);
    }];
    
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(recordView);
        make.right.equalTo(separatorView.mas_left);
    }];

    [self.addAssetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(recordView);
        make.left.equalTo(separatorView.mas_right);
    }];
    
    [self.recentBillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(recordView.mas_bottom).offset(kMargin);
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (void)recordButtonAction {
    WRGRecordViewController *recordVC = [[WRGRecordViewController alloc] init];
    [self presentViewController:recordVC animated:YES completion:^{
        
    }];
}

@end
