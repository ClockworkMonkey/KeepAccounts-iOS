//
//  WRGOverviewView.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/18.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGOverviewView.h"


static CGFloat const margin = 10.f;
static CGFloat const smallFontSize = 15.f;
static CGFloat const bigFontSize = 25.f;


@interface WRGOverviewView ()
@property (nonatomic, strong) UILabel *expensesLabel;
@property (nonatomic, strong) UILabel *incomeLabel;
@property (nonatomic, strong) UILabel *bidgetLabel;
@end


@implementation WRGOverviewView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLOR_RANDOM;
        [self setupOverviewView];
    }
    return self;
}

- (void)setupOverviewView {
    
    UILabel *topTitleLabel = [UILabel labelWithFontSize:smallFontSize text:@"本月支出（元）"];
    [self addSubview:topTitleLabel];
    
    self.expensesLabel = [UILabel labelWithFontSize:smallFontSize text:@"暂无支出"];
    self.expensesLabel.font = [UIFont boldSystemFontOfSize:bigFontSize];
    [self addSubview:self.expensesLabel];
    
    UIView *leftView = [[UIView alloc] init];
    [self addSubview:leftView];
    
    UILabel *leftTitleLabel = [UILabel labelWithFontSize:smallFontSize text:@"本月收入"];
    [leftView addSubview:leftTitleLabel];
    
    self.incomeLabel = [UILabel labelWithFontSize:smallFontSize text:@"暂无收入"];
    [leftView addSubview:self.incomeLabel];
    
    UIView *rightView = [[UIView alloc] init];
    [self addSubview:rightView];
    
    UILabel *rightTitleLabel = [UILabel labelWithFontSize:smallFontSize text:@"预算剩余"];
    [rightView addSubview:rightTitleLabel];
    
    self.bidgetLabel = [UILabel labelWithFontSize:smallFontSize text:@"暂无"];
    [rightView addSubview:self.bidgetLabel];
    
    
    [topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).inset(margin * 2);
        make.left.equalTo(self).inset(margin);
    }];
    
    [self.expensesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topTitleLabel.mas_bottom).offset(margin);
        make.left.equalTo(self).inset(margin);
    }];
    
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.expensesLabel.mas_bottom).inset(margin);
        make.left.equalTo(self).inset(margin);
        make.bottom.equalTo(leftTitleLabel.mas_bottom);
        make.bottom.equalTo(self.mas_bottom).inset(margin);
    }];
    
    [leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(leftView);
    }];
    
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftView);
        make.left.equalTo(leftTitleLabel.mas_right);
        make.right.equalTo(leftView.mas_right);
    }];
    
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView.mas_top);
        make.left.equalTo(leftView.mas_right).inset(margin);
        make.right.equalTo(self).inset(margin);
        make.width.height.equalTo(leftView);
    }];
    
    [rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(rightView);
    }];
    
    [self.bidgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(rightView);
        make.left.equalTo(rightTitleLabel.mas_right);
    }];
    
}

- (void)reloadData:(NSString *)data {
    self.expensesLabel.text = data;
    self.bidgetLabel.text = data;
    self.incomeLabel.text = data;
}

@end
