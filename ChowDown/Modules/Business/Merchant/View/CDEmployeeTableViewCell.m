//
//  CDEmployeeTableViewCell.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/14.
//

#import "CDEmployeeTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import "CDToast.h"

@interface CDEmployeeTableViewCell ()

@property (nonatomic, strong) UILabel *employeeIdLabel;

@property (nonatomic, strong) UILabel *employeeNameLabel;

@property (nonatomic, strong) UILabel *employeeStatusLabel;

@property (nonatomic, strong) UIButton *shiftButton;

@property (nonatomic, strong) UIButton *terminateButton;

@end

@implementation CDEmployeeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self setupEmployeeIdLabel];
    [self setupEmployeeNameLabel];
    [self setupEmployeeStatusLabel];
    [self setupShiftButton];
    [self setupTerminateButton];
}

- (void)setupEmployeeIdLabel {
    if (self.employeeIdLabel) {
        return;
    }
    self.employeeIdLabel = [[UILabel alloc] init];
    self.employeeIdLabel.font = [UIFont systemFontOfSize:16];
    self.employeeIdLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.employeeIdLabel];
    [self.employeeIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(15);
    }];
}

- (void)setupEmployeeNameLabel {
    if (self.employeeNameLabel) {
        return;
    }
    self.employeeNameLabel = [[UILabel alloc] init];
    self.employeeNameLabel.font = [UIFont systemFontOfSize:16];
    self.employeeNameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.employeeNameLabel];
    [self.employeeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.equalTo(self.employeeIdLabel.mas_bottom).offset(15);
    }];
}

- (void)setupEmployeeStatusLabel {
    if (self.employeeStatusLabel) {
        return;
    }
    self.employeeStatusLabel = [[UILabel alloc] init];
    self.employeeStatusLabel.font = [UIFont systemFontOfSize:16];
    self.employeeStatusLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.employeeStatusLabel];
    [self.employeeStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.equalTo(self.employeeNameLabel.mas_bottom).offset(15);
    }];
}

- (void)setupShiftButton {
    if (self.shiftButton) {
        return;
    }
    self.shiftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shiftButton setTitle:@"On Shift" forState:UIControlStateNormal];
    [self.shiftButton setTitle:@"On Break" forState:UIControlStateSelected];
    [self.shiftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.shiftButton.layer.cornerRadius = 2;
    self.shiftButton.layer.borderColor = [[UIColor blackColor] CGColor];
    self.shiftButton.layer.borderWidth = 1;
    self.shiftButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    WEAK_REF(self);
    [self.shiftButton bk_addEventHandler:^(UIButton *sender) {
        STRONG_REF(self);
        sender.selected = !sender.selected;
        self.model.status = sender.selected ? CDEmployeeStatusOnShift : CDEmployeeStatusOnBreak;
        self.model = self.model;
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.shiftButton];
    [self.shiftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.equalTo(self.mas_centerX).offset(-10);
        make.top.equalTo(self.employeeStatusLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
}

- (void)setupTerminateButton {
    if (self.terminateButton) {
        return;
    }
    self.terminateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.terminateButton setTitle:@"Terminate" forState:UIControlStateNormal];
    [self.terminateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.terminateButton.layer.cornerRadius = 2;
    self.terminateButton.layer.borderColor = [[UIColor blackColor] CGColor];
    self.terminateButton.layer.borderWidth = 1;
    self.terminateButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.terminateButton bk_addEventHandler:^(id sender) {
        self.model.status = CDEmployeeStatusTerminated;
        self.model = self.model;
    } forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.terminateButton];
    [self.terminateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.left.equalTo(self.mas_centerX).offset(10);
        make.top.equalTo(self.employeeStatusLabel.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
}

- (void)setModel:(CDEmployeeModel *)model {
    _model = model;
    self.employeeIdLabel.text = [NSString stringWithFormat:@"Employee ID: %@", model.employeeId];
    self.employeeNameLabel.text = [NSString stringWithFormat:@"Employee Name: %@", model.name];
    self.employeeStatusLabel.text = [NSString stringWithFormat:@"Employee Status: %@", [self descriptionStrForStatus:model.status]];
    if (model.status == CDEmployeeStatusTerminated) {
        self.shiftButton.enabled = NO;
        self.shiftButton.backgroundColor = [UIColor grayColor];
        self.terminateButton.enabled = NO;
        self.terminateButton.backgroundColor = [UIColor grayColor];
    } else {
        self.shiftButton.enabled = YES;
        self.shiftButton.backgroundColor = [UIColor clearColor];
        self.terminateButton.enabled = YES;
        self.terminateButton.backgroundColor = [UIColor clearColor];
    }
    [self setNeedsLayout];
}

- (NSString *)descriptionStrForStatus:(CDEmployeeStatus)status {
    if (status == CDEmployeeStatusOnShift) {
        return @"On Shift";
    } else if (status == CDEmployeeStatusOnBreak) {
        return @"On Break";
    } else {
        return @"Terminated";
    }
}

@end
