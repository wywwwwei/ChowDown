//
//  CDMerchantBaseViewController.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDMerchantBaseViewController.h"
#import "CDNavigationBar.h"
#import <YNPageViewController/YNPageViewController.h>
#import <Masonry/Masonry.h>
#import "CDOrderViewController.h"
#import "CDMenuManagementViewController.h"

@interface CDMerchantBaseViewController ()
<YNPageViewControllerDataSource,
YNPageViewControllerDelegate,
YNPageScrollMenuViewDelegate>

@property (nonatomic, strong) CDNavigationBar *navigationBar;

@property (nonatomic, strong) YNPageViewController *pageViewController;

@property (nonatomic, strong) CDOrderViewController *orderViewController;

@property (nonatomic, strong) CDMenuManagementViewController *menuViewController;

@end

@implementation CDMerchantBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Merchant side";
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
    [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.top.left.mas_equalTo(0);
    }];
    
    [self.pageViewController addSelfToParentViewController:self];
    [self.pageViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navigationBar.mas_bottom);
        make.left.right.bottom.mas_offset(0);
    }];
}

- (void)loadData {

}

#pragma mark --- YNPageViewControllerDataSource代理方法

- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    if (index == 0) {
        return self.orderViewController.tableView;
    }
    return self.menuViewController.tableView;
}

- (NSString *)pageViewController:(YNPageViewController *)pageViewController
          customCacheKeyForIndex:(NSInteger )index {
    NSArray *arrays = @[@"Order management",@"Menu management"];
    return arrays[index];
}

#pragma mark --- YNPageScrollMenuViewDelegate代理方法

- (void)pageViewController:(YNPageViewController *)pageViewController
         didScrollMenuItem:(UIButton *)itemButton
                     index:(NSInteger)index {

}

/** 获取分页的视图控制器数组 */
- (NSArray *)getVCArrays {
    NSMutableArray * arrays = [NSMutableArray new];
    self.orderViewController = [[CDOrderViewController alloc] init];
    self.menuViewController = [[CDMenuManagementViewController alloc] init];
    [arrays addObject:self.orderViewController];
    [arrays addObject:self.menuViewController];
    return arrays;
}

- (CDNavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[CDNavigationBar alloc] initWithTitle:@"Merchant Manage"];
    }
    return _navigationBar;
}

- (YNPageViewController *)pageViewController {
    if (!_pageViewController) {
        YNPageConfigration *configration = [YNPageConfigration defaultConfig];
        configration.itemFont = [UIFont boldSystemFontOfSize:18];
        configration.selectedItemFont = [UIFont boldSystemFontOfSize:18];
        configration.normalItemColor = [UIColor darkGrayColor];
        configration.selectedItemColor = [UIColor blackColor];
        configration.itemMaxScale = 0;
        configration.lineWidthEqualFontWidth = YES;
        configration.showTabbar = NO;
        configration.showNavigation = YES;
        configration.menuHeight = 0;
        configration.scrollMenu = NO;
        configration.aligmentModeCenter = NO;
        configration.showBottomLine = YES;
        configration.bottomLineHeight = 0;
        configration.menuHeight = 44;
        configration.lineColor = THEME_COLOR;
        _pageViewController = [YNPageViewController pageViewControllerWithControllers:self.getVCArrays
                                                                               titles:@[@"Order management",@"Menu management"]
                                                                               config:configration];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        _pageViewController.bgScrollView.scrollsToTop = NO;
    }
    return _pageViewController;
}

@end
