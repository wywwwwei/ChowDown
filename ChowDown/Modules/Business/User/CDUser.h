//
//  CDUser.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

OBJC_EXTERN NSNotificationName const CDUserProfileUpdateNotification;

@interface CDUser : NSObject

@property (nonatomic, strong) NSString *userId; // email id
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *introduction;

+ (CDUser *)currentUser;
+ (void)refreshUserInfo;
+ (BOOL)isLogin;

+ (void)logout;
+ (void)login:(CDUser *)user;
+ (void)updateUser:(CDUser *)user;

@end

NS_ASSUME_NONNULL_END
