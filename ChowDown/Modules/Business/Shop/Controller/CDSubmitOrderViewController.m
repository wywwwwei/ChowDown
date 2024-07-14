//
//  CDSubmitOrderViewController.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDSubmitOrderViewController.h"
#import "CDSubmitOrderHeaderView.h"
#import "CDSubmitOrderFooterView.h"
#import "CDSubmitOrderPayView.h"
#import "CDSubmitOrderTableViewCell.h"
#import "CDNavigationBar.h"
#import "CDLocalStorage.h"
#import <Masonry/Masonry.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <WXApi.h>

@interface CDSubmitOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CDNavigationBar *navigationBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CDSubmitOrderHeaderView *headerView;

@property (nonatomic, strong) CDSubmitOrderFooterView *fotterView;

@property (nonatomic, strong) CDSubmitOrderPayView *submitOrderPayView;

@end

@implementation CDSubmitOrderViewController

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
    [self.view addSubview:self.submitOrderPayView];
    [self.view addSubview:self.tableView];
    
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.top.left.mas_equalTo(0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.bottom.mas_equalTo(-80);
    }];

    [self.submitOrderPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
}

- (void)loadData {
    [self.tableView reloadData];
}

- (void)payCompletion {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Payment success"
                                                                             message:@"The current order has been paid"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        CDBaseOrderModel *order = [[CDBaseOrderModel alloc] init];
        order.buyItems = self.dataArrays;
        order.shopName = self.shopName;
        order.orderCode = @(floor(CACurrentMediaTime())).stringValue;
        order.time = [CDCommonUtils currentTimeStr];
        int allPrice = 0;
        for (CDShopDetailsModel *model in self.dataArrays) {
            allPrice += (model.payNumber * [model.price intValue]);
        }
        order.price = @(allPrice).stringValue;
        [[CDLocalStorage sharedInstance] addOrder:order];
        self.tuochPayCompletionBlock();
        [self.navigationController popViewControllerAnimated:true];
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDSubmitOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CDSubmitOrderTableViewCell.class) forIndexPath:indexPath];
    [cell setModel:self.dataArrays[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.layer.masksToBounds = true;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width - 40, 50)];
    backView.backgroundColor=  [UIColor whiteColor];
    backView.layer.cornerRadius = 6;
    backView.layer.masksToBounds = true;
    [headerView addSubview:backView];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width - 40, 40)];
    titleLabel.text = @"Order details";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = [UIColor blackColor];
    [backView addSubview:titleLabel];

    return headerView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    headerView.backgroundColor = [UIColor clearColor];
    headerView.layer.masksToBounds = true;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, -10, self.view.frame.size.width - 40, 20)];
    backView.backgroundColor=  [UIColor whiteColor];
    backView.layer.cornerRadius = 6;
    backView.layer.masksToBounds = true;
    [headerView addSubview:backView];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = self.fotterView;
        [_tableView registerClass:[CDSubmitOrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass(CDSubmitOrderTableViewCell.class)];
    }
    return _tableView;
}

- (CDNavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[CDNavigationBar alloc] initWithTitle:@"Submit Order"];
    }
    return _navigationBar;
}

- (CDSubmitOrderHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CDSubmitOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    }
    return _headerView;
}

- (CDSubmitOrderPayView *)submitOrderPayView {
    if (!_submitOrderPayView) {
        _submitOrderPayView = [[CDSubmitOrderPayView alloc] init];
        _submitOrderPayView.dataArrays = self.dataArrays;
        __weak typeof(self) weakSelf = self;
        _submitOrderPayView.tuochPayBlock = ^{
            if (weakSelf.headerView.addressTextView.text.length == 0 ) {
                [SVProgressHUD setMaximumDismissTimeInterval:0.5];
                [SVProgressHUD showInfoWithStatus:@"Please add the shipping address first"];
                return;
            }

            if (weakSelf.fotterView.selectButton.isSelected == false) {
                [SVProgressHUD setMaximumDismissTimeInterval:0.5];
                [SVProgressHUD showInfoWithStatus:@"Please select a payment method first"];
                return;
            }

            /// 微信跳转支付
            PayReq *req  = [[PayReq alloc] init];
            req.partnerId = @"123131231";
            req.prepayId = @"123131231";
            req.package =  @"123131231";
            req.nonceStr =  @"123131231";
            req.timeStamp =  123131231;
            req.sign =  @"123131231";
            [WXApi sendReq:req completion:^(BOOL success) {
                [weakSelf payCompletion];
            }];
            
        };

    }
    return _submitOrderPayView;
}

- (CDSubmitOrderFooterView *)fotterView {
    if (!_fotterView) {
        _fotterView = [[CDSubmitOrderFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250)];

    }

    return _fotterView;
}

@end
