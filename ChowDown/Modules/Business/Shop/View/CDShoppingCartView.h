//
//  CDShoppingCartView.h
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/19.
//

#import <UIKit/UIKit.h>
#import "CDShopDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDShoppingCartView : UIView

@property (nonatomic, strong) NSMutableArray<CDShopDetailsModel *> *dataArrays;

@property (nonatomic, strong) NSMutableArray<CDShopDetailsModel *> *listArrays;

@property (nonatomic,copy) void(^tuochShoppingBlock)(void);

@property (nonatomic,copy) void(^tuochCloseBlock)(void);

@property (nonatomic,copy) void(^tuochJumpBlock)(void);

// 计算价格 更新UI
- (void)calculatePrice;

// 清空购物车
- (void)touchClearShoppingButttonEvent;

@end

NS_ASSUME_NONNULL_END
