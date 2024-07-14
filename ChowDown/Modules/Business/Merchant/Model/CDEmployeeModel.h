//
//  CDEmployeeModel.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CDEmployeeStatus) {
    CDEmployeeStatusOnShift,    // 正在工作
    CDEmployeeStatusOnBreak,    // 已下班
    CDEmployeeStatusTerminated, // 已离职
};

@interface CDEmployeeModel : NSObject

@property (nonatomic, strong) NSString *employeeId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) CDEmployeeStatus status;

@end

NS_ASSUME_NONNULL_END
