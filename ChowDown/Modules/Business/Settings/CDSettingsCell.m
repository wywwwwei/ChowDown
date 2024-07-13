//
//  CDSettingsCell.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import "CDSettingsCell.h"
#import <BlocksKit/UIControl+BlocksKit.h>

@interface CDSettingsCell ()

@property (nonatomic, strong) UISwitch *switchView;

@end

@implementation CDSettingsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setModel:(CDSettingsModel *)model {
    _model = model;
    self.textLabel.text = model.title;
    self.switchView.on = model.isOn;
    [self setNeedsLayout];
}

- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    [self setupSwitchView];
    self.accessoryView = self.switchView;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setupSwitchView {
    if (self.switchView) {
        return;
    }
    self.switchView = [[UISwitch alloc] init];
    WEAK_REF(self);
    [self.switchView bk_addEventHandler:^(UISwitch *sender) {
        STRONG_REF(self);
        self.model.isOn = sender.isOn;
    } forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:self.switchView];
}

@end
