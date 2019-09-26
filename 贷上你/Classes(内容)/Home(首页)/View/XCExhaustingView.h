//
//  XCExhaustingView.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/23.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^themeClickBlock)(void);
@interface XCExhaustingView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *bg;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *right;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tags;
@property (weak, nonatomic) IBOutlet UILabel *money;
+ (instancetype) ExhaustingView;
@property (nonatomic, copy) themeClickBlock themeClick;
- (void)themeClick:(themeClickBlock)block;
@end

NS_ASSUME_NONNULL_END
