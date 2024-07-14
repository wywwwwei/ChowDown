//
//  CDRegisterViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/8.
//

#import "CDRegisterViewController.h"
#import "CDNavigationBar.h"
#import "CDLoadingView.h"
#import "CDLocalStorage.h"
#import "CDToast.h"
#import <Masonry/Masonry.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import <BlocksKit/UIGestureRecognizer+BlocksKit.h>

@interface CDRegisterViewController ()

@property (nonatomic, strong) CDNavigationBar *navigationView;

@property (nonatomic, strong) UILabel *registerHintLabel;

@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *confirmPasswordField;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UILabel *loginLabel;

@end

@implementation CDRegisterViewController

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
    [self setupRegisterHintLabel];
    [self setupEmailField];
    [self setupPasswordField];
    [self setupConfirmPasswordField];
    [self setupRegisterButton];
    [self setupLoginLabel];
}

- (void)setupNavigationView {
    if (self.navigationView) {
        return;
    }
    self.navigationView = [[CDNavigationBar alloc] initWithTitle:nil];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.top.left.mas_equalTo(0);
    }];
}

- (void)setupRegisterHintLabel {
    if (self.registerHintLabel) {
        return;
    }
    self.registerHintLabel = [[UILabel alloc] init];
    self.registerHintLabel.font = [UIFont systemFontOfSize:36 weight:UIFontWeightSemibold];
    self.registerHintLabel.text = @"Register";
    [self.view addSubview:self.registerHintLabel];
    
    [self.registerHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_offset(140);
    }];
}

- (void)setupEmailField {
    if (self.emailField) {
        return;
    }
    self.emailField = [[UITextField alloc] init];
    self.emailField.placeholder = @"Enter email id";
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.emailField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:self.emailField];
    
    [self.emailField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.top.mas_equalTo(self.registerHintLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(48);
    }];
}

- (void)setupPasswordField {
    if (self.passwordField) {
        return;
    }
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.placeholder = @"Enter password";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.secureTextEntry = YES;
    [self.view addSubview:self.passwordField];
    
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.top.mas_equalTo(self.emailField.mas_bottom).offset(20);
        make.height.mas_equalTo(48);
    }];
}

- (void)setupConfirmPasswordField {
    if (self.confirmPasswordField) {
        return;
    }
    self.confirmPasswordField = [[UITextField alloc] init];
    self.confirmPasswordField.placeholder = @"Confirm password";
    self.confirmPasswordField.borderStyle = UITextBorderStyleRoundedRect;
    self.confirmPasswordField.secureTextEntry = YES;
    [self.view addSubview:self.confirmPasswordField];
    
    [self.confirmPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.top.mas_equalTo(self.passwordField.mas_bottom).offset(20);
        make.height.mas_equalTo(48);
    }];
}

- (void)setupRegisterButton {
    if (self.registerButton) {
        return;
    }
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registerButton setTitle:@"Register" forState:UIControlStateNormal];
    self.registerButton.backgroundColor = THEME_COLOR;
    self.registerButton.layer.cornerRadius = 8.0;
    WEAK_REF(self);
    [self.registerButton bk_addEventHandler:^(id sender) {
        STRONG_REF(self);
        if (![self.passwordField.text isEqualToString:self.confirmPasswordField.text]) {
            [CDToast showToastTitle:@"The two passwords are inconsistent" duration:3];
            return;
        }
        NSString *errorMsg = [[CDLocalStorage sharedInstance] registerUserEmail:self.emailField.text password:self.passwordField.text];
        [CDLoadingView showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [CDLoadingView dismissLoading];
            if (errorMsg.length > 0) {
                [CDToast showToastTitle:errorMsg duration:3];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        });
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerButton];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.top.mas_equalTo(self.confirmPasswordField.mas_bottom).offset(40);
        make.height.mas_equalTo(48);
    }];
}

- (void)setupLoginLabel {
    if (self.loginLabel) {
        return;
    }
    self.loginLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    NSString *hasRegisterText = @"Already have an account ?";
    NSDictionary *hasRegisterAttributes = @{
        NSFontAttributeName: [UIFont systemFontOfSize:13 weight:UIFontWeightRegular],
        NSForegroundColorAttributeName: HEXCOLOR(0x636363),
    };
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:hasRegisterText attributes:hasRegisterAttributes]];
    
    NSString *loginText = @" Login Now";
    NSDictionary *loginAttributes = @{
        NSFontAttributeName: [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold],
        NSForegroundColorAttributeName: HEXCOLOR(0x0C1F22),
    };
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:loginText attributes:loginAttributes]];
    self.loginLabel.attributedText = attributedText;
    
    [self.view addSubview:self.loginLabel];
    [self.loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.registerButton.mas_bottom).offset(30);
    }];
    
    WEAK_REF(self);
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        STRONG_REF(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.loginLabel.userInteractionEnabled = YES;
    [self.loginLabel addGestureRecognizer:gesture];
}

@end
