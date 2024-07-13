//
//  CDProfileEditViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import "CDProfileEditViewController.h"
#import "CDNavigationBar.h"
#import "CDUser.h"
#import "CDToast.h"
#import <Masonry/Masonry.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface CDProfileEditViewController () <UITextViewDelegate>

@property (nonatomic, strong) CDNavigationBar *navigationView;

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIPickerView *avatarPickerView;

@property (nonatomic, strong) UITextView *nicknameTextView;
@property (nonatomic, strong) UITextView *introductionTextView;

@end

@implementation CDProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)setupViews {
    [self setupNavigationView];
    [self setupAvatarView];
    [self setupNicknameTextView];
    [self setupIntroductionTextView];
}

- (void)setupAvatarView {
    if (self.avatarView) {
        return;
    }
    self.avatarView = [[UIImageView alloc] init];
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:[CDUser currentUser].avatarUrl]];
    self.avatarView.layer.cornerRadius = 64.0f;
    self.avatarView.layer.masksToBounds = YES;
    [self.view addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(80);
        make.centerX.mas_equalTo(self.view);
        make.width.height.mas_equalTo(128.f);
    }];
}

- (void)setupNicknameTextView {
    if (self.nicknameTextView) {
        return;
    }
    self.nicknameTextView = [[UITextView alloc] init];
    self.nicknameTextView.font = [UIFont systemFontOfSize:22 weight:UIFontWeightRegular];
    self.nicknameTextView.textColor = [UIColor lightGrayColor];
    self.nicknameTextView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    self.nicknameTextView.layer.borderWidth = 1.0;
    self.nicknameTextView.layer.cornerRadius = 4.0;
    self.nicknameTextView.text = [CDUser currentUser].nickname;
    self.nicknameTextView.textContainer.maximumNumberOfLines = 1;
    self.nicknameTextView.delegate = self;
    [self.view addSubview:self.nicknameTextView];
    [self.nicknameTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(self.avatarView.mas_bottom).offset(30);
        make.height.mas_equalTo(40);
    }];
}

- (void)setupIntroductionTextView {
    if (self.introductionTextView) {
        return;
    }
    self.introductionTextView = [[UITextView alloc] init];
    self.introductionTextView.font = [UIFont systemFontOfSize:22 weight:UIFontWeightRegular];
    self.introductionTextView.textColor = [UIColor lightGrayColor];
    self.introductionTextView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    self.introductionTextView.layer.borderWidth = 1.0;
    self.introductionTextView.layer.cornerRadius = 4.0;
    self.introductionTextView.text = [CDUser currentUser].introduction;
    self.introductionTextView.delegate = self;

    [self.view addSubview:self.introductionTextView];
    [self.introductionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(self.nicknameTextView.mas_bottom).offset(30);
        make.height.mas_equalTo(150);
    }];
}

- (void)setupNavigationView {
    if (self.navigationView) {
        return;
    }
    self.navigationView = [[CDNavigationBar alloc] initWithTitle:@"Edit"];
    [self.view addSubview:self.navigationView];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    saveButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    saveButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
    WEAK_REF(self);
    [saveButton bk_addEventHandler:^(id sender) {
        STRONG_REF(self);
        [CDToast showToastTitle:@"Save successfully" duration:3];
        CDUser *user = [CDUser currentUser];
        user.nickname = self.nicknameTextView.text;
        user.introduction = self.introductionTextView.text;
        [CDUser updateUser:user];
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(self.navigationView.backButton);
        make.right.mas_offset(-20);
    }];

    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.top.left.mas_equalTo(0);
    }];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.textColor = [UIColor blackColor];
}

@end
