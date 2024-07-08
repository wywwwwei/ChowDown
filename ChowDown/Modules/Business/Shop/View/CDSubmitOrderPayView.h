//
//  CDSubmitOrderPayView.h
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import <UIKit/UIKit.h>
#import "CDShopDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDSubmitOrderPayView : UIView

@property (nonatomic, strong) NSMutableArray<CDShopDetailsModel *> *dataArrays;

@property (nonatomic,copy) void(^tuochPayBlock)(void);

// 计算价格 更新UI
- (void)calculatePrice;

@end

NS_ASSUME_NONNULL_END
