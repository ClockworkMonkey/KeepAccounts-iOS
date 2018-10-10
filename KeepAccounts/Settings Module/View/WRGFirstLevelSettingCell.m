//
//  WRGFirstLevelSettingCell.m
//  KeepAccounts
//
//  Created by 王瑞果 on 2018/7/24.
//  Copyright © 2018年 王瑞果. All rights reserved.
//

#import "WRGFirstLevelSettingCell.h"
#import "WRGFirstLevelSettingModel.h"
#import "UIImage+CustomImage.h"

static CGFloat const kImageWH = 18.f;

@implementation WRGFirstLevelSettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupDataWithModel:(WRGFirstLevelSettingModel *)model {
    self.imageView.image = [UIImage imageWithSize:CGSizeMake(kImageWH, kImageWH) name:model.imageName];
    self.textLabel.text = model.settingName;
    self.detailTextLabel.text = model.settingDescription;
    self.detailTextLabel.font = [UIFont systemFontOfSize:13.f];
}

@end
