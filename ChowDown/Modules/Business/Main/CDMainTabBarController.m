//
//  CDMainTabBarController.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "CDMainTabBarController.h"

const CGFloat CDMainTabBarHeight = 49.f;

@interface CDMainTabBar : UITabBar

@end

@implementation CDMainTabBar

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = [super sizeThatFits:size];
    newSize.height += [CDCommonUtils safeAreaInsets].bottom;
    return newSize;
}

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
