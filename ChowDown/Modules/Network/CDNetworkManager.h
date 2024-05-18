//
//  CDNetworkManager.h
//  ChowDown
//
//  Created by Wu Yongwei on 2024/5/17.
//

#import <UIKit/UIKit.h>
#import "CDApi.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CDDataType) {
    CDDataTypeNone,
    CDDataTypeCache,
    CDDataTypeServer,
};

typedef NS_OPTIONS(NSUInteger, CDRequestDataOptions)
{
    CDRequestDataOptionsCache = 1 << 0,
    CDRequestDataOptionsServer = 1 << 1,
    // cache first
    CDRequestDataOptionsAll = CDRequestDataOptionsCache | CDRequestDataOptionsServer,
};


@interface CDHTTPRequest : NSObject

@property (nonatomic, strong) NSString *host;
@property (nonatomic, strong) NSString *path;

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSDictionary *headers;

@property (nonatomic, strong) NSDictionary *queryParameters;
@property (nonatomic, strong) NSDictionary *bodyParameters;

// Cache Control
@property (nonatomic, assign) CDRequestDataOptions requestOptions;
// default use all parameters
@property (nonatomic, strong) NSArray *cacheKeys;

@end

@interface CDHTTPResponse : NSObject

@property (nonatomic, assign) CDDataType dataType;

@property (nonatomic, strong) id originalResponse;
@property (nonatomic, strong) NSDictionary *response;

@end

typedef void (^CDRequestFailure)(NSError *error);
typedef void (^CDRequestSuccess)(CDHTTPResponse *response);

@interface CDNetworkManager : NSObject

- (void)sendRequest:(CDHTTPRequest *)request
          onSuccess:(CDRequestSuccess)successBlock
             onFail:(CDRequestFailure)failBlock;

@end

NS_ASSUME_NONNULL_END
