//
//  CDOrderModel.h
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDOrderModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *orderCode;

// 0 未派送  1已派送  2未完成  3已完成
@property (nonatomic, assign) int orderType;

@property (nonatomic, strong) NSString * orderTypeString;

@property (nonatomic, strong) NSString * psString;

@property (nonatomic, strong) NSString * wcString;

@end

NS_ASSUME_NONNULL_END
