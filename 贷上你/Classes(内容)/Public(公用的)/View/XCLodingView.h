//
//  XCLodingView.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/1.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCLodingView : UIView
+ (void) show;
+ (instancetype)shareInstance;

- (void)hidden;
@end

NS_ASSUME_NONNULL_END
