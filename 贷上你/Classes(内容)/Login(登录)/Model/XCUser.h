//
//  XCUser.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/25.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCUser : NSObject
@property (nonatomic,assign)NSUInteger acceptHighAccrual;
@property (nonatomic,copy) NSString *appVersion;
@property (nonatomic,assign) NSUInteger createTime;
@property (nonatomic,copy) NSString *loginPwd;
@property (nonatomic,assign) NSUInteger phone;
@property (nonatomic,assign) NSUInteger status;
@property (nonatomic,assign) NSUInteger userId;
@property (nonatomic,copy) NSString *cardId;
@property (nonatomic,copy) NSString *realName;
+ (instancetype)User;

@end

NS_ASSUME_NONNULL_END
