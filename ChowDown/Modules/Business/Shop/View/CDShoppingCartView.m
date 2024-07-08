//
//  CDShoppingCartView.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/19.
//

#import "CDShoppingCartView.h"
#import <Masonry/Masonry.h>
#import "CDShoppingCartViewCell.h"

@interface CDShoppingCartView ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UIButton *backButton;

@property(nonatomic, strong) UIView *topView;

@property(nonatomic, strong) UIView *topClearView;

@property(nonatomic, strong) UIView *buttomView;

@property(nonatomic, strong) UIButton *shoppingButtton;

@property(nonatomic, strong) UILabel *numberLabel;

@property(nonatomic, strong) UILabel *priceLabel;

@property(nonatomic, strong) UIButton *payButtton;

@property(nonatomic, strong) UILabel *leftTitleLabel;

@property(nonatomic, strong) UIButton *clearShopping;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CDShoppingCartView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        [self loadData];
    }
    return self;
}

- (void)loadData {
    [self.tableView reloadData];
}

// 计算价格 更新UI
- (void)calculatePrice {
    int allNumber = 0;
    int allPrice = 0;
    [self.listArrays removeAllObjects];
    for (CDShopDetailsModel *model in self.dataArrays) {
        allNumber += model.payNumber;
        allPrice += (model.payNumber * [model.price intValue]);

        if (model.payNumber > 0) {
            [self.listArrays addObject:model];
        }
    }
    self.numberLabel.text = [NSString stringWithFormat:@"Select %d %@", allNumber, allNumber > 1 ? @"items": @"item"];
    self.priceLabel.text = [NSString stringWithFormat:@" $%d",allPrice];
    [self.tableView reloadData];
}

- (void)touchBackButtonEvent {
    self.tuochCloseBlock();
}

- (void)touchShoppingButttonEvent {
    self.tuochShoppingBlock();
}

- (void)touchPayButttonEvent {
    self.tuochJumpBlock();
}

- (void)touchClearShoppingButttonEvent {
    for (CDShopDetailsModel *model in self.dataArrays) {
        model.payNumber = 0;
    }
    [self calculatePrice];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDShoppingCartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartViewCell" forIndexPath:indexPath];
    [cell setModel:self.listArrays[indexPath.row]];
    __weak typeof(self) weakSelf = self;
    cell.tuochAddOrDecreaseBlock = ^{
        [weakSelf calculatePrice];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CDShoppingCartViewCell class] forCellReuseIdentifier:@"ShoppingCartViewCell"];
    }
    return _tableView;
}

- (NSMutableArray<CDShopDetailsModel *> *)listArrays {
    if (!_listArrays) {
        _listArrays = [[NSMutableArray alloc] init];
    }
    return _listArrays;
}

- (void)buildUI {
    self.layer.masksToBounds = true;

    self.backButton = [[UIButton alloc] init];
    self.backButton.backgroundColor = [UIColor blackColor];
    self.backButton.alpha = 0.1;
    [self.backButton addTarget:self action:@selector(touchBackButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];

    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.topView];

    self.topClearView = [[UIView alloc] init];
    self.topClearView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.08];
    [self.topView addSubview:self.topClearView];

    self.buttomView = [[UIView alloc] init];
    self.buttomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.buttomView];

    self.shoppingButtton = [[UIButton alloc] init];
    [self.shoppingButtton setBackgroundImage:[UIImage imageNamed:@"shopping_cart"] forState:UIControlStateNormal];
    [self.shoppingButtton addTarget:self action:@selector(touchShoppingButttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.buttomView addSubview:self.shoppingButtton];

    self.numberLabel = [[UILabel alloc] init];
    self.numberLabel.text = @"select0a";
    self.numberLabel.font = [UIFont systemFontOfSize:12];
    self.numberLabel.textColor = [UIColor blackColor];
    [self addSubview:self.numberLabel];

    self.leftTitleLabel = [[UILabel alloc] init];
    self.leftTitleLabel.text = @"Order cart";
    self.leftTitleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.leftTitleLabel.textColor = [UIColor blackColor];
    [self.topClearView addSubview:self.leftTitleLabel];

    self.priceLabel = [[UILabel alloc] init];
    self.priceLabel.text = @" $0";
    self.priceLabel.numberOfLines = 0;
    self.priceLabel.font = [UIFont boldSystemFontOfSize:16];
    self.priceLabel.textColor = [UIColor redColor];
    [self addSubview:self.priceLabel];

    self.payButtton = [[UIButton alloc] init];
    [self.payButtton setTitle:@"Go to Result" forState:UIControlStateNormal];
    [self.payButtton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.payButtton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.payButtton addTarget:self action:@selector(touchPayButttonEvent) forControlEvents:UIControlEventTouchUpInside];
    self.payButtton.backgroundColor = THEME_COLOR;
    [self.buttomView addSubview:self.payButtton];

    self.clearShopping = [[UIButton alloc] init];
    [self.clearShopping setTitle:@"Empty cart" forState:UIControlStateNormal];
    [self.clearShopping setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.clearShopping.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.clearShopping addTarget:self action:@selector(touchClearShoppingButttonEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.topClearView addSubview:self.clearShopping];

    [self.topView addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.equalTo(self.topClearView.mas_bottom);
    }];

    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];

    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(self.buttomView.mas_top);
        make.height.mas_equalTo(350);
    }];

    [self.topClearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];

    [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
    }];

    [self.clearShopping mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.bottom.mas_equalTo(0);
    }];

    [self.buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];

    [self.shoppingButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(20);
        make.width.height.mas_equalTo(40);
    }];

    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shoppingButtton.mas_right).offset(10);
        make.bottom.equalTo(self.priceLabel.mas_top).offset(0);
    }];

    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shoppingButtton.mas_right).offset(10);
        make.bottom.equalTo(self.shoppingButtton);
    }];

    [self.payButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(180);
    }];
}

@end
