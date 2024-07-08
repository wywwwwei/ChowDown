//
//  CDMenuManagementModel.m
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import "CDMenuManagementModel.h"

@implementation CDMenuManagementModel

- (NSString *)typeString {
    if (self.type == 0) {
        return @"On sale";
    }
    if (self.type == 1) {
        return @"Stop sale";
    }
    return @"";
}

@end
