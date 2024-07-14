//
//  NSString+Secure.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/14.
//

#import "NSString+Secure.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Secure)

- (NSString *)sha256String {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(cStr, (CC_LONG)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return [hash copy];
}

@end
