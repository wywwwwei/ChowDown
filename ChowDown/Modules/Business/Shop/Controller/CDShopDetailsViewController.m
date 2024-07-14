//
//  CDShopDetailsViewController.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/19.
//

#import "CDShopDetailsViewController.h"
#import "CDShopDetailsTableViewCell.h"
#import "CDShopDetailsModel.h"
#import "CDShopDetailsHeaderView.h"
#import "CDShoppingCartView.h"
#import "CDSubmitOrderViewController.h"
#import "CDNavigationBar.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface CDShopDetailsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CDNavigationBar *navigationBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CDShopDetailsHeaderView *headerView;

@property (nonatomic, strong) CDShoppingCartView *shoppingCartView;

@property (nonatomic, strong) NSMutableArray<CDShopDetailsModel *> *dataArrays;

@end

@implementation CDShopDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createUI];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)createUI {
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.shoppingCartView];
    
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.top.left.mas_equalTo(0);
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.bottom.mas_equalTo(-80);
    }];

    [self.shoppingCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
}

- (void)loadData {
    NSMutableArray<CDShopDetailsModel *> *booksArray = [NSMutableArray array];

    NSArray *names = @[@"Ebi Series Combo for 3",@"Ebi Combo for 2",@"Ebi Burger with Fish Combo for 1",@"Ebi Burger with Pineapple Combo for 1",@"Ebi Burger Combo for 1",@"Crispy Thighs Sharing Bucket Combo for 3",@"Burger Lovers Combo for 3",@"Crispy Thighs Sharing Bucket Combo for 2",@"Burger Lovers Combo for 2"];
    NSArray *prices = @[@"189.00",@"126.00",@"69.00",@"66.00",@"63.00",@"183.00",@"159.00",@"128.00",@"115.00"];


    for (int i = 0; i< names.count; i++) {
        CDShopDetailsModel *model = [[CDShopDetailsModel alloc] init];
        model.name = names[i];
        model.coverUrl = [NSString stringWithFormat:@"%d.jpeg",i + 1];
        model.introduce = @"It's really, really good";
        model.sales = @"1000";
        model.price = prices[i];
        model.payNumber = 0;
        [booksArray addObject:model];
    }
    self.dataArrays = booksArray;
    self.shoppingCartView.dataArrays = self.dataArrays;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDShopDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CDShopDetailsTableViewCell.class) forIndexPath:indexPath];
    [cell setModel:self.dataArrays[indexPath.row]];
    __weak typeof(self) weakSelf = self;
    cell.tuochAddBlock = ^{
        [weakSelf.shoppingCartView calculatePrice];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CDShopDetailsTableViewCell class] forCellReuseIdentifier:NSStringFromClass(CDShopDetailsTableViewCell.class)];
    }
    return _tableView;
}

- (CDNavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[CDNavigationBar alloc] initWithTitle:nil];
    }
    return _navigationBar;
}

- (CDShopDetailsHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CDShopDetailsHeaderView alloc] initWithFrame:CGRectZero];
    }
    return _headerView;
}

- (CDShoppingCartView *)shoppingCartView {
    if (!_shoppingCartView) {
        _shoppingCartView = [[CDShoppingCartView alloc] init];
        __weak typeof(self) weakSelf = self;
        _shoppingCartView.tuochShoppingBlock = ^{
            [weakSelf.shoppingCartView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(weakSelf.view.frame.size.height);
            }];
        };
        _shoppingCartView.tuochCloseBlock = ^{
            [weakSelf.shoppingCartView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(80);
            }];
        };

        _shoppingCartView.tuochJumpBlock = ^{
            if (weakSelf.shoppingCartView.listArrays.count == 0) {
                [SVProgressHUD setMaximumDismissTimeInterval:0.5];
                [SVProgressHUD showInfoWithStatus:@"Please add goods first"];
                return;
            }

            [weakSelf.shoppingCartView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(80);
            }];

            CDSubmitOrderViewController *submitOrderViewController = [[CDSubmitOrderViewController alloc] init];
            submitOrderViewController.dataArrays = weakSelf.shoppingCartView.listArrays;
            submitOrderViewController.shopName = @"McDonald‘s";
            submitOrderViewController.tuochPayCompletionBlock = ^{
                [weakSelf.shoppingCartView touchClearShoppingButttonEvent];
            };
            [weakSelf.navigationController pushViewController:submitOrderViewController animated:true];
        };
    }
    return _shoppingCartView;
}

@end
