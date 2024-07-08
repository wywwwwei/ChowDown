//
//  CDSubmitOrderViewController.h
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import <UIKit/UIKit.h>
#import "CDShopDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDSubmitOrderViewController : UIViewController

@property (nonatomic, strong) NSMutableArray<CDShopDetailsModel *> *dataArrays;

@property (nonatomic,copy) void(^tuochPayCompletionBlock)(void);

@end

NS_ASSUME_NONNULL_END
