//
//  CDMainViewController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDMainViewController.h"
#import "CDMainTabBarController.h"
#import "CDHomepageViewController.h"
#import "CDProfileViewController.h"
#import <Masonry/Masonry.h>

@interface CDMainViewController ()

@property (nonatomic, strong) CDMainTabBarController *bottomTabBarController;

@end

@implementation CDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBottomTabBarController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)setupBottomTabBarController {
    if (self.bottomTabBarController) {
        return;
    }
    self.bottomTabBarController = [[CDMainTabBarController alloc] init];
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:[UIImage imageNamed:@"home"] tag:CDMainViewTabTagHome];
    CDHomepageViewController *homeViewController = [[CDHomepageViewController alloc] init];
    homeViewController.tabBarItem = homeItem;
    
    UITabBarItem *profileItem = [[UITabBarItem alloc] initWithTitle:@"Profile" image:[UIImage imageNamed:@"profile"] tag:CDMainViewTabTagProfile];
    CDProfileViewController *profileViewController = [[CDProfileViewController alloc] init];
    profileViewController.tabBarItem = profileItem;
    
    self.bottomTabBarController.viewControllers = @[homeViewController, profileViewController];
    
    UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
    [appearance configureWithOpaqueBackground];
    appearance.backgroundColor = [UIColor whiteColor];
    UITabBarItemAppearance *itemAppearance = [[UITabBarItemAppearance alloc] init];
    itemAppearance.normal.titleTextAttributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:12 weight:UIFontWeightSemibold],
    };
    itemAppearance.selected.titleTextAttributes = @{
        NSFontAttributeName:[UIFont systemFontOfSize:12 weight:UIFontWeightSemibold],
    };
    itemAppearance.normal.iconColor = [UIColor grayColor];
    itemAppearance.selected.iconColor = HEXCOLOR(0xFFC600);
    itemAppearance.normal.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor grayColor]};
    itemAppearance.selected.titleTextAttributes = @{NSForegroundColorAttributeName: HEXCOLOR(0xFFC600)};
    appearance.inlineLayoutAppearance = itemAppearance;
    appearance.stackedLayoutAppearance = itemAppearance;
    self.bottomTabBarController.tabBar.standardAppearance = appearance;
    self.bottomTabBarController.tabBar.scrollEdgeAppearance = appearance;
    self.bottomTabBarController.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, [CDCommonUtils safeAreaInsets].bottom, 0);
    [self.view addSubview:self.bottomTabBarController.view];
}

@end
