//
//  CDShoppingCartViewCell.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/19.
//

#import "CDShoppingCartViewCell.h"
#import <Masonry/Masonry.h>

@interface CDShoppingCartViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) UILabel *numberLabel;

@property(nonatomic, strong) UIButton *decreaseButton;

@property(nonatomic, strong) UIButton *addButton;

@end

@implementation CDShoppingCartViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 100)];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        self.nameLabel.text = @"黄焖鸡米饭";
        [self.contentView addSubview:self.nameLabel];

        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.textAlignment = NSTextAlignmentRight;
        self.priceLabel.text = @" $100";
        self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];

        self.numberLabel = [[UILabel alloc] init];
        self.numberLabel.text = @"0";
        self.numberLabel.font = [UIFont systemFontOfSize:16];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.numberLabel];

        self.addButton = [[UIButton alloc] init];
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.addButton.layer.cornerRadius = 2;
        self.addButton.layer.borderColor = [[UIColor redColor] CGColor];
        self.addButton.layer.borderWidth = 1;
        self.addButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.addButton addTarget:self action:@selector(touchAddEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.addButton];

        self.decreaseButton = [[UIButton alloc] init];
        [self.decreaseButton setTitle:@"-" forState:UIControlStateNormal];
        [self.decreaseButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.decreaseButton.layer.cornerRadius = 2;
        self.decreaseButton.layer.borderColor = [[UIColor redColor] CGColor];
        self.decreaseButton.layer.borderWidth = 1;
        self.decreaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.decreaseButton addTarget:self action:@selector(touchDecreaseButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.decreaseButton];

        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(0);
            make.right.equalTo(self.priceLabel.mas_left).offset(-5);
        }];

        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];

        [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.addButton.mas_left);
            make.centerY.mas_equalTo(0);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(40);
        }];

        [self.decreaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.numberLabel.mas_left);
            make.centerY.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];

        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.decreaseButton.mas_left).offset(-15);
            make.centerY.mas_equalTo(0);
            make.width.mas_greaterThanOrEqualTo(80);
        }];

    }
    return self;
}


- (void)setModel:(CDShopDetailsModel *)model {
    _model = model;
    self.nameLabel.text = model.name;
    self.priceLabel.text = [NSString stringWithFormat:@" $%d",([model.price intValue] * model.payNumber)];
    self.numberLabel.text = [NSString stringWithFormat:@"%d",model.payNumber];
}

- (void)touchAddEvent {
    self.model.payNumber++;
    self.tuochAddOrDecreaseBlock();
}

- (void)touchDecreaseButtonEvent {
    self.model.payNumber--;
    self.tuochAddOrDecreaseBlock();
}

@end
