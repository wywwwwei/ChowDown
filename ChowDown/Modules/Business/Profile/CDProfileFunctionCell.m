//
//  CDProfileFunctionCell.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDProfileFunctionCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CDProfileFunctionItem

@end

@interface CDProfileFunctionCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *functionLabel;

@end

@implementation CDProfileFunctionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupIconView];
        [self setupFunctionLabel];
    }
    return self;
}

- (void)setItem:(CDProfileFunctionItem *)item {
    _item = item;
    if (item.iconName.length > 0) {
        self.iconView.image = [UIImage imageNamed:item.iconName];
    } else if (item.iconUrl.length > 0) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.iconUrl]];
    } else {
        self.iconView.image = nil;
    }
    self.functionLabel.text = item.functionTitle;
    [self setNeedsLayout];
}

- (void)setupIconView {
    if (self.iconView) {
        return;
    }
    self.iconView = [[UIImageView alloc] init];
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

- (void)setupFunctionLabel {
    if (self.functionLabel) {
        return;
    }
    self.functionLabel = [[UILabel alloc] init];
    [self addSubview:self.functionLabel];
    [self.functionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self);
    }];
}

@end
