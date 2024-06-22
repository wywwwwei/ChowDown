//
//  CDProfileViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDProfileViewController.h"
#import "CDProfileFunctionCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface CDProfileFunction : NSObject

@end

@interface CDProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nicknameLabel;

@property (nonatomic, strong) UICollectionView *functionCollectionView;
@property (nonatomic, strong) NSArray<CDProfileFunctionItem *> *functionItems;
@end

@implementation CDProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self setupFunctionItems];
    [self setupInfoView];
    [self setupFunctionCollectionView];
}

- (void)setupFunctionItems {
    if (self.functionItems) {
        return;
    }
    NSMutableArray *items = [NSMutableArray array];
    CDProfileFunctionItem *addressItem = [[CDProfileFunctionItem alloc] init];
    addressItem.iconUrl = @"https://img.icons8.com/?size=100&id=53383&format=png";
    addressItem.functionTitle = @"地址管理";
    [items addObject:addressItem];
    
    CDProfileFunctionItem *orderItem = [[CDProfileFunctionItem alloc] init];
    orderItem.iconUrl = @"https://img.icons8.com/?size=100&id=4255&format=png";
    orderItem.functionTitle = @"历史订单";
    [items addObject:orderItem];
    
    self.functionItems = items;
}

- (void)setupInfoView {
    if (self.infoView) {
        return;
    }
    self.infoView = [[UIView alloc] init];
    
    self.avatarView = [[UIImageView alloc] init];
    self.avatarView.contentMode = UIViewContentModeScaleAspectFill;
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:@"https://media.newyorker.com/photos/5909743dc14b3c606c108588/master/pass/160229_r27717.jpg"]];
    self.avatarView.layer.cornerRadius = 64.0f;
    self.avatarView.layer.masksToBounds = YES;
    [self.infoView addSubview:self.avatarView];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.width.height.mas_equalTo(128.f);
        make.left.offset(40);
    }];
    
    self.nicknameLabel = [[UILabel alloc] init];
    self.nicknameLabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    self.nicknameLabel.textColor = [UIColor blackColor];
    self.nicknameLabel.text = @"TestAccount";
    [self.infoView addSubview:self.nicknameLabel];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarView.mas_right).offset(40);
        make.centerY.mas_equalTo(self.avatarView);
    }];
    
    [self.view addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.width.mas_equalTo(self.view);
    }];
}

- (void)setupFunctionCollectionView {
    if (self.functionCollectionView) {
        return;
    }
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(80, 100);
    self.functionCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.functionCollectionView.dataSource = self;
    self.functionCollectionView.delegate = self;
    [self.functionCollectionView registerClass:CDProfileFunctionCell.class forCellWithReuseIdentifier:NSStringFromClass(CDProfileFunctionCell.class)];
    [self.view addSubview:self.functionCollectionView];
    [self.functionCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoView.mas_bottom).offset(40);
        make.left.offset(40);
        make.right.offset(-40);
        make.bottom.offset(0);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.functionItems.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDProfileFunctionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CDProfileFunctionCell.class) forIndexPath:indexPath];
    cell.item = self.functionItems[indexPath.row];
    return cell;
}

@end
