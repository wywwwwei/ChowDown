//
//  CDNavigationBar.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDNavigationBar : UIView

@property (readonly) UILabel *titleLabel;
@property (readonly) UIButton *backButton;

- (instancetype)initWithTitle:(nullable NSString *)title;

@end

NS_ASSUME_NONNULL_END
