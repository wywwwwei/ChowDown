//
//  CDOrderModel.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDOrderModel.h"

@implementation CDOrderModel
// 0 未派送  1已派送  2未完成  3已完成
- (NSString *)orderTypeString {
    if (self.orderType == 0) {
        return @"undelivered";
    }
    if (self.orderType == 1) {
        return @"Sent";
    }
    if (self.orderType == 2) {
        return @"uncompleted";
    }
    if (self.orderType == 3) {
        return @"completed";
    }
    return @"";
}

- (NSString *)psString {
    if (self.orderType == 0) {
        return @"Hand out";
    }
    if (self.orderType == 1) {
        return @"Sent";
    }
    if (self.orderType == 2) {
        return @"Sent";
    }
    if (self.orderType == 3) {
        return @"Sent";
    }
    return @"";
}

- (NSString *)wcString {
    if (self.orderType == 0) {
        return @"Complete";
    }
    if (self.orderType == 1) {
        return @"Complete";
    }
    if (self.orderType == 2) {
        return @"Complete";
    }
    if (self.orderType == 3) {
        return @"Completed";
    }
    return @"";
}

@end
