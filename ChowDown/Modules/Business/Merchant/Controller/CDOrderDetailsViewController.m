//
//  CDOrderDetailsViewController.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDOrderDetailsViewController.h"
#import "CDNavigationBar.h"
#import <Masonry/Masonry.h>

@interface CDOrderDetailsViewController ()

@property (nonatomic, strong) CDNavigationBar *navigationView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CDOrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Order details";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createUI];
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
    [self setupNavigationView];
    
    [self.view addSubview:self.contentLabel];
    NSString *content = [NSString stringWithFormat:@"Name：%@\n\nPhone：%@\n\nAddress：%@\n\nTime：%@\n\nPrice： $%@\n\nOrder number：%@\n\nOrder status：%@",self.model.name,self.model.phone,self.model.address,self.model.time,self.model.price,self.model.orderCode,self.model.orderTypeString];
    self.contentLabel.text = content;
    [self.contentLabel sizeToFit];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationView.mas_bottom).offset(20);
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
    }];
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

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 110)];
        _contentLabel.text = @"1111111";
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.numberOfLines = 0;
    }

    return _contentLabel;
}

@end
