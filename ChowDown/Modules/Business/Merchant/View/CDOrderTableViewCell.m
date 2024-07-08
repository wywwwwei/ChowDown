//
//  CDOrderTableViewCell.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDOrderTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface CDOrderTableViewCell ()

@property (nonatomic, strong) UILabel *orederLabel;

@property (nonatomic, strong) UILabel *statusLabel;

@property(nonatomic, strong) UIButton *handOutButton;

@property(nonatomic, strong) UIButton *completeButton;

@end

@implementation CDOrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.orederLabel = [[UILabel alloc] init];
        self.orederLabel.text = @"订单号：2314617236471";
        self.orederLabel.font = [UIFont systemFontOfSize:16];
        self.orederLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.orederLabel];

        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.text = @"订单状态：未派送";
        self.statusLabel.font = [UIFont systemFontOfSize:16];
        self.statusLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.statusLabel];

        self.handOutButton = [[UIButton alloc] init];
        [self.handOutButton setTitle:@"Hand out" forState:UIControlStateNormal];
        [self.handOutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.handOutButton.layer.cornerRadius = 2;
        self.handOutButton.layer.borderColor = [[UIColor blackColor] CGColor];
        self.handOutButton.layer.borderWidth = 1;
        self.handOutButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.handOutButton addTarget:self action:@selector(touchHandOutButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.handOutButton];

        self.completeButton = [[UIButton alloc] init];
        [self.completeButton setTitle:@"complete" forState:UIControlStateNormal];
        [self.completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.completeButton.layer.cornerRadius = 2;
        self.completeButton.layer.borderColor = [[UIColor blackColor] CGColor];
        self.completeButton.layer.borderWidth = 1;
        self.completeButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.completeButton addTarget:self action:@selector(touchCompleteButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.completeButton];

        [self.orederLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(15);
        }];

        [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.top.equalTo(self.orederLabel.mas_bottom).offset(15);
        }];

        [self.handOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.right.equalTo(self.mas_centerX).offset(-10);
            make.top.equalTo(self.statusLabel.mas_bottom).offset(20);
            make.height.mas_equalTo(40);
        }];

        [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-20);
            make.left.equalTo(self.mas_centerX).offset(10);
            make.top.equalTo(self.statusLabel.mas_bottom).offset(20);
            make.height.mas_equalTo(40);
        }];

    }
    return self;
}

- (void)setModel:(CDOrderModel *)model {
    _model = model;
    self.orederLabel.text = [NSString stringWithFormat:@"Order number：%@",model.orderCode];
    self.statusLabel.text = [NSString stringWithFormat:@"Order status：%@",model.orderTypeString];
    [self.handOutButton setTitle:model.psString forState:UIControlStateNormal];
    [self.completeButton setTitle:model.wcString forState:UIControlStateNormal];
}

- (void)touchHandOutButtonEvent {
    if (self.model.orderType == 0 ) {
        [SVProgressHUD setMaximumDismissTimeInterval:0.5];
        [SVProgressHUD showInfoWithStatus:@"Delivery completed"];
        self.model.orderType = 1;
        self.model = self.model;
        return;
    }
    [SVProgressHUD showInfoWithStatus:@"It's already been delivered"];
}

- (void)touchCompleteButtonEvent {
    if (self.model.orderType == 3 ) {
        [SVProgressHUD showInfoWithStatus:@"completed"];
        return;
    }
    self.model.orderType = 3;
    self.model = self.model;
    [SVProgressHUD setMaximumDismissTimeInterval:0.5];
    [SVProgressHUD showInfoWithStatus:@"completed"];
}

@end
