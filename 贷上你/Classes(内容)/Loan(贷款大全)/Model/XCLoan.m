//
//  XCLoan.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/26.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCLoan.h"

@implementation XCLoan
+ (NSDictionary *)modelContainerPropertyGenericClass {
     return @{ @"list" : [XCHotProduct class]};
}
@end
