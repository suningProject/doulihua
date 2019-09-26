//
//  XCBanner.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/25.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCBanner : NSObject
@property(nonatomic,assign)NSInteger productId;
@property(nonatomic,assign)NSInteger *bannerId;
@property(nonatomic,copy) NSString *bannerName;
@property(nonatomic,copy) NSString *picHref;//图片连接
@property(nonatomic,copy) NSString *pageHref;//静态页面配置地址
@end



NS_ASSUME_NONNULL_END
