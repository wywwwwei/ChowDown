//
//  SubmitOrderTableViewCell.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDSubmitOrderTableViewCell.h"
#import <Masonry/Masonry.h>

@interface CDSubmitOrderTableViewCell ()

@property(nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *numberLabel;

@property(nonatomic, strong) UILabel *priceLabel;


@end

@implementation CDSubmitOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.01];
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor=  [UIColor whiteColor];
        [self addSubview:self.backView];

        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 80)];
        self.iconImageView.backgroundColor = [UIColor lightGrayColor];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImageView.layer.cornerRadius = 4;
        self.iconImageView.layer.masksToBounds = true;
        [self.backView addSubview:self.iconImageView];

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 100)];
        self.nameLabel.text = @"黄焖鸡米饭";
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.backView addSubview:self.nameLabel];

        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.text = @"x 1";
        self.numberLabel.font = [UIFont systemFontOfSize:16];
        self.numberLabel.textColor = [UIColor blackColor];
        [self.backView addSubview:self.numberLabel];

        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.text = @" $100";
        self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
        self.priceLabel.textColor = [UIColor redColor];
        [self.backView addSubview:self.priceLabel];


        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.equalTo(self.iconImageView).offset(5);
            make.right.mas_equalTo(-15);
        }];

        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.bottom.equalTo(self.iconImageView).offset(-5);
        }];

        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
        }];

        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setModel:(CDShopDetailsModel *)model {
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.coverUrl];
    self.nameLabel.text = model.name;
    self.numberLabel.text = [NSString stringWithFormat:@"x %d",model.payNumber];
    self.priceLabel.text = [NSString stringWithFormat:@" $%@",model.price];
}

@end
