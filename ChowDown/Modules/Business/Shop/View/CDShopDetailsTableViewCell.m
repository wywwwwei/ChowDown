//
//  CDShopDetailsTableViewCell.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/19.
//

#import "CDShopDetailsTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface CDShopDetailsTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UILabel *salesLabel;

@property(nonatomic, strong) UILabel *priceLabel;

@property(nonatomic, strong) UIButton *addButton;

@end

@implementation CDShopDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 80, 80)];
        self.iconImageView.backgroundColor = [UIColor lightGrayColor];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconImageView.layer.cornerRadius = 4;
        self.iconImageView.layer.masksToBounds = true;
        [self.contentView addSubview:self.iconImageView];

        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, 200, 100)];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.nameLabel];

        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.text = @"介绍介绍介绍介绍介绍介绍";
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:12];
        self.contentLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.contentLabel];

        self.salesLabel = [[UILabel alloc] init];
        self.salesLabel.text = @"月销：666";
        self.salesLabel.font = [UIFont systemFontOfSize:12];
        self.salesLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:self.salesLabel];

        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.text = @" $100";
        self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
        self.priceLabel.textColor = [UIColor redColor];
        [self addSubview:self.priceLabel];


        self.addButton = [[UIButton alloc] init];
        [self.addButton setTitle:@"+" forState:UIControlStateNormal];
        [self.addButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.addButton.layer.cornerRadius = 2;
        self.addButton.layer.borderColor = [[UIColor redColor] CGColor];
        self.addButton.layer.borderWidth = 1;
        self.addButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.addButton addTarget:self action:@selector(touchAddButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addButton];


        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.equalTo(self.iconImageView);
            make.right.mas_equalTo(-15);
        }];

        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(3);
        }];

        [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(3);
        }];

        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.bottom.equalTo(self.iconImageView.mas_bottom).offset(2);
        }];

        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.bottom.equalTo(self.iconImageView.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];

    }
    return self;
}

- (void)setModel:(CDShopDetailsModel *)model {
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.coverUrl];
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.introduce;
    self.salesLabel.text = [NSString stringWithFormat:@"Sales volume：%@",model.sales];
    self.priceLabel.text = [NSString stringWithFormat:@" $%@",model.price];
}

- (void)touchAddButtonEvent {
    self.model.payNumber ++;
    self.tuochAddBlock();
    [SVProgressHUD setMaximumDismissTimeInterval:0.5];
    [SVProgressHUD showSuccessWithStatus:@"Add successfully"];
}

@end
