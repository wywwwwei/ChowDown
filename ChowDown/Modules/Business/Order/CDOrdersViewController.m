//
//  CDOrdersViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import "CDOrdersViewController.h"
#import "CDNavigationBar.h"
#import "CDCustomerOrderCell.h"
#import "CDLoadingView.h"
#import "CDLocalStorage.h"
#import <Masonry/Masonry.h>

@interface CDOrdersViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CDNavigationBar *navigationView;
@property (nonatomic, strong) UICollectionView *orderView;
@property (nonatomic, strong) UIView *emptyView;

@property (nonatomic, strong) NSArray<CDBaseOrderModel *> *orderModels;

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
    [self showEmptyView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)loadData {
    [CDLoadingView showLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [CDLoadingView dismissLoading];
        self.orderModels = [[CDLocalStorage sharedInstance] hitoryOrders];
        [self.orderView reloadData];
    });
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
    layout.itemSize = CGSizeMake(self.view.width - 40, 120);
    layout.minimumLineSpacing = 10.f;
    self.orderView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.orderView.showsVerticalScrollIndicator = NO;
    self.orderView.showsHorizontalScrollIndicator = NO;
    self.orderView.backgroundColor = [UIColor clearColor];
    self.orderView.dataSource = self;
    self.orderView.delegate = self;
    [self.orderView registerClass:CDCustomerOrderCell.class forCellWithReuseIdentifier:NSStringFromClass(CDCustomerOrderCell.class)];
    [self.view addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.left.offset(20);
        make.right.offset(-20);
        make.bottom.offset(0);
    }];
}

- (void)setOrderModels:(NSArray<CDBaseOrderModel *> *)orderModels {
    _orderModels = orderModels;
    if (orderModels.count > 0) {
        [self hideEmptyView];
    } else {
        [self showEmptyView];
    }
}

- (void)showEmptyView {
    [self setupEmptyView];
    self.emptyView.hidden = NO;
}

- (void)hideEmptyView {
    self.emptyView.hidden = YES;
}

- (void)setupEmptyView {
    if (self.emptyView) {
        return;
    }
    self.emptyView = [[UIView alloc] init];
    self.emptyView.backgroundColor = [UIColor whiteColor];
    self.emptyView.layer.zPosition = 1;
    [self.view addSubview:self.emptyView];
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_bottom);
        make.left.right.bottom.mas_offset(0);
    }];
    
    UILabel *emptyLabel = [[UILabel alloc] init];
    emptyLabel.textColor = [UIColor grayColor];
    emptyLabel.text = @"You haven't placed any orders yet.";
    [self.emptyView addSubview:emptyLabel];
    [emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.emptyView);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.orderModels.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDCustomerOrderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CDCustomerOrderCell.class) forIndexPath:indexPath];
    cell.model = self.orderModels[indexPath.row];
    return cell;
}

@end
