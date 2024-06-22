//
//  CDHomepageViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDHomepageViewController.h"
#import "CDHomepageShopCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface CDHomepageViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *searchBar;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIButton *searchButton;

@property (nonatomic, strong) UICollectionView *shopCollectionView;
@property (nonatomic, strong) NSArray<CDHomepageShopItem *> *shopItems;
@end

@implementation CDHomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEXCOLOR(0xF9F5F4);
    [self setupShopItems];
    [self setupSearchBar];
    [self setupShopCollectionView];
}

- (void)setupShopItems {
    if (self.shopItems) {
        return;
    }
    NSMutableArray *items = [NSMutableArray array];
    CDHomepageShopItem *item1 = [[CDHomepageShopItem alloc] init];
    item1.shopName = @"食光Cake蛋糕店";
    item1.shopDescription = @"现做蛋糕";
    item1.shopAvatarUrl = @"https://img.zcool.cn/community/01f23558f864d2a8012049ef325ff0.jpg?imageMogr2/auto-orient/thumbnail/1280x%3e/sharpen/0.5/quality/100/format/webp";
    [items addObject:item1];
    
    CDHomepageShopItem *item2 = [[CDHomepageShopItem alloc] init];
    item2.shopName = @"喜茶";
    item2.shopDescription = @"来杯喜茶，喜悦发生";
    item2.shopAvatarUrl = @"https://tradetm.zbjimg.com/tm/7f/81/b6/32785457.jpg";
    [items addObject:item2];
    
    CDHomepageShopItem *item3 = [[CDHomepageShopItem alloc] init];
    item3.shopName = @"麦当劳";
    item3.shopDescription = @"高分店铺";
    item3.shopAvatarUrl = @"https://x0.ifengimg.com/res/2020/0593E72D7004F5472A2609DB6B3594ACF169AE0B_size3_w1000_h600.png";
    [items addObject:item3];

    self.shopItems = items;
}

- (void)setupSearchBar {
    if (self.searchBar) {
        return;
    }
    self.searchBar = [[UIView alloc] init];
    self.searchBar.layer.cornerRadius = 25.f;
    self.searchBar.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30);
        make.right.offset(-30);
        make.top.offset(20 + [CDCommonUtils safeAreaInsets].top);
        make.height.mas_equalTo(50);
    }];
    
    self.searchIcon = [[UIImageView alloc] init];
    [self.searchIcon sd_setImageWithURL:[NSURL URLWithString:@"https://img.icons8.com/?size=60&id=59878&format=png"]];
    [self.searchBar addSubview:self.searchIcon];
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(28);
        make.left.offset(14);
        make.centerY.mas_equalTo(self.searchBar);
    }];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.layer.cornerRadius = 15.f;
    self.searchButton.backgroundColor = HEXCOLOR(0xFFC600);
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
    [self.searchButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.searchButton setTitle:@"Search" forState:UIControlStateNormal];
    [self.searchBar addSubview:self.searchButton];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
        make.right.offset(-8);
        make.centerY.mas_equalTo(self.searchBar);
    }];
    
    self.searchField = [[UITextField alloc] init];
    [self.searchBar addSubview:self.searchField];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchIcon.mas_right).offset(6);
        make.centerY.mas_equalTo(self.searchBar);
        make.height.mas_equalTo(self.searchBar);
        make.right.mas_equalTo(self.searchButton.mas_left).offset(-4);
    }];
}

- (void)setupShopCollectionView {
    if (self.shopCollectionView) {
        return;
    }
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.view.width - 40, 80);
    layout.minimumLineSpacing = 10.f;
    self.shopCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.shopCollectionView.backgroundColor = [UIColor clearColor];
    self.shopCollectionView.dataSource = self;
    self.shopCollectionView.delegate = self;
    [self.shopCollectionView registerClass:CDHomepageShopCell.class forCellWithReuseIdentifier:NSStringFromClass(CDHomepageShopCell.class)];
    [self.view addSubview:self.shopCollectionView];
    [self.shopCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.searchBar.mas_bottom).offset(40);
        make.left.offset(20);
        make.right.offset(-20);
        make.bottom.offset(0);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.shopItems.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDHomepageShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CDHomepageShopCell.class) forIndexPath:indexPath];
    cell.item = self.shopItems[indexPath.row];
    return cell;
}

@end
