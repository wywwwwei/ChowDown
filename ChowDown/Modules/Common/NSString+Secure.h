//
//  NSString+Secure.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Secure)

- (NSString *)sha256String;

@end

NS_ASSUME_NONNULL_END
