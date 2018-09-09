//
//  WRGManageSubcategoryViewController.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/8/29.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGManageSubcategoryViewController.h"
#import "WRGSubcategoryView.h"

@interface WRGManageSubcategoryViewController ()
@property (nonatomic, strong) UITextField *subNameFiled;
@property (nonatomic, strong) WRGSubcategoryView *subcategoryView;
@end

@implementation WRGManageSubcategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_BG_GRAY;
    self.navigationItem.title = @"添加支出子类";
    
    [self setupManageSubcategoryView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupManageSubcategoryView {
    UIView *supInfoView = [[UIView alloc] init];
    [self.view addSubview:supInfoView];
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15.f text:@"大类名称：餐饮"];
    [supInfoView addSubview:nameLabel];
    nameLabel.textColor = COLOR_TEXT_GRAY_MSVC;
    
    UIView *subInfoView = [[UIView alloc] init];
    [self.view addSubview:subInfoView];
    subInfoView.backgroundColor = COLOR_BG_WHITE;
    
    UILabel *subNameLabel = [UILabel labelWithFontSize:15.f text:@"子类名称"];
    [subInfoView addSubview:subNameLabel];
    subNameLabel.textColor = COLOR_TEXT_GRAY_MSVC;
    
    self.subNameFiled = [[UITextField alloc] init];
    [subInfoView addSubview:self.subNameFiled];
    self.subNameFiled.clearButtonMode = UITextFieldViewModeAlways;
    self.subNameFiled.placeholder = @"（限4个汉字和12个英文字符）";
    self.subNameFiled.font = [UIFont systemFontOfSize:13.f];
    self.subNameFiled.textColor = COLOR_TEXT_DEFAULT;
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [subInfoView addSubview:iconImageView];
    iconImageView.image = [UIImage imageNamed:@"TestImage"];
    
    UIView *separatorView = [[UIView alloc] init];
    [subInfoView addSubview:separatorView];
    separatorView.backgroundColor = COLOR_BG_GRAY;
    
    self.subcategoryView = [[WRGSubcategoryView alloc] init];
    [self.view addSubview:self.subcategoryView];
    
    [supInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            // Fallback on earlier versions
        }
        make.height.mas_equalTo(40.f);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(supInfoView.mas_centerY);
        make.left.equalTo(supInfoView.mas_left).offset(kMargin * 1.5f);
    }];
    
    [subInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(supInfoView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50.f);
    }];
    
    [subNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subInfoView.mas_centerY);
        make.left.equalTo(subInfoView.mas_left).offset(kMargin * 1.5f);
    }];
    
    [self.subNameFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subInfoView.mas_centerY);
        make.left.equalTo(subNameLabel.mas_right).offset(kMargin * 1.5f);
    }];
    
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(subInfoView.mas_centerY);
        make.right.equalTo(subInfoView.mas_right).inset(kMargin * 1.5f);
        make.width.height.mas_equalTo(30.f);
    }];
    
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(subInfoView).inset(kMargin * 1.5f);
        make.bottom.equalTo(subInfoView);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.subcategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subInfoView.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
