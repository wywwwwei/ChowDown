//
//  CDCustomerOrderModel.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDCustomerOrderModel : NSObject

@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *phone;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *time;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSArray *products;

// 0 未派送  1已派送  2未完成  3已完成
@property (nonatomic, assign) int orderType;

@end

NS_ASSUME_NONNULL_END
