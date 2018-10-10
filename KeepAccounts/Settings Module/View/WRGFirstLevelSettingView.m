//
//  WRGFirstLevelSettingView.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/24.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGFirstLevelSettingView.h"
#import "WRGFirstLevelSettingCell.h"
#import "WRGFirstLevelSettingModel.h"

static CGFloat const kCellHeight = 55.f;
static NSString * const kCellId = @"FirstLevelSettingCellReuseID";

@interface WRGFirstLevelSettingView ()
<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@end

@implementation WRGFirstLevelSettingView

- (instancetype)initWithDataArray:(NSArray *)dataSource {
    self = [super init];
    if (self) {
        if (dataSource) {
            self.dataSourceArray = dataSource;
            // 根据Cell的数量 更新View的高度
            [self mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(kCellHeight * self.dataSourceArray.count);
            }];
        } else {
            NSLog(@"数据源为空");
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupFirstLevelSettingView];
    }
    return self;
}

- (void)setupFirstLevelSettingView {
    self.tableView = [[UITableView alloc] init];
    [self addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, kMargin, 0, kMargin);
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WRGFirstLevelSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
    if (cell == nil) {
        cell = [[WRGFirstLevelSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellId];
    }
    [cell setupDataWithModel:self.dataSourceArray[indexPath.row]];
    return cell;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(firstLevelSettingView:didSelectRowAtIndexPath:)]) {
        [self.delegate firstLevelSettingView:self didSelectRowAtIndexPath:indexPath];
    }
}

@end
