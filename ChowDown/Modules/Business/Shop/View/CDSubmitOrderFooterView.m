//
//  CDSubmitOrderFooterView.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDSubmitOrderFooterView.h"
#import <Masonry/Masonry.h>

@interface CDSubmitOrderFooterView ()<UITextViewDelegate>

@property(nonatomic, strong) UIView *backView;

@property(nonatomic, strong) UITextView *addressTextView;

@property(nonatomic, strong) UILabel *placeholderLabel;

@property(nonatomic, strong) UIView *buttomView;

@property(nonatomic, strong) UILabel *payTipLabel;

@end

@implementation CDSubmitOrderFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.01];

    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor blackColor];
    tipLabel.font = [UIFont systemFontOfSize:16];
    tipLabel.text = @"remark";
    [self addSubview:tipLabel];

    self.backView = [[UIView alloc] init];
    self.backView.backgroundColor=  [UIColor whiteColor];
    self.backView.layer.cornerRadius = 6;
    self.backView.layer.masksToBounds = true;
    [self addSubview:self.backView];

    self.addressTextView = [[UITextView alloc] init];
    self.addressTextView.textColor = [UIColor blackColor];
    self.addressTextView.font = [UIFont systemFontOfSize:16];
    self.addressTextView.delegate = self;
    [self.backView addSubview:self.addressTextView];

    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.text = @"Please enter remarks";
    self.placeholderLabel.textColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.placeholderLabel.font = [UIFont systemFontOfSize:16];
    [self.addressTextView addSubview:self.placeholderLabel];

    self.buttomView = [[UIView alloc] init];
    self.buttomView.backgroundColor=  [UIColor whiteColor];
    self.buttomView.layer.cornerRadius = 6;
    self.buttomView.layer.masksToBounds = true;
    [self addSubview:self.buttomView];

    self.payTipLabel = [[UILabel alloc] init];
    self.payTipLabel.text = @"Wechat Pay";
    self.payTipLabel.font = [UIFont systemFontOfSize:16];
    self.payTipLabel.textColor = [UIColor blackColor];
    [self.buttomView addSubview:self.payTipLabel];

    self.selectButton = [[UIButton alloc] init];
    self.selectButton.layer.cornerRadius = 10;
    self.selectButton.layer.masksToBounds = true;
    self.selectButton.layer.borderColor = [[UIColor greenColor] CGColor];
    self.selectButton.layer.borderWidth = 2;
    [self.selectButton addTarget:self action:@selector(touchSelectButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.buttomView addSubview:self.selectButton];

    [self.buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-20);
    }];

    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];

    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.equalTo(self.payTipLabel);
        make.width.height.mas_equalTo(20);
    }];

    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(40);
        make.bottom.mas_equalTo(-90);
    }];

    [self.addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];

    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];

    [self.payTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];

}

- (void)textViewDidChange:(UITextView *)textView {
    [self.placeholderLabel setHidden:textView.text.length != 0];
}

- (void)touchSelectButtonEvent {
    [self.selectButton setSelected:!self.selectButton.isSelected];
    if (self.selectButton.isSelected) {
        self.selectButton.backgroundColor = [UIColor greenColor];
    } else {
        self.selectButton.backgroundColor = [UIColor clearColor];
    }
}

@end
