//
//  XCHelp.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/27.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCHelp : NSObject
@property (nonatomic, copy)NSString *question;
@property (nonatomic, copy)NSString *answer;
@property (nonatomic, assign)NSUInteger status;
@property (nonatomic, assign)BOOL isOpen;
@property (nonatomic, assign)CGFloat height;


+(NSMutableArray *)data;
@end

NS_ASSUME_NONNULL_END
