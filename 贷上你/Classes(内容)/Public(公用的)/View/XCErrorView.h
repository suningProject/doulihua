//
//  XCErrorView.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/10.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCErrorView : UIView
typedef void (^clickBlock)(void);
@property (nonatomic, copy) clickBlock clickBlock;

-(void)hidden;
- (void)clickBlock:(clickBlock)block;
+ (instancetype)shareInstance;
@end

NS_ASSUME_NONNULL_END
