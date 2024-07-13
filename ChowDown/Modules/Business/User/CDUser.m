//
//  CDUser.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import "CDUser.h"
#import <MJExtension/NSObject+MJKeyValue.h>

NSNotificationName const CDUserProfileUpdateNotification = @"CDUserProfileUpdateNotification";

static CDUser *currentUser = nil;

static NSString *const CDUserKey = @"__CDUserKey__";

@implementation CDUser

+ (CDUser *)currentUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self refreshUserInfo];
    });
    return currentUser;
}

+ (void)refreshUserInfo {
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] dictionaryForKey:CDUserKey];
    if (userInfo) {
        currentUser = [CDUser mj_objectWithKeyValues:userInfo];
    } else {
        currentUser = nil;
    }
}

+ (void)login:(CDUser *)user {
    NSDictionary *userInfo = [user mj_keyValues];
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:CDUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self refreshUserInfo];
}

+ (void)logout {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:CDUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [self refreshUserInfo];
}

+ (void)updateUser:(CDUser *)user {
    if ([user.userId isEqualToString:[self currentUser].userId]) {
        [self login:user];
        [[NSNotificationCenter defaultCenter] postNotificationName:CDUserProfileUpdateNotification object:nil];
    }
}

+ (BOOL)isLogin {
    return [self currentUser] != nil;
}

@end
