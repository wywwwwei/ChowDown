//
//  UIColor+Helper.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/6/22.
//

#import "UIColor+Helper.h"

@implementation UIColor (Helper)

+ (UIColor *)colorWithRGB:(uint32_t)rgb {
    return [self colorWithRGB:rgb alpha:1.0f];
}

+ (UIColor *)colorWithRGB:(uint32_t)rgb alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((rgb & 0xFF0000) >> 16)/255.0 green:((rgb & 0x00FF00) >> 8)/255.0 blue:(rgb & 0x0000FF)/255.0 alpha:alpha];
}

@end
