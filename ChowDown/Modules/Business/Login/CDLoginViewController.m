//
//  CDLoginViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDLoginViewController.h"
#import <Masonry/Masonry.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import <BlocksKit/UIGestureRecognizer+BlocksKit.h>
#import "CDMainViewController.h"
#import "CDRegisterViewController.h"
#import "CDLocalStorage.h"
#import "CDToast.h"
#import "CDLoadingView.h"
#import "CDUser.h"
#import <WXApi.h>

@interface CDLoginViewController ()

@property (nonatomic, strong) UILabel *appTitleLabel;

@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UIButton *loginButton;

@property (nonatomic, strong) UIView *splitLine;
@property (nonatomic, strong) UILabel *thirdHintLabel;

@property (nonatomic, strong) UIButton *wechatLoginButton;

@property (nonatomic, strong) UILabel *createAccountLabel;

@end

@implementation CDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAppTitleLabel];
    [self setupEmailField];
    [self setupPasswordField];
    [self setupLoginButton];
    [self setupSplitLine];
    [self setupThirdHintLabel];
    [self setupWechatLoginButton];
    [self setupCreateAccountLabel];
    
}

- (void)setupAppTitleLabel {
    if (self.appTitleLabel) {
        return;
    }
    self.appTitleLabel = [[UILabel alloc] init];
    self.appTitleLabel.font = [UIFont systemFontOfSize:60 weight:UIFontWeightBold];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:@"Chow Down"];
    // setting "Chow" black color
    [attributedText addAttribute:NSForegroundColorAttributeName
                           value:[UIColor blackColor]
                           range:NSMakeRange(0, 4)];
    // setting "Down" yellow color
    [attributedText addAttribute:NSForegroundColorAttributeName
                           value:THEME_COLOR
                           range:NSMakeRange(5, 4)];
    self.appTitleLabel.attributedText = attributedText;
    [self.view addSubview:self.appTitleLabel];
    
    [self.appTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_offset(170);
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
        make.top.mas_equalTo(self.appTitleLabel.mas_bottom).offset(50);
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
        make.top.mas_equalTo(self.emailField.mas_bottom).offset(10);
        make.height.mas_equalTo(48);
    }];
}

- (void)setupLoginButton {
    if (self.loginButton) {
        return;
    }
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    [self.loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    self.loginButton.backgroundColor = THEME_COLOR;
    self.loginButton.layer.cornerRadius = 8.0;
    WEAK_REF(self);
    [self.loginButton bk_addEventHandler:^(id sender) {
        STRONG_REF(self);
        [CDLoadingView showLoading];
        NSString *errorMsg = [[CDLocalStorage sharedInstance] loginUserEmail:self.emailField.text password:self.passwordField.text];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [CDLoadingView dismissLoading];
            if (errorMsg.length > 0) {
                [CDToast showToastTitle:errorMsg duration:3];
            } else {
                CDMainViewController *mainVC = [[CDMainViewController alloc] init];
                self.navigationController.viewControllers = @[mainVC];
            }
        });
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.top.mas_equalTo(self.passwordField.mas_bottom).offset(40);
        make.height.mas_equalTo(48);
    }];
}

- (void)setupSplitLine {
    if (self.splitLine) {
        return;
    }
    self.splitLine = [[UIView alloc] init];
    self.splitLine.backgroundColor = HEXCOLOR(0xA39797);
    [self.view addSubview:self.splitLine];
    [self.splitLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(45);
        make.right.offset(-45);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(40);
    }];
}

- (void)setupThirdHintLabel {
    if (self.thirdHintLabel) {
        return;
    }
    self.thirdHintLabel = [[UILabel alloc] init];
    self.thirdHintLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.thirdHintLabel.textColor = HEXCOLOR(0x757171);
    self.thirdHintLabel.text = @"Or sign up with";
    self.thirdHintLabel.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.thirdHintLabel];
    
    [self.thirdHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.splitLine);
    }];
}

- (void)setupWechatLoginButton {
    if (self.wechatLoginButton) {
        return;
    }
    self.wechatLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wechatLoginButton.backgroundColor = [UIColor clearColor];
    [self.wechatLoginButton setImage:[UIImage imageNamed:@"wechat"] forState:UIControlStateNormal];
    WEAK_REF(self);
    [self.wechatLoginButton bk_addEventHandler:^(id sender) {
        STRONG_REF(self);
        [self sendAuthRequest];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.wechatLoginButton];
    [self.wechatLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.thirdHintLabel.mas_bottom).offset(30);
    }];
}

-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo"; // 只能填 snsapi_userinfo
    req.state = @"123";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

- (void)setupCreateAccountLabel {
    if (self.createAccountLabel) {
        return;
    }
    self.createAccountLabel = [[UILabel alloc] init];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    NSString *notRegisterText = @"Not register yet ?";
    NSDictionary *notRegisterAttributes = @{
        NSFontAttributeName: [UIFont systemFontOfSize:13 weight:UIFontWeightRegular],
        NSForegroundColorAttributeName: HEXCOLOR(0x636363),
    };
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:notRegisterText attributes:notRegisterAttributes]];
    
    NSString *createAccountText = @" Create Account";
    NSDictionary *createAccountAttributes = @{
        NSFontAttributeName: [UIFont systemFontOfSize:13 weight:UIFontWeightSemibold],
        NSForegroundColorAttributeName: HEXCOLOR(0x0C1F22),
    };
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:createAccountText attributes:createAccountAttributes]];
    self.createAccountLabel.attributedText = attributedText;
    
    [self.view addSubview:self.createAccountLabel];
    [self.createAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.wechatLoginButton.mas_bottom).offset(30);
    }];
    
    WEAK_REF(self);
    UITapGestureRecognizer *gesture = [UITapGestureRecognizer bk_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        STRONG_REF(self);
        CDRegisterViewController *registerVC = [[CDRegisterViewController alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
    }];
    self.createAccountLabel.userInteractionEnabled = YES;
    [self.createAccountLabel addGestureRecognizer:gesture];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    if (touch.view != self.passwordField && self.passwordField.isEditing) {
        [self.passwordField resignFirstResponder];
    } else if (touch.view != self.emailField && self.emailField.isEditing) {
        [self.emailField resignFirstResponder];
    }
    [super touchesBegan:touches withEvent:event];
}
@end
