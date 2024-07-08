//
//  CDMenuManagementTableViewCell.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDMenuManagementTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface CDMenuManagementTableViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *priceLabel;

@property(nonatomic, strong) UILabel *salesLabel;

@property(nonatomic, strong) UIButton *deleteButton;

@property(nonatomic, strong) UIButton *startButton;

@property(nonatomic, strong) UIButton *endButton;

@end

@implementation CDMenuManagementTableViewCell

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
        self.nameLabel.text = @"黄焖鸡米饭";
        self.nameLabel.textColor = [UIColor blackColor];
        self.nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:self.nameLabel];

        self.priceLabel = [[UILabel alloc] init];
        self.priceLabel.text = @"Price：100";
        self.priceLabel.numberOfLines = 0;
        self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
        self.priceLabel.textColor = [UIColor blackColor];
        [self addSubview:self.priceLabel];

        self.salesLabel = [[UILabel alloc] init];
        self.salesLabel.text = @"On sale：卖出";
        self.salesLabel.font = [UIFont boldSystemFontOfSize:16];
        self.salesLabel.textColor = [UIColor blackColor];
        [self addSubview:self.salesLabel];

        self.deleteButton = [[UIButton alloc] init];
        [self.deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [self.deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.deleteButton.layer.cornerRadius = 2;
        self.deleteButton.layer.borderColor = [[UIColor blackColor] CGColor];
        self.deleteButton.layer.borderWidth = 1;
        self.deleteButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.deleteButton addTarget:self action:@selector(touchdeleteButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.deleteButton];

        self.startButton = [[UIButton alloc] init];
        [self.startButton setTitle:@"On sale" forState:UIControlStateNormal];
        [self.startButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.startButton.layer.cornerRadius = 2;
        self.startButton.layer.borderColor = [[UIColor blackColor] CGColor];
        self.startButton.layer.borderWidth = 1;
        self.startButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.startButton addTarget:self action:@selector(touchstartButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.startButton];

        self.endButton = [[UIButton alloc] init];
        [self.endButton setTitle:@"Stop sale" forState:UIControlStateNormal];
        [self.endButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.endButton.layer.cornerRadius = 2;
        self.endButton.layer.borderColor = [[UIColor blackColor] CGColor];
        self.endButton.layer.borderWidth = 1;
        self.endButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.endButton addTarget:self action:@selector(touchendButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.endButton];

        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.equalTo(self.iconImageView).offset(2);
            make.right.mas_equalTo(-15);
        }];

        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.centerY.equalTo(self.iconImageView);
        }];

        [self.salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.right.mas_equalTo(-15);
            make.bottom.equalTo(self.iconImageView.mas_bottom).offset(-2);
        }];

        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.equalTo(self.iconImageView.mas_bottom).offset(20);
            make.height.mas_equalTo(40);
        }];

        [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.deleteButton.mas_right).offset(20);
            make.top.equalTo(self.deleteButton);
            make.height.mas_equalTo(40);
            make.width.equalTo(self.deleteButton);
        }];

        [self.endButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.startButton.mas_right).offset(20);
            make.top.equalTo(self.deleteButton);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(-20);
            make.width.equalTo(self.startButton);
        }];
        

    }
    return self;
}

- (void)setModel:(CDMenuManagementModel *)model {
    _model = model;
    self.iconImageView.image = [UIImage imageNamed:model.coverUrl];
    self.nameLabel.text = [NSString stringWithFormat:@"Name：%@",model.name];
    self.priceLabel.text = [NSString stringWithFormat:@"Price：%@",model.price];
    self.salesLabel.text = [NSString stringWithFormat:@"On sale：%@",model.typeString];
    self.priceLabel.text = [NSString stringWithFormat:@"Price： $%@",model.price];
}

- (void)touchdeleteButtonEvent {
    if(self.model.type == 0) {
        [SVProgressHUD setMaximumDismissTimeInterval:0.5];
        [SVProgressHUD showInfoWithStatus:@"It can only be removed when it is discontinued"];
        return;
    }
    self.tuochDeleteEventBlock();
}

- (void)touchstartButtonEvent {
    [SVProgressHUD setMaximumDismissTimeInterval:0.5];
    [SVProgressHUD showSuccessWithStatus:@"Successful launch"];
    self.model.type = 0;
    self.model = self.model;
}

- (void)touchendButtonEvent {
    [SVProgressHUD setMaximumDismissTimeInterval:0.5];
    [SVProgressHUD showSuccessWithStatus:@"Successful closure"];
    self.model.type = 1;
    self.model = self.model;
}

@end
