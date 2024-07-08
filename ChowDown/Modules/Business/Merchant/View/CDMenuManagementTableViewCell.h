//
//  CDMenuManagementTableViewCell.h
//  ChowDown
//
//  Created by 丢丢立 on 2024/6/20.
//

#import <UIKit/UIKit.h>
#import "CDMenuManagementModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CDMenuManagementTableViewCell : UITableViewCell

@property (nonatomic, strong) CDMenuManagementModel *model;

@property (nonatomic,copy) void(^tuochDeleteEventBlock)(void);

@end

NS_ASSUME_NONNULL_END
