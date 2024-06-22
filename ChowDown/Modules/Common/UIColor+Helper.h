//
//  UIColor+Helper.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Helper)

+ (UIColor *)colorWithRGB:(uint32_t)rgb;
+ (UIColor *)colorWithRGB:(uint32_t)rgb alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
