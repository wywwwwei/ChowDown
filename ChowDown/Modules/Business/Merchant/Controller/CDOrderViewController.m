//
//  CDOrderViewController.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDOrderViewController.h"
#import <Masonry/Masonry.h>
#import "CDShopDetailsModel.h"
#import "CDOrderTableViewCell.h"
#import "CDOrderModel.h"
#import "CDOrderDetailsViewController.h"

@interface CDOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<CDOrderModel *> *dataArrays;

@property (nonatomic, strong) NSMutableArray<CDOrderModel *> *selectDataArrays;

@property (nonatomic, strong) UITextField *textFiled;

@end

@implementation CDOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createUI];
    [self loadData];
}

- (void)createUI {
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(60);
        make.bottom.mas_equalTo(0);
    }];

    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(40);
    }];
}

- (void)loadData {
    NSMutableArray<CDOrderModel *> *arrays = [NSMutableArray array];
    for (int i = 0; i< 20; i++) {
        CDOrderModel *model = [[CDOrderModel alloc] init];
        model.orderCode = [NSString stringWithFormat:@"542%d", i + 100];;
        model.orderType = i % 4;
        model.name = @"Jackhorse";
        model.phone = @"001(358)1395590";
        model.address = @"Albertson Oldsmobile Chevrolet";
        model.time = @"2024-06-06";
        model.price = @"100";
        [arrays addObject:model];
    }
    self.dataArrays = arrays;
    for (CDOrderModel *model in self.dataArrays) {
        [self.selectDataArrays addObject:model];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectDataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CDOrderTableViewCell.class) forIndexPath:indexPath];
    [cell setModel:self.selectDataArrays[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CDOrderDetailsViewController *orderDetailsViewController = [[CDOrderDetailsViewController alloc] init];
    orderDetailsViewController.model = self.dataArrays[indexPath.row];
    [self.navigationController pushViewController:orderDetailsViewController animated:true];
}

- (void)textViewValueChanged {
    NSString *strUrl = [self.textFiled.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (strUrl.length == 0) {
        for (CDOrderModel *model in self.dataArrays) {
            [self.selectDataArrays addObject:model];
        }
    } else {
        [self.selectDataArrays removeAllObjects];
        for (CDOrderModel *model in self.dataArrays) {
            if ([model.orderCode containsString:strUrl]) {
                [self.selectDataArrays addObject:model];
            }
        }
    }
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[CDOrderTableViewCell class] forCellReuseIdentifier:NSStringFromClass(CDOrderTableViewCell.class)];
    }
    return _tableView;
}


- (NSMutableArray<CDOrderModel *> *)selectDataArrays {
    if (!_selectDataArrays) {
        _selectDataArrays = [[NSMutableArray alloc] init];
    }

    return _selectDataArrays;
}

- (UITextField *)textFiled {
    if (!_textFiled) {
        _textFiled = [[UITextField alloc] init];
        _textFiled.leftViewMode = UITextFieldViewModeAlways;
        _textFiled.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
        _textFiled.layer.cornerRadius = 6;
        _textFiled.layer.masksToBounds = true;
        _textFiled.layer.borderColor = [[UIColor darkGrayColor] CGColor];
        _textFiled.layer.borderWidth = 1;
        _textFiled.font = [UIFont systemFontOfSize:16];
        _textFiled.textColor = [UIColor blackColor];
        _textFiled.placeholder = @"Please enter the order number to search";
        [_textFiled addTarget:self action:@selector(textViewValueChanged) forControlEvents:UIControlEventAllEditingEvents];
    }

    return _textFiled;
}


@end
