//
//  WRGMeViewController.m
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/7/29.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGMeViewController.h"
#import "WRGUserInfoView.h"
#import "WRGFirstLevelSettingView.h"
#import "WRGFirstLevelSettingModel.h"
#import "WRGLoginViewController.h"
#import "WRGSettingViewController.h"
#import "WRGAccountViewController.h"

CGFloat const kUserInfoVH = 150.f;

@interface WRGMeViewController ()
<WRGFirstLevelSettingDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) WRGUserInfoView *userInfoView;
@property (nonatomic, strong) WRGFirstLevelSettingView *adSettingView;
@property (nonatomic, strong) WRGFirstLevelSettingView *appSettingView;
@property (nonatomic, strong) NSMutableArray <WRGFirstLevelSettingModel *> *adSettingDataMArray;
@property (nonatomic, strong) NSMutableArray <WRGFirstLevelSettingModel *> *appSettingDataMArray;
@end


@implementation WRGMeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSettingView];
}

- (void)setupSettingView {
    
    self.navigationItem.title = @"我";
    self.view.backgroundColor = COLOR_UI_WHITE;
    
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UIView *contentView = [[UIView alloc] init];
    [self.scrollView addSubview:contentView];
    contentView.backgroundColor = COLOR_UI_GRAY;
    
    self.userInfoView = [[WRGUserInfoView alloc] init];
    [contentView addSubview:self.userInfoView];
    
    __weak typeof(self) weakSelf = self;
    [self.userInfoView addTapAction:^(id sender) {
        __strong typeof(self) strongSelf = weakSelf;
        UIViewController *viewController = nil;
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"User_Name"]) {
            viewController = [[WRGAccountViewController alloc] init];
        } else {
            viewController = [[WRGLoginViewController alloc] init];
        }
        viewController.hidesBottomBarWhenPushed = YES;
        [strongSelf.navigationController pushViewController:viewController animated:YES];
    }];
    
    self.adSettingView = [[WRGFirstLevelSettingView alloc] initWithDataArray:self.adSettingDataMArray];
    [contentView addSubview:self.adSettingView];
    self.adSettingView.tag = 1001;
    self.adSettingView.delegate = self;
    self.adSettingView.backgroundColor = COLOR_RANDOM;
    
    self.appSettingView = [[WRGFirstLevelSettingView alloc] initWithDataArray:self.appSettingDataMArray];
    [contentView addSubview:self.appSettingView];
    self.appSettingView.tag = 1002;
    self.appSettingView.delegate = self;
    self.appSettingView.backgroundColor = COLOR_RANDOM;
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.mas_equalTo(self.scrollView.mas_height).offset(kMargin * 2);
    }];
    
    [self.userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(kUserInfoVH);
    }];
    
    [self.adSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userInfoView.mas_bottom).offset(kMargin);
        make.left.right.equalTo(self.view);
    }];
    
    [self.appSettingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.adSettingView.mas_bottom).offset(kMargin);
        make.left.right.equalTo(self.view);
    }];
}


#pragma mark - WRGFirstLevelSettingDelegate

- (void)firstLevelSettingView:(WRGFirstLevelSettingView *)firstLevelSettingView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (firstLevelSettingView.tag == 1001) {
        NSLog(@"你点击的广告！");
    } else if (firstLevelSettingView.tag == 1002) {
        switch (indexPath.row) {
            case 0:
                NSLog(@"000");
                break;
                
            case 1:
                NSLog(@"111");
                break;
                
            case 2: {
                WRGSettingViewController *settingVC = [[WRGSettingViewController alloc] init];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

- (NSMutableArray *)adSettingDataMArray {
    if (_adSettingDataMArray == nil) {
        _adSettingDataMArray = [[NSMutableArray alloc] init];
        NSArray *dicArray = @[
                              @{@"imageName" : @"TestImage", @"settingName" : @"有钱基金", @"settingDescription" : @"全场费率1折起"},
                              @{@"imageName" : @"TestImage", @"settingName" : @"网易来钱", @"settingDescription" : @"高额秒批想借就借"},
                              @{@"imageName" : @"TestImage", @"settingName" : @"我的福利", @"settingDescription" : @"活动、券码"},
                              @{@"imageName" : @"TestImage", @"settingName" : @"记账赢现金", @"settingDescription" : @"一边记账一边赚钱"},
                              @{@"imageName" : @"TestImage", @"settingName" : @"免！费！送", @"settingDescription" : @"广告"}];
        for (NSDictionary *dic in dicArray) {
            WRGFirstLevelSettingModel *model = [WRGFirstLevelSettingModel modelWithDic:dic];
            [_adSettingDataMArray addObject:model];
        }
    }
    return _adSettingDataMArray;
}

- (NSMutableArray *)appSettingDataMArray {
    if (_appSettingDataMArray == nil) {
        _appSettingDataMArray = [[NSMutableArray alloc] init];
        NSArray *dicArray = @[
                              @{@"imageName" : @"TestImage", @"settingName" : @"通知和帮助", @"settingDescription" : @"通知、帮助、客服"},
                              @{@"imageName" : @"TestImage", @"settingName" : @"实用工具", @"settingDescription" : @""},
                              @{@"imageName" : @"TestImage", @"settingName" : @"设置", @"settingDescription" : @""}];
        for (NSDictionary *dic in dicArray) {
            WRGFirstLevelSettingModel *model = [WRGFirstLevelSettingModel modelWithDic:dic];
            [_appSettingDataMArray addObject:model];
        }
    }
    return _appSettingDataMArray;
}

@end
