//
//  CDSettingsModel.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDSettingsModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, copy) void(^handler)(void);

@end

NS_ASSUME_NONNULL_END
