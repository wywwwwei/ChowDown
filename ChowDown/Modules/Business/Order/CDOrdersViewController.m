//
//  CDOrdersViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import "CDOrdersViewController.h"
#import "CDNavigationBar.h"
#import <Masonry/Masonry.h>

@interface CDOrdersViewController ()

@property (nonatomic, strong) CDNavigationBar *navigationView;
@property (nonatomic, strong) UICollectionView *orderView;

@end

@implementation CDOrdersViewController

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
    [self setupOrderView];
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

- (void)setupOrderView {
    if (self.orderView) {
        return;
    }
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.view.width - 40, 80);
    layout.minimumLineSpacing = 10.f;
    self.orderView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.orderView.showsVerticalScrollIndicator = NO;
    self.orderView.showsHorizontalScrollIndicator = NO;
    self.orderView.backgroundColor = [UIColor clearColor];
    self.orderView.dataSource = self;
    self.orderView.delegate = self;
//    [self.orderView registerClass:CDHomepageShopCell.class forCellWithReuseIdentifier:NSStringFromClass(CDHomepageShopCell.class)];
    [self.view addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(20);
        make.left.offset(20);
        make.right.offset(-20);
        make.bottom.offset(0);
    }];
}

@end
