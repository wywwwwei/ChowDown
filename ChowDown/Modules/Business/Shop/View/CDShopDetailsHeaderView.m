//
//  CDShopDetailsHeaderView.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/19.
//

#import "CDShopDetailsHeaderView.h"
#import <Masonry/Masonry.h>

@interface CDShopDetailsHeaderView ()

@property(nonatomic, strong) UIImageView *coverImageView;

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UILabel *buttomContentLabel;

@end

@implementation CDShopDetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.coverImageView = [[UIImageView alloc] init];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.layer.cornerRadius = 4;
    self.coverImageView.layer.masksToBounds = true;
    self.coverImageView.backgroundColor = [UIColor lightGrayColor];
    self.coverImageView.image = [UIImage imageNamed:@"10.jpg"];
    [self addSubview:self.coverImageView];

    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"McDonald‘s";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.textColor = [UIColor blackColor];
    [self addSubview:self.titleLabel];

    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.text = @"McDonald's is the world's largest multinational restaurant chain, with revenue of 23.18 billion US dollars in 2022. Founded in 1955 in Chicago, the United States, McDonald's has about 30,000 branches in the world. It mainly sells hamburgers, fries, fried chicken, soft drinks, ice products, salads, fruits and other fast food.";
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont boldSystemFontOfSize:14];
    self.contentLabel.textColor = [UIColor blackColor];
    [self addSubview:self.contentLabel];

    self.buttomContentLabel = [[UILabel alloc] init];
    self.buttomContentLabel.text = @"Delivery fee of 1.5KM from you is 6 yuan";
    self.buttomContentLabel.font = [UIFont boldSystemFontOfSize:14];
    self.buttomContentLabel.textColor = [UIColor grayColor];
    self.buttomContentLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.buttomContentLabel];

    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(10);
        make.top.equalTo(self.coverImageView);
        make.right.mas_equalTo(-15);
    }];

    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(10);
        make.bottom.equalTo(self.coverImageView);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
    }];

    [self.buttomContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.equalTo(self.coverImageView.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
        make.bottom.mas_offset(0);
    }];
}

@end
