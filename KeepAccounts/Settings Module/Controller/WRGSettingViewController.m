//
//  WRGSettingViewController.m
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/7/29.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGSettingViewController.h"
#import "WRGManageCategoryViewController.h"

static NSString * const kSettingsCellId = @"settingsCell";
static NSString * const kSettingsHeaderId = @"settingsHeaderView";
static CGFloat const kCellH = 50.f;

@interface WRGSettingViewController ()
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *settingsMArray;
@end

@implementation WRGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = @"设置";
    [self setupSettingView];
}

- (void)setupSettingView {
    self.tableView = [[UITableView alloc] init];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.settingsMArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dic = self.settingsMArray[section];
    NSArray *array = [dic valueForKey:@"settings"];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSettingsCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kSettingsCellId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.separatorInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic = self.settingsMArray[indexPath.section];
    NSArray *array = [dic valueForKey:@"settings"];
    NSDictionary *dicItem = array[indexPath.row];
    NSString *title = [dicItem valueForKey:@"title"];
    NSString *subtitle = [dicItem valueForKey:@"subtitle"];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subtitle;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:kSettingsHeaderId];
    if (headerView == nil) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:kSettingsHeaderId];
    }
    NSDictionary *dic = self.settingsMArray[section];
    NSString *title = [dic valueForKey:@"section"];
    headerView.textLabel.text = title;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 3) {
            WRGManageCategoryViewController *manageCategoryVC = [[WRGManageCategoryViewController alloc] init];
            [self.navigationController pushViewController:manageCategoryVC animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellH;
}

- (NSMutableArray *)settingsMArray {
    if (_settingsMArray == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"SettingsList" ofType:@"plist"];
        _settingsMArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    return _settingsMArray;
}

@end
