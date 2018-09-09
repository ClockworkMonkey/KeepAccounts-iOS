//
//  WRGCategoryCell.m
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/9/1.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGCategoryCell.h"

CGFloat const kImageWH = 35.f;

@interface WRGCategoryCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation WRGCategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCategoryViewCellWithSize:frame.size];
    }
    return self;
}

- (void)setupIconWithName:(NSString *)imageName color:(UIColor *)color {
    self.iconImageView.image = [UIImage imageNamed:imageName];
    self.iconImageView.backgroundColor = color;
}

- (void)setupCategoryViewCellWithSize:(CGSize)size {
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    self.iconImageView.layer.cornerRadius = kImageWH / 2;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.backgroundColor = COLOR_RANDOM;
    
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.text = @"名字名字";
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:10.f];
    self.nameLabel.backgroundColor = COLOR_RANDOM;
    
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.height.mas_equalTo(kImageWH);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom);
        make.left.bottom.right.equalTo(self.contentView);
    }];
}

@end
