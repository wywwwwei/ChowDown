//
//  CDMainTabBarController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDMainTabBarController.h"

@interface CDMainTabBar : UITabBar

@end

@implementation CDMainTabBar

@end

@interface CDMainTabBarController ()

@end

@implementation CDMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
}

- (void)setupTabBar {
    CDMainTabBar *tabBar = [[CDMainTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

@end
