//
//  CDProfileFunctionItem.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDProfileFunctionItem : NSObject

@property (nonatomic, strong) NSString *functionTitle;

@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *iconUrl;

@property (nonatomic, copy) void(^clickHandler)(void);

@end

NS_ASSUME_NONNULL_END
