//
//  WRGUserInfoView.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/23.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGUserInfoView.h"

static CGFloat const kImageWH = 60.f;
static CGFloat const kBigFontSize = 18.f;
static CGFloat const kSmallFontSize = 13.f;

@interface WRGUserInfoView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) TapViewBlock block;
@end

@implementation WRGUserInfoView

- (void)dealloc {
    NSLog(@"------");
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUserInfoView];
        [self updateUserInfo];
        [self addNotificationObserver];
    }
    return self;
}

- (void)addNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo) name:@"Noti_Login" object:nil];
}

- (void)setupUserInfoView {
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tapGesture];
    
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"img_user"];
    self.imageView.layer.cornerRadius = kImageWH / 2;
    self.imageView.layer.masksToBounds = YES;
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    
    self.nameLabel = [UILabel labelWithFontSize:kBigFontSize text:@"立即登录"];
    [contentView addSubview:self.nameLabel];
    self.nameLabel.textColor = [UIColor blackColor];

    self.promptLabel = [UILabel labelWithFontSize:kSmallFontSize text:@"登陆后，在网易云端安全保存你的记账数据"];
    [contentView addSubview:self.promptLabel];
    self.promptLabel.textColor = [UIColor grayColor];
    self.promptLabel.numberOfLines = 0;
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).inset(kMargin);
        make.centerY.equalTo(self.mas_centerY).offset(kMargin);
        make.width.height.mas_equalTo(kImageWH);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageView.mas_right).offset(kMargin);
        make.right.equalTo(self).inset(kMargin);
        make.centerY.equalTo(self.mas_centerY).offset(kMargin);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
    }];
    
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(kMargin / 2);
        make.left.bottom.right.equalTo(contentView);
    }];
}

#pragma mark - Action
- (void)addTapAction:(TapViewBlock)block {
    self.block = block;
}

- (void)tapAction {
    if (self.block) {
        self.block(self);
    }
}

- (void)updateUserInfo {
    NSString *userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"User_Name"];
    if (userName) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = userName;
            self.promptLabel.text = @"查看并编辑个人资料";
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nameLabel.text = @"立即登录";
            self.promptLabel.text = @"登陆后，在网易云端安全保存你的记账数据";
        });
    }
}

@end
