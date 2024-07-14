//
//  CDLocalStorage.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/14.
//

#import "CDLocalStorage.h"
#import "CDUser.h"
#import "NSString+Secure.h"
#import <MJExtension/NSObject+MJKeyValue.h>

static NSString *const CDAllUserKey = @"CDAllUserKey";
static NSString *const CDAllUserPwdKey = @"CDAllUserPwdKey";

@interface CDLocalStorage ()

@end

@implementation CDLocalStorage

+ (instancetype)sharedInstance {
    static CDLocalStorage *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)registerUserEmail:(NSString *)email password:(NSString *)password {
    if (email.length <= 0 || password.length <= 0) {
        return @"Invalid email or password";
    }
    NSMutableArray *allUsers = [[[NSUserDefaults standardUserDefaults] arrayForKey:CDAllUserKey] mutableCopy] ?: [NSMutableArray array];
    for (NSDictionary *userInfo in allUsers) {
        CDUser *user = [CDUser mj_objectWithKeyValues:userInfo];
        if ([user.userId isEqualToString:email]) {
            return @"The current email has been registered";
        }
    }
    CDUser *user = [[CDUser alloc] init];
    user.userId = email;
    NSInteger seq = floor(CACurrentMediaTime());
    user.nickname = [@"user_" stringByAppendingFormat:@"%ld", seq % 100000];
    user.avatarUrl = @"https://media.newyorker.com/photos/5909743dc14b3c606c108588/master/pass/160229_r27717.jpg";
    [allUsers addObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:[CDUser mj_keyValuesArrayWithObjectArray:allUsers] forKey:CDAllUserKey];
    
    NSMutableDictionary *pwdMap = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] dictionaryForKey:CDAllUserPwdKey]];
    pwdMap[user.userId] = password.sha256String;
    [[NSUserDefaults standardUserDefaults] setObject:pwdMap forKey:CDAllUserPwdKey];

    [[NSUserDefaults standardUserDefaults] synchronize];
    return nil;
}

- (NSString *)loginUserEmail:(NSString *)email password:(NSString *)password {
    if (email.length <= 0 || password.length <= 0) {
        return @"Invalid email or password";
    }
    NSArray *allUsers = [[NSUserDefaults standardUserDefaults] arrayForKey:CDAllUserKey];
    for (NSDictionary *userInfo in allUsers) {
        CDUser *user = [CDUser mj_objectWithKeyValues:userInfo];
        if ([user.userId isEqualToString:email]) {
            NSDictionary *pwdMap = [[NSUserDefaults standardUserDefaults] dictionaryForKey:CDAllUserPwdKey];
            if ([password.sha256String isEqualToString:pwdMap[email]]) {
                [CDUser login:user];
                return nil;
            }
            return @"Incorrect password";
        }
    }
    return @"The user does not exist";
}

@end
