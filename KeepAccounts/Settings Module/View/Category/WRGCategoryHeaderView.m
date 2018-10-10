//
//  WRGCategoryHeaderView.m
//  KeepAccounts
//
//  Created by WangRuiguo on 2018/9/1.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGCategoryHeaderView.h"
#import "WRGCategoryModel.h"

@interface WRGCategoryHeaderView ()
@property (nonatomic, strong) UIImageView *directionImageView;
@property (nonatomic, strong) UIImageView *categoryImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@end

@implementation WRGCategoryHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCategoryHeaderView];
    }
    return self;
}

- (void)setupCategoryHeaderView {
    self.directionImageView = [[UIImageView alloc] init];
    [self addSubview:self.directionImageView];
    self.directionImageView.image = [UIImage imageNamed:@"btn_triangle_right"];
    
    self.categoryImageView = [[UIImageView alloc] init];
    [self addSubview:self.categoryImageView];
    self.categoryImageView.layer.cornerRadius = 18.f;
    self.categoryImageView.layer.masksToBounds = YES;
    self.categoryImageView.backgroundColor = COLOR_CATEGORY_RED;
    
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    self.titleLabel.font = [UIFont systemFontOfSize:18.f];
    self.titleLabel.textColor = COLOR_TEXT_DEFAULT;
    self.titleLabel.text = @"分类";
    
    self.moreButton = [[UIButton alloc] init];
    [self addSubview:self.moreButton];
    [self.moreButton setImage:[UIImage imageNamed:@"btn_more"] forState:UIControlStateNormal];
    
    UIView *separatorView = [[UIView alloc] init];
    [self addSubview:separatorView];
    separatorView.backgroundColor = COLOR_BG_GRAY;
    
    [self.directionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kMargin * 1.5f);
        make.width.height.mas_equalTo(12.f);
    }];
    
    [self.categoryImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.directionImageView.mas_right).offset(15.f);
        make.width.height.mas_equalTo(36.f);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.categoryImageView.mas_right).offset(15.f);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).inset(15.f);
        make.width.height.mas_equalTo(18.f);
    }];
    
    [separatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).inset(15.f);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.8f);
    }];
}

- (void)setupHeaderViewWithCategoryModel:(WRGCategoryModel *)model {
    self.model = model;
    
    self.categoryImageView.image = [UIImage imageNamed:model.category_image];
    self.titleLabel.text = model.category_name;
    
    // directionImageView 旋转
    CGFloat angle = model.isHeaderOpen ? M_PI * 0.5 : 0;
    CGAffineTransform transform = CGAffineTransformMakeRotation(angle);
    [UIView animateWithDuration:0.5 animations:^{
        self.directionImageView.transform = transform;
    }];
}

@end
