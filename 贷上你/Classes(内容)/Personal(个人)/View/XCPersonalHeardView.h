//
//  XCPersonalHeardView.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/20.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^heardClickBlock)(void);

@interface XCPersonalHeardView : UIView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *user;
@property (nonatomic, copy) heardClickBlock heardClick;
- (void)heardClick:(heardClickBlock)block;
@end

NS_ASSUME_NONNULL_END
