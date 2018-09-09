//
//  WRGManageCategoryViewController.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/8/29.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGManageCategoryViewController.h"
#import "WRGManageSubcategoryViewController.h"
#import "WRGCategoryView.h"

@interface WRGManageCategoryViewController ()
@property (nonatomic, strong) WRGCategoryView *categoryView;
@end

@implementation WRGManageCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"分类管理";
    self.view.backgroundColor = COLOR_UI_WHITE;
    
    [self setupManageCategoryView];
}

- (void)setupManageCategoryView {
    UIView *classifyView = [[UIView alloc] init];
    [self.view addSubview:classifyView];
    classifyView.backgroundColor = COLOR_RANDOM;
    
    self.categoryView = [[WRGCategoryView alloc] init];
    [self.view addSubview:self.categoryView];
    self.categoryView.backgroundColor = COLOR_RANDOM;
    
    UIView *addCategoryView = [[UIView alloc] init];
    [self.view addSubview:addCategoryView];
    addCategoryView.backgroundColor = COLOR_RANDOM;
    
    UIButton *addCategoryButton = [[UIButton alloc] init];
    [self.view addSubview:addCategoryButton];
    [addCategoryButton setTitle:@"添加大类（子类）" forState:UIControlStateNormal];
    [addCategoryButton setTitleColor:COLOR_TEXT_DEFAULT forState:UIControlStateNormal];
    [addCategoryButton addTarget:self action:@selector(addCategoryButtonAction) forControlEvents:UIControlEventTouchUpInside];
    addCategoryButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    addCategoryButton.backgroundColor = COLOR_BG_GRAY;
    
    [classifyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.mas_equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.mas_equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            // Fallback on earlier versions
            make.top.left.right.equalTo(self.view);
        }
        make.height.mas_equalTo(35.f);
    }];
    
    [self.categoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(classifyView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(addCategoryView.mas_top);
    }];
    
    [addCategoryView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50.f);
    }];
    
    [addCategoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(addCategoryView);
    }];
}

- (void)addCategoryButtonAction {
    NSLog(@"buttonAction");
    WRGManageSubcategoryViewController *manageSubVC = [[WRGManageSubcategoryViewController alloc] init];
    [self.navigationController pushViewController:manageSubVC animated:YES];
}

@end
