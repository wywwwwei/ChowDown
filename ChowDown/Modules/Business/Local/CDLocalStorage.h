//
//  CDLocalStorage.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/14.
//

#import <Foundation/Foundation.h>
#import "CDOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDLocalStorage : NSObject

+ (instancetype)sharedInstance;

- (NSString *)registerUserEmail:(NSString *)email password:(NSString *)password;
- (NSString *)loginUserEmail:(NSString *)email password:(NSString *)password;

- (void)addOrder:(CDBaseOrderModel *)order;
- (NSArray<CDBaseOrderModel *> *)hitoryOrders;

@end

NS_ASSUME_NONNULL_END
