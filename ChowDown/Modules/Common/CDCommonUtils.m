//
//  CDCommonUtils.m
//  ChowDown
//
//  Created by Wu Yongwei on 2024/5/15.
//

#import "CDCommonUtils.h"
#import "CDCommonMacro.h"

@implementation CDCommonUtils

+ (UIWindow *)keyWindow {
    __block UIScene *scene = nil;
    [[[UIApplication sharedApplication] connectedScenes] enumerateObjectsUsingBlock:^(UIScene * _Nonnull obj, BOOL * _Nonnull stop) {
        if (obj.activationState == UISceneActivationStateForegroundActive) {
            scene = obj;
            *stop = YES;
        }
    }];
    if (!scene) {
        scene = [[UIApplication sharedApplication] connectedScenes].allObjects.firstObject;
    }
    UIWindowScene *windowScene = CDSAFE_CAST(scene, UIWindowScene);
    UIWindow *window = nil;
    if (@available(iOS 15.0, *)) {
        window =  windowScene.keyWindow;
    }
    return window ?: windowScene.windows.firstObject;
}

+ (UIEdgeInsets)safeAreaInsets {
    return [self keyWindow].safeAreaInsets;
}

+ (NSString *)currentTimeStr {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

@end
