//
//  CDSubmitOrderHeaderView.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDSubmitOrderHeaderView.h"
#import <Masonry/Masonry.h>

@interface CDSubmitOrderHeaderView ()<UITextViewDelegate>

@property(nonatomic, strong) UIView *backView;

@property(nonatomic, strong) UILabel *placeholderLabel;

@property(nonatomic, strong) UILabel *timeLabel;


@end

@implementation CDSubmitOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.01];

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
    self.placeholderLabel.text = @"Please enter the shipping address";
    self.placeholderLabel.textColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.placeholderLabel.font = [UIFont systemFontOfSize:16];
    [self.addressTextView addSubview:self.placeholderLabel];

    UIView *linewView = [[UIView alloc] init];
    linewView.backgroundColor = [UIColor lightGrayColor];
    linewView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.backView addSubview:linewView];

    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.text = @"Distance 512KM expected to arrive at 15:22";
    self.timeLabel.font = [UIFont systemFontOfSize:16];
    self.timeLabel.textColor = [UIColor colorWithWhite:0 alpha:0.3];
    [self.backView addSubview:self.timeLabel];

    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(15);
        make.bottom.mas_equalTo(-20);
    }];

    [self.addressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-40);
    }];

    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
    }];

    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
        make.bottom.mas_equalTo(0);
    }];

    [linewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.timeLabel.mas_top);
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self.placeholderLabel setHidden:textView.text.length != 0];
}

@end
