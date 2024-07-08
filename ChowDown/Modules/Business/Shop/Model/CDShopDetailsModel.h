//
//  CDShopDetailsModel.h
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDShopDetailsModel : NSObject

@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, strong) NSString *sales;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) int payNumber;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
