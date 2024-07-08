//
//  CDMenuManagementModel.h
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDMenuManagementModel : NSObject
@property (nonatomic, strong) NSString *menuId;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;

// 0 在售  1停售
@property (nonatomic, assign) int type;

@property (nonatomic, strong) NSString * typeString;


@end

NS_ASSUME_NONNULL_END
