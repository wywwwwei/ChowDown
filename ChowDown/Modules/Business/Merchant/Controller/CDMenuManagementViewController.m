//
//  CDMenuManagementViewController.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDMenuManagementViewController.h"
#import <Masonry/Masonry.h>
#import "CDShopDetailsModel.h"
#import "CDMenuManagementTableViewCell.h"
#import "CDMenuManagementModel.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface CDMenuManagementViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<CDMenuManagementModel *> *dataArrays;

@property (nonatomic, strong) NSMutableArray<CDMenuManagementModel *> *selectDataArrays;

@property (nonatomic, strong) UITextField *textFiled;

@end

@implementation CDMenuManagementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createUI];
    [self loadData];
}

- (void)createUI {
    [self.view addSubview:self.tableView];

    [self.view addSubview:self.textFiled];

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
    NSMutableArray<CDMenuManagementModel *> *arrays = [NSMutableArray array];

    NSArray *names = @[@"Ebi Series Combo for 3",@"Ebi Combo for 2",@"Ebi Burger with Fish Combo for 1",@"Ebi Burger with Pineapple Combo for 1",@"Ebi Burger Combo for 1",@"Crispy Thighs Sharing Bucket Combo for 3",@"Burger Lovers Combo for 3",@"Crispy Thighs Sharing Bucket Combo for 2",@"Burger Lovers Combo for 2"];
    NSArray *prices = @[@"189.00",@"126.00",@"69.00",@"66.00",@"63.00",@"183.00",@"159.00",@"128.00",@"115.00"];

    for (int i = 0; i< names.count; i++) {
        CDMenuManagementModel *model = [[CDMenuManagementModel alloc] init];
        model.menuId = [NSString stringWithFormat:@"%d", i];
        model.name = names[i];
        model.coverUrl = [NSString stringWithFormat:@"%d.jpeg",i + 1];
        model.type = i%2;
        model.price = prices[i];
        [arrays addObject:model];
    }
    self.dataArrays = arrays;
    for (CDMenuManagementModel *model in self.dataArrays) {
        [self.selectDataArrays addObject:model];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectDataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDMenuManagementTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CDMenuManagementTableViewCell.class) forIndexPath:indexPath];
    [cell setModel:self.selectDataArrays[indexPath.row]];
    __weak typeof(self) weakSelf = self;
    cell.tuochDeleteEventBlock = ^{
        CDMenuManagementModel *tempModel = weakSelf.selectDataArrays[indexPath.row];
        for (CDMenuManagementModel *model in self.dataArrays) {
            if ([model.menuId isEqualToString:tempModel.menuId]) {
                [self.dataArrays removeObject:model];
                break;
            }
        }
        [weakSelf.selectDataArrays removeObjectAtIndex:indexPath.row];
        [weakSelf.tableView reloadData];
        [SVProgressHUD setMaximumDismissTimeInterval:0.5];
        [SVProgressHUD showSuccessWithStatus:@"Successfully deleted"];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170.0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)textViewValueChanged {
    NSString *strUrl = [self.textFiled.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (strUrl.length == 0) {
        for (CDMenuManagementModel *model in self.dataArrays) {
            [self.selectDataArrays addObject:model];
        }
    } else {
        [self.selectDataArrays removeAllObjects];
        for (CDMenuManagementModel *model in self.dataArrays) {
            if ([model.name containsString:strUrl]) {
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
        [_tableView registerClass:[CDMenuManagementTableViewCell class] forCellReuseIdentifier:NSStringFromClass(CDMenuManagementTableViewCell.class)];
    }
    return _tableView;
}

- (NSMutableArray<CDMenuManagementModel *> *)selectDataArrays {
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
        _textFiled.placeholder = @"Please enter the name of the search";
        [_textFiled addTarget:self action:@selector(textViewValueChanged) forControlEvents:UIControlEventAllEditingEvents];
    }

    return _textFiled;
}

@end

