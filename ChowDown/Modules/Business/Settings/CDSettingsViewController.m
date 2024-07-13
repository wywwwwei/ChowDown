//
//  CDSettingsViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import "CDSettingsViewController.h"
#import "CDNavigationBar.h"
#import "CDUser.h"
#import "CDLoginViewController.h"
#import "CDSettingsCell.h"
#import <Masonry/Masonry.h>
#import <BlocksKit/UIControl+BlocksKit.h>
#import <BlocksKit/NSObject+BKBlockObservation.h>

@interface CDSettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CDNavigationBar *navigationView;
@property (nonatomic, strong) UITableView *settingsView;
@property (nonatomic, strong) UIButton *logoutButton;

@property (nonatomic, strong) NSArray<CDSettingsModel *> *settingsModels;

@end

@implementation CDSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupSettingsModels];
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

- (void)setupSettingsModels {
    NSMutableArray *settingsModels = [NSMutableArray array];

    CDSettingsModel *notificationModel = [[CDSettingsModel alloc] init];
    notificationModel.title = @"In-app notification";
    [settingsModels addObject:notificationModel];
    
    CDSettingsModel *soundModel = [[CDSettingsModel alloc] init];
    soundModel.title = @"Notification sound";
    [settingsModels addObject:soundModel];
    
    self.settingsModels = settingsModels;
}

- (void)setupViews {
    [self setupNavigationView];
    [self setupSettingsView];
    [self setupLogoutButton];
}

- (void)setupSettingsView {
    if (self.settingsView) {
        return;
    }
    self.settingsView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.settingsView.dataSource = self;
    self.settingsView.delegate = self;
    self.settingsView.backgroundColor = [UIColor clearColor];
    self.settingsView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.settingsView.rowHeight = 50;
    [self.view addSubview:self.settingsView];
    [self.settingsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.navigationView.mas_bottom);
    }];
    WEAK_REF(self);
    [self.settingsView bk_addObserverForKeyPath:@"contentSize" task:^(id target) {
        STRONG_REF(self);
        [self.settingsView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.settingsView.contentSize.height);
        }];
    }];
}

- (void)setupNavigationView {
    if (self.navigationView) {
        return;
    }
    self.navigationView = [[CDNavigationBar alloc] initWithTitle:@"Settings"];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.top.left.mas_equalTo(0);
    }];
}

- (void)setupLogoutButton {
    if (self.logoutButton) {
        return;
    }
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logoutButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
    [self.logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    self.logoutButton.backgroundColor = THEME_COLOR;
    self.logoutButton.layer.cornerRadius = 8.0;
    WEAK_REF(self);
    [self.logoutButton bk_addEventHandler:^(id sender) {
        STRONG_REF(self);
        [CDUser logout];
        CDLoginViewController *vc = [[CDLoginViewController alloc] init];
        self.navigationController.viewControllers = @[vc];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutButton];
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.right.offset(-25);
        make.height.mas_equalTo(48);
        make.top.mas_equalTo(self.settingsView.mas_bottom).offset(40);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingsModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CDSettingsCell.class)];
    if (!cell) {
        cell = [[CDSettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(CDSettingsCell.class)];
    }
    CDSettingsModel *item = self.settingsModels[indexPath.row];
    cell.model = item;
    return cell;
}

@end
