//
//  XCLoan.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/26.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCHotProduct.h"
NS_ASSUME_NONNULL_BEGIN

@interface XCLoan : NSObject
@property(nonatomic,strong)NSMutableArray<XCHotProduct *> *list;
@end

NS_ASSUME_NONNULL_END
