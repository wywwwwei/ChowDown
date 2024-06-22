//
//  CDHomepageShopCell.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDHomepageShopCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CDHomepageShopItem

@end

@interface CDHomepageShopCell ()

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation CDHomepageShopCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8.f;
        [self setupAvatarView];
        [self setupNameLabel];
        [self setupDescLabel];
    }
    return self;
}

- (void)setItem:(CDHomepageShopItem *)item {
    _item = item;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:item.shopAvatarUrl]];
    self.nameLabel.text = item.shopName;
    [self.nameLabel sizeToFit];
    self.descLabel.text = item.shopDescription;
    [self.descLabel sizeToFit];
    [self setNeedsLayout];
}

- (void)setupAvatarView {
    if (self.avatarView) {
        return;
    }
    self.avatarView = [[UIImageView alloc] init];
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarView.layer.cornerRadius = 25.f;
    [self addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.left.offset(20);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setupNameLabel {
    if (self.nameLabel) {
        return;
    }
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    self.nameLabel.textColor = [UIColor blackColor];
    [self addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarView.mas_right).offset(10);
        make.top.mas_equalTo(14);
    }];
}

- (void)setupDescLabel {
    if (self.descLabel) {
        return;
    }
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.descLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [self addSubview:self.descLabel];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).offset(10);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
}
@end
