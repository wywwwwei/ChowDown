//
//  CDProfileFunctionCell.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDProfileFunctionItem : NSObject

@property (nonatomic, strong) NSString *functionTitle;
@property (nonatomic, strong) NSString *iconUrl;
@property (nonatomic, copy) void(^clickhandler)(void);

@end

@interface CDProfileFunctionCell : UICollectionViewCell

@property (nonatomic, strong) CDProfileFunctionItem *item;

@end

NS_ASSUME_NONNULL_END
