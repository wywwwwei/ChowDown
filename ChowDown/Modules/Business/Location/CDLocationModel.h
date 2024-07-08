//
//  CDLocationModel.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/7/9.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDLocationModel : NSObject

@property (nonatomic, strong) NSString *annotation;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) CLPlacemark *placemark;

@end

NS_ASSUME_NONNULL_END
