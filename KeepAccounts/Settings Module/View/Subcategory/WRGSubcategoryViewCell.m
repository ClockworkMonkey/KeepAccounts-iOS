//
//  WRGSubcategoryViewCell.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/8/29.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGSubcategoryViewCell.h"

CGFloat const kIconNormalWH = 30.f;
CGFloat const kIconSelectedWH = 35.f;
CGFloat const kSelectedImageWH = 15.f;

@interface WRGSubcategoryViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIImageView *flagImageView;
@end

@implementation WRGSubcategoryViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubcategoryViewCellWithSize:frame.size];
    }
    return self;
}

- (void)setupIconWithName:(NSString *)imageName color:(UIColor *)color {
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.iconImageView.backgroundColor = color;
}

- (void)setupSubcategoryViewCellWithSize:(CGSize)size {
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.layer.cornerRadius = kIconNormalWH / 2;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.flagImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.flagImageView];
    self.flagImageView.image = [UIImage imageNamed:@"selected_flag"];
    self.flagImageView.hidden = YES;
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.width.height.mas_equalTo(kIconNormalWH);
    }];
    
    [self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat x = (size.width - kIconNormalWH - kSelectedImageWH) / 2;
        CGFloat y = (size.height - kIconNormalWH - kSelectedImageWH) / 2;
        make.right.equalTo(self.contentView).inset(x);
        make.bottom.equalTo(self.contentView).inset(y);
        make.width.height.mas_equalTo(kSelectedImageWH);
    }];
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.iconImageView.layer.cornerRadius = kIconSelectedWH / 2;
        self.flagImageView.hidden = NO;
        [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(kIconSelectedWH);
        }];
    } else {
        self.iconImageView.layer.cornerRadius = kIconNormalWH / 2;
        self.flagImageView.hidden = YES;
        [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(kIconNormalWH);
        }];
    }
}

@end
