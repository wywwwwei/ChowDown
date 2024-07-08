//
//  CDSubmitOrderPayView.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDSubmitOrderPayView.h"
#import <Masonry/Masonry.h>

@interface CDSubmitOrderPayView ()

@property(nonatomic, strong) UILabel *priceLabel;

@property(nonatomic, strong) UIButton *payButtton;

@end

@implementation CDSubmitOrderPayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = @" $0";
    self.priceLabel.numberOfLines = 0;
    self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
    self.priceLabel.textColor = [UIColor redColor];
    [self addSubview:self.priceLabel];

    self.payButtton = [[UIButton alloc] init];
    [self.payButtton setTitle:@"payment" forState:UIControlStateNormal];
    [self.payButtton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.payButtton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.payButtton addTarget:self action:@selector(touchPayButttonEvent) forControlEvents:UIControlEventTouchUpInside];
    self.payButtton.backgroundColor = THEME_COLOR;
    [self addSubview:self.payButtton];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];

    [self.payButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(180);
    }];
}

- (void)touchPayButttonEvent {
    self.tuochPayBlock();
}

- (void)setDataArrays:(NSMutableArray<CDShopDetailsModel *> *)dataArrays {
    _dataArrays = dataArrays;
    [self calculatePrice];
}

// 计算价格 更新UI
- (void)calculatePrice {
    int allPrice = 0;
    for (CDShopDetailsModel *model in self.dataArrays) {
        allPrice += (model.payNumber * [model.price intValue]);
    }
    self.priceLabel.text = [NSString stringWithFormat:@" $%d",allPrice];
}

@end
