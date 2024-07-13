//
//  CDHomepageViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDHomepageViewController.h"
#import "CDHomepageShopCell.h"
#import "CDShopDetailsViewController.h"
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
    item1.shopName = @"McDonald's(Hill)";
    item1.shopDescription = @"Western Fast Food";
    item1.shopAvatarUrl = @"https://raw.githubusercontent.com/wywwwwei/TO-DO/master/store/3471720864563.jpg";
    [items addObject:item1];
    
    CDHomepageShopItem *item2 = [[CDHomepageShopItem alloc] init];
    item2.shopName = @"Pizza Hut(Hansen Court)";
    item2.shopDescription = @"Western Fast Food";
    item2.shopAvatarUrl = @"https://raw.githubusercontent.com/wywwwwei/TO-DO/master/store/3461720864562.jpg";
    [items addObject:item2];
    
    CDHomepageShopItem *item3 = [[CDHomepageShopItem alloc] init];
    item3.shopName = @"Barchua House";
    item3.shopDescription = @"Chinese Fast Food";
    item3.shopAvatarUrl = @"https://raw.githubusercontent.com/wywwwwei/TO-DO/master/store/3421720864559.jpg";
    [items addObject:item3];
    
    CDHomepageShopItem *item4 = [[CDHomepageShopItem alloc] init];
    item4.shopName = @"Jollibee (Luen On Apartment)";
    item4.shopDescription = @"Western Fast Food";
    item4.shopAvatarUrl = @"https://raw.githubusercontent.com/wywwwwei/TO-DO/master/store/3451720864562.jpg";
    [items addObject:item4];
    
    CDHomepageShopItem *item5 = [[CDHomepageShopItem alloc] init];
    item5.shopName = @"Malacca Cuisine (Shek Tong Tsui)";
    item5.shopDescription = @"Southeaset Asion · Malaysia";
    item5.shopAvatarUrl = @"https://raw.githubusercontent.com/wywwwwei/TO-DO/master/store/3441720864561.jpg";
    [items addObject:item5];

    CDHomepageShopItem *item6 = [[CDHomepageShopItem alloc] init];
    item6.shopName = @"Ba Yi Restaurant";
    item6.shopDescription = @"Chinese Style";
    item6.shopAvatarUrl = @"https://raw.githubusercontent.com/wywwwwei/TO-DO/master/store/3431720864560.jpg";
    [items addObject:item6];
    
    CDHomepageShopItem *item7 = [[CDHomepageShopItem alloc] init];
    item7.shopName = @"Uncle Korean";
    item7.shopDescription = @"Japanese and Korean";
    item7.shopAvatarUrl = @"https://raw.githubusercontent.com/wywwwwei/TO-DO/master/store/3481720864946.jpg";
    [items addObject:item7];
    
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
    
    self.searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    [self.searchBar addSubview:self.searchIcon];
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(28);
        make.left.offset(14);
        make.centerY.mas_equalTo(self.searchBar);
    }];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.layer.cornerRadius = 15.f;
    self.searchButton.backgroundColor = THEME_COLOR;
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
    self.shopCollectionView.showsVerticalScrollIndicator = NO;
    self.shopCollectionView.showsHorizontalScrollIndicator = NO;
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CDShopDetailsViewController *controller = [[CDShopDetailsViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
