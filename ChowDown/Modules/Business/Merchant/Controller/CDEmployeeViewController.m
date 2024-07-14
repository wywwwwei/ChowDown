//
//  CDEmployeeViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/14.
//

#import "CDEmployeeViewController.h"
#import "CDEmployeeModel.h"
#import "CDEmployeeTableViewCell.h"
#import <Masonry/Masonry.h>

@interface CDEmployeeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<CDEmployeeModel *> *dataArrays;

@property (nonatomic, strong) NSMutableArray<CDEmployeeModel *> *selectDataArrays;

@property (nonatomic, strong) UITextField *textFiled;


@end

@implementation CDEmployeeViewController

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
    NSMutableArray<CDEmployeeModel *> *arrays = [NSMutableArray array];
    NSArray *names = @[@"Emily",
                       @"Jacob",
                       @"Olivia",
                       @"William",
                       @"Sophia",
                       @"Daniel",
                       @"Isabella",
                       @"Alexander",
                       @"Emma"];
    for (int i = 0; i < names.count; i++) {
        CDEmployeeModel *model = [[CDEmployeeModel alloc] init];
        model.employeeId = @(random() % 1000).stringValue;
        model.name = names[i];
        model.status = random() % 3;
        [arrays addObject:model];
    }
    self.dataArrays = arrays;
    for (CDEmployeeModel *model in self.dataArrays) {
        [self.selectDataArrays addObject:model];
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectDataArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDEmployeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(CDEmployeeTableViewCell.class) forIndexPath:indexPath];
    [cell setModel:self.selectDataArrays[indexPath.row]];
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
        for (CDEmployeeModel *model in self.dataArrays) {
            [self.selectDataArrays addObject:model];
        }
    } else {
        [self.selectDataArrays removeAllObjects];
        for (CDEmployeeModel *model in self.dataArrays) {
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
        [_tableView registerClass:[CDEmployeeTableViewCell class] forCellReuseIdentifier:NSStringFromClass(CDEmployeeTableViewCell.class)];
    }
    return _tableView;
}

- (NSMutableArray<CDEmployeeModel *> *)selectDataArrays {
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
