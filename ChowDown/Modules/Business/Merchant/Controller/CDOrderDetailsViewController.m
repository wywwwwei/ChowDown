//
//  CDOrderDetailsViewController.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDOrderDetailsViewController.h"

@interface CDOrderDetailsViewController ()

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

- (void)createUI {
    [self.view addSubview:self.contentLabel];
    NSString *content = [NSString stringWithFormat:@"Name：%@\n\nPhone：%@\n\nAddress：%@\n\nTime：%@\n\nPrice： $%@\n\nOrder number：%@\n\nOrder status：%@",self.model.name,self.model.phone,self.model.address,self.model.time,self.model.price,self.model.orderCode,self.model.orderTypeString];
    self.contentLabel.text = content;
    [self.contentLabel sizeToFit];
    self.contentLabel.frame = CGRectMake(20, 20, self.view.frame.size.width - 40, self.contentLabel.frame.size.height + 10);
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
