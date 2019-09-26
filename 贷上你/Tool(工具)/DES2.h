//
//  DES2.h
//  解密
//
//  Created by Kunlin Lin on 2019/7/9.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DES2 : NSObject
+ (NSString*)encrypt:(NSString*)plainText;
+ (NSString*)decrypt:(NSString*)encryptText;
@end

NS_ASSUME_NONNULL_END
