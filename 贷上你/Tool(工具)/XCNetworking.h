//
//  XCNetworking.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/24.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCNetworking : NSObject
//
+ (void)post:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError *error))failure;

// 
+ (void)get:(NSString *)url
      params:(NSDictionary *)params
     success:(void (^)(id responseObj))success
     failure:(void (^)(NSError *error))failure;

// 是否加密
+ (void)encryption:(void (^)(NSString *key)) success;

// 获取秘钥
+ (void)key:(void (^)(NSString *key)) success;

// 获取电话
+ (void)phone:(void (^)(NSString *key)) success;

@end

NS_ASSUME_NONNULL_END
