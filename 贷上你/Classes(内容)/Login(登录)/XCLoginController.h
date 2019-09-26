//
//  XCLoginController.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/21.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^backBlock)(void);
typedef void (^loginBlock)(void);
@interface XCLoginController : UIViewController
@property (nonatomic, copy) backBlock backBlock;
@property (nonatomic, copy) loginBlock loginBlock;
- (void)backBlock:(backBlock)block;
- (void)loginBlock:(loginBlock)block;
@end

NS_ASSUME_NONNULL_END
