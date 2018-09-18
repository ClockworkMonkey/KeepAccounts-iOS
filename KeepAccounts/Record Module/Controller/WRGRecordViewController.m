//
//  WRGRecordViewController.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/18.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGRecordViewController.h"

@interface WRGRecordViewController ()
//@property (nonatomic, strong)
@end


@implementation WRGRecordViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_RANDOM;
    
    [self setupRecordView];
}

- (void)setupRecordView {
    UIView *navigationView = [[UIView alloc] init];
    [self.view addSubview:navigationView];
    navigationView.backgroundColor = COLOR_RANDOM;
    
    UIButton *dismissButton = [[UIButton alloc] init];
    [navigationView addSubview:dismissButton];
    dismissButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    [dismissButton setTitle:@"消失" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismissButtonAction) forControlEvents:UIControlEventTouchUpInside];
    dismissButton.backgroundColor = COLOR_RANDOM;
    
    NSArray *itemArray = @[@"支出", @"收入"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    [navigationView addSubview:segmentedControl];
    
    
    UIView *moneyView = [[UIView alloc] init];
    [self.view addSubview:moneyView];
    moneyView.backgroundColor = COLOR_RANDOM;
    
    UILabel *moneyLabel = [UILabel labelWithFontSize:15.f text:@"金额"];
    [moneyView addSubview:moneyLabel];
    moneyLabel.backgroundColor = COLOR_RANDOM;
    
    UITextField *moneyField = [[UITextField alloc] init];
    [moneyView addSubview:moneyField];
    moneyField.backgroundColor = COLOR_RANDOM;
    
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(80.f);
    }];
    
    [dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(navigationView).inset(kMargin / 2.f);
    }];
    
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(navigationView.mas_centerX);
        make.bottom.mas_equalTo(navigationView.mas_bottom).inset(kMargin / 2);
    }];
    
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(60.f);
    }];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(moneyView);
        make.width.mas_equalTo(moneyView.mas_width).multipliedBy(0.2);
    }];
    [moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(moneyView);
        make.left.mas_equalTo(moneyLabel.mas_right);
    }];
}

- (void)dismissButtonAction {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
