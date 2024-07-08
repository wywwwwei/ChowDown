//
//  CDToast.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/8.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDToast : NSObject

+ (void)showToastTitle:(NSString *)title duration:(NSTimeInterval)duration;

@end


NS_ASSUME_NONNULL_END
