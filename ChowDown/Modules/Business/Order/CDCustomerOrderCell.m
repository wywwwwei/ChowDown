//
//  CDCustomerOrderCell.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import "CDCustomerOrderCell.h"
#import <Masonry/Masonry.h>

@interface CDCustomerOrderCell ()

@property (nonatomic, strong) UILabel *shopLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *buyItemImageView;

@end

@implementation CDCustomerOrderCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 8.f;
    [self setupStatusLabel];
    [self setupShopLabel];
    [self setupBuyItemImageView];
    [self setupOrderTimeLabel];
    [self setupPriceLabel];
}

- (void)setModel:(CDBaseOrderModel *)model {
    _model = model;
    self.statusLabel.text = model.orderTypeString;
    self.shopLabel.text = model.shopName;
    self.buyItemImageView.image = [UIImage imageNamed:model.buyItems.firstObject.coverUrl];
    self.orderTimeLabel.text = [@"Order Time: " stringByAppendingString:model.time];
    self.priceLabel.text = [@"Price: " stringByAppendingString:model.price];
}

- (void)setupShopLabel {
    if (self.shopLabel) {
        return;
    }
    self.shopLabel = [[UILabel alloc] init];
    self.shopLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
    self.shopLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.shopLabel];
    [self.shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(12);
        make.left.mas_offset(12);
        make.right.mas_lessThanOrEqualTo(self.statusLabel.mas_left);
    }];
}

- (void)setupStatusLabel {
    if (self.statusLabel) {
        return;
    }
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(12);
        make.right.mas_offset(-12);
    }];
}

- (void)setupBuyItemImageView {
    if (self.buyItemImageView) {
        return;
    }
    self.buyItemImageView = [[UIImageView alloc] init];
    self.buyItemImageView.layer.cornerRadius = 8.f;
    self.buyItemImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.buyItemImageView];
    [self.buyItemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.top.mas_equalTo(self.shopLabel.mas_bottom).offset(12);
        make.left.mas_offset(12);
    }];
}

- (void)setupOrderTimeLabel {
    if (self.orderTimeLabel) {
        return;
    }
    self.orderTimeLabel = [[UILabel alloc] init];
    self.orderTimeLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.orderTimeLabel];
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.buyItemImageView.mas_top).offset(6);
        make.left.mas_equalTo(self.buyItemImageView.mas_right).offset(12);
    }];
}

- (void)setupPriceLabel {
    if (self.priceLabel) {
        return;
    }
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.buyItemImageView.mas_bottom).offset(-6);
        make.left.mas_equalTo(self.buyItemImageView.mas_right).offset(12);
    }];
}

@end
