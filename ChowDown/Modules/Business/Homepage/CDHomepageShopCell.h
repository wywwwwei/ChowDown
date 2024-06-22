//
//  CDHomepageShopCell.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDHomepageShopItem : NSObject

@property (nonatomic, strong) NSString *shopAvatarUrl;
@property (nonatomic, strong) NSString *shopName;
@property (nonatomic, strong) NSString *shopDescription;

@end

@interface CDHomepageShopCell : UICollectionViewCell

@property (nonatomic, strong) CDHomepageShopItem *item;

@end

NS_ASSUME_NONNULL_END
