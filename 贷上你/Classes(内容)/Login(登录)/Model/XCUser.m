//
//  XCUser.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/25.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCUser.h"

@implementation XCUser

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

static XCUser *_shareManager;
+ (instancetype)User {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[XCUser alloc] init];
    }); 
    return _shareManager;
}

@end
