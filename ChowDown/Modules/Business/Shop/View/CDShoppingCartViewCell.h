//
//  CDShoppingCartViewCell.h
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/19.
//

#import <UIKit/UIKit.h>
#import "CDShopDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDShoppingCartViewCell : UITableViewCell

@property (nonatomic, strong) CDShopDetailsModel *model;

@property (nonatomic,copy) void(^tuochAddOrDecreaseBlock)(void);

@end

NS_ASSUME_NONNULL_END
