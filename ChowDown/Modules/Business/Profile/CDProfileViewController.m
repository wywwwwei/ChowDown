//
//  CDProfileViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDProfileViewController.h"
#import "CDProfileFunctionCell.h"
#import "CDMerchantBaseViewController.h"
#import "CDLocationSelectViewController.h"
#import "CDProfileEditViewController.h"
#import "CDSettingsViewController.h"
#import "CDOrdersViewController.h"
#import "CDUser.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface CDProfileFunction : NSObject

@end

@interface CDProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *introductionLabel;

@property (nonatomic, strong) UICollectionView *functionCollectionView;
@property (nonatomic, strong) NSArray<CDProfileFunctionItem *> *functionItems;
@end

@implementation CDProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setupFunctionItems];
    [self setupInfoView];
    [self setupFunctionCollectionView];
    [self registerNotifications];
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onUserProfileChange:) name:CDUserProfileUpdateNotification object:nil];
}

- (void)onUserProfileChange:(NSNotification *)notification {
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:[CDUser currentUser].avatarUrl]];
    self.nicknameLabel.text = [CDUser currentUser].nickname;
    self.introductionLabel.text = [CDUser currentUser].introduction;
}

- (void)setupFunctionItems {
    if (self.functionItems) {
        return;
    }
    NSMutableArray *items = [NSMutableArray array];
    CDProfileFunctionItem *addressItem = [[CDProfileFunctionItem alloc] init];
    addressItem.iconName = @"address";
    addressItem.functionTitle = @"Address";
    WEAK_REF(self);
    addressItem.clickHandler = ^{
        STRONG_REF(self);
        CDLocationSelectViewController *vc = [[CDLocationSelectViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [items addObject:addressItem];
    
    CDProfileFunctionItem *orderItem = [[CDProfileFunctionItem alloc] init];
    orderItem.iconName = @"orders";
    orderItem.functionTitle = @"Orders";
    orderItem.clickHandler = ^{
        STRONG_REF(self);
        CDOrdersViewController *vc = [[CDOrdersViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [items addObject:orderItem];

    CDProfileFunctionItem *merchantItem = [[CDProfileFunctionItem alloc] init];
    merchantItem.iconName = @"merchant";
    merchantItem.functionTitle = @"Merchant";
    merchantItem.clickHandler = ^{
        STRONG_REF(self);
        CDMerchantBaseViewController *vc = [[CDMerchantBaseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [items addObject:merchantItem];

    CDProfileFunctionItem *editItem = [[CDProfileFunctionItem alloc] init];
    editItem.iconName = @"edit_profile";
    editItem.functionTitle = @"Edit Profile";
    editItem.clickHandler = ^{
        STRONG_REF(self);
        CDProfileEditViewController *vc = [[CDProfileEditViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [items addObject:editItem];

    CDProfileFunctionItem *settingsItem = [[CDProfileFunctionItem alloc] init];
    settingsItem.iconName = @"settings";
    settingsItem.functionTitle = @"Settings";
    settingsItem.clickHandler = ^{
        STRONG_REF(self);
        CDSettingsViewController *vc = [[CDSettingsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [items addObject:settingsItem];
    
    self.functionItems = items;
}

- (void)setupInfoView {
    if (self.infoView) {
        return;
    }
    self.infoView = [[UIView alloc] init];
    
    self.avatarView = [[UIImageView alloc] init];
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:[CDUser currentUser].avatarUrl]];
    self.avatarView.layer.cornerRadius = 64.0f;
    self.avatarView.layer.masksToBounds = YES;
    [self.infoView addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.height.mas_equalTo(128.f);
        make.left.offset(40);
    }];
    
    self.nicknameLabel = [[UILabel alloc] init];
    self.nicknameLabel.font = [UIFont systemFontOfSize:22 weight:UIFontWeightBold];
    self.nicknameLabel.textColor = [UIColor blackColor];
    self.nicknameLabel.text = [CDUser currentUser].nickname;
    [self.infoView addSubview:self.nicknameLabel];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).offset(30);
        make.bottom.mas_equalTo(self.avatarView.mas_centerY).offset(-10);
    }];
    
    self.introductionLabel = [[UILabel alloc] init];
    self.introductionLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    self.introductionLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    if ([CDUser currentUser].introduction.length <= 0) {
        self.introductionLabel.text = @"No introduction yet.";
    } else {
        self.introductionLabel.text = [CDUser currentUser].introduction;
    }
    [self.infoView addSubview:self.introductionLabel];
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nicknameLabel.mas_left);
        make.top.mas_equalTo(self.avatarView.mas_centerY).offset(10);
    }];

    [self.view addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.width.mas_equalTo(self.view);
    }];
}

- (void)setupFunctionCollectionView {
    if (self.functionCollectionView) {
        return;
    }
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(80, 100);
    self.functionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.functionCollectionView.dataSource = self;
    self.functionCollectionView.delegate = self;
    [self.functionCollectionView registerClass:CDProfileFunctionCell.class forCellWithReuseIdentifier:NSStringFromClass(CDProfileFunctionCell.class)];
    [self.view addSubview:self.functionCollectionView];
    [self.functionCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoView.mas_bottom).offset(40);
        make.left.offset(40);
        make.right.offset(-40);
        make.bottom.offset(0);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.functionItems.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDProfileFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CDProfileFunctionCell.class) forIndexPath:indexPath];
    cell.item = self.functionItems[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.functionItems.count) {
        CDProfileFunctionItem *item = self.functionItems[indexPath.row];
        if (item.clickHandler) {
            item.clickHandler();
        }
    }
}

@end
