//
//  WRGEditSubcategoryViewController.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/10/10.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGEditSubcategoryViewController.h"
#import "WRGSubcategoryView.h"
#import "WRGCategoryModel.h"

@interface WRGEditSubcategoryViewController ()
@property (nonatomic, strong) UITextField *subNameFiled;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) WRGSubcategoryView *subcategoryView;
@property (nonatomic, assign) BOOL isEdit;
@end

@implementation WRGEditSubcategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_BG_GRAY;
    
    [self setupEditSubcategoryView];
}

- (void)setupEditSubcategoryView {    
    UIView *supInfoView = [[UIView alloc] init];
    [self.view addSubview:supInfoView];
    
    UILabel *nameLabel = [UILabel labelWithFontSize:15.f text:@""];
    [supInfoView addSubview:nameLabel];
    nameLabel.textColor = COLOR_TEXT_GRAY_MSVC;
    
    UIView *subInfoView = [[UIView alloc] init];
    [self.view addSubview:subInfoView];
    subInfoView.backgroundColor = COLOR_BG_WHITE;
    
    UILabel *subNameLabel = [UILabel labelWithFontSize:15.f text:@"子类名称："];
    [subInfoView addSubview:subNameLabel];
    subNameLabel.textColor = COLOR_TEXT_GRAY_MSVC;
    
    self.subNameFiled = [[UITextField alloc] init];
    [subInfoView addSubview:self.subNameFiled];
    self.subNameFiled.clearButtonMode = UITextFieldViewModeAlways;
    self.subNameFiled.placeholder = @"（限4个汉字和12个英文字符）";
    self.subNameFiled.font = [UIFont systemFontOfSize:13.f];
    self.subNameFiled.textColor = COLOR_TEXT_DEFAULT;
    
    self.iconImageView = [[UIImageView alloc] init];
    [subInfoView addSubview:self.iconImageView];
    self.iconImageView.layer.cornerRadius = 15.f;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor = COLOR_CATEGORY_BLUE;
    
    UIView *separatorView = [[UIView alloc] init];
    [subInfoView addSubview:separatorView];
    separatorView.backgroundColor = COLOR_BG_GRAY;
    
    UIButton *saveButton = [[UIButton alloc] init];
    [self.view addSubview:saveButton];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [saveButton setTitleColor:COLOR_TEXT_WHITE forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:20.f];
    saveButton.backgroundColor = COLOR_UI_RED;
    
    self.subcategoryView = [[WRGSubcategoryView alloc] init];
    [self.view addSubview:self.subcategoryView];
    
    [supInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            make.top.left.right.equalTo(self.view);
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
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subcategoryView.mas_bottom).offset(10.f);
        make.left.right.equalTo(self.view).inset(50.f);
        make.height.mas_equalTo(40.f);
    }];
    
    NSString *name = [NSString stringWithFormat:@"大类名称：%@", self.category.category_name];
    nameLabel.text = name;
    
    if (self.subcategory) {
        self.subNameFiled.text = self.subcategory.category_name;
        self.iconImageView.image = [UIImage imageNamed:self.subcategory.category_image];
    } else {
        self.iconImageView.image = [UIImage imageNamed:@"category_selected_000"];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)addButtonAction {
    [self.view endEditing:YES];
    
    [self updateData];
}

- (void)updateData {
    FMDatabase *database = [FMDatabase databaseWithPath:DATABASE_PATH];
    if ([database open]) {
        NSLog(@"打开数据库成功");
        
        NSString *category_uuid = [NSString creatUUID];
        NSString *category_name = self.subNameFiled.text;
        NSString *category_index = [NSString stringWithFormat:@"%ld", self.category.subcategory.count];
        NSString *parent_uuid = self.category.category_uuid;
        NSString *trsansaction_type = self.category.trsansaction_type;
        NSArray *sortArgumentsArray0 = @[category_uuid, category_name, category_index,
                                         @"1", parent_uuid, trsansaction_type,
                                         @"", @"category_selected_000"];
        
        dispatch_async(dispatch_queue_create("com.wangruiguo.db.insert", DISPATCH_QUEUE_CONCURRENT), ^{
            if ([database executeUpdate:SQL_INSERT_TB_CATEGORY withArgumentsInArray:sortArgumentsArray0] ) {
                NSLog(@"SQL_INSERT_TB_SORT 成功");
            } else {
                NSLog(@"SQL_INSERT_TB_SORT 失败");
            }
            
            if ([database close]) {
                NSLog(@"关闭数据库成功");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            } else {
                NSLog(@"关闭数据库失败");
            }
        });
    } else {
        NSLog(@"打开数据库失败");
    }
}
@end
