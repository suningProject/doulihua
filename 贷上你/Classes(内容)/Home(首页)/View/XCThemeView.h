//
//  XCThemeView.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/7/16.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^themeClickBlock)(void);
@interface XCThemeView : UIView
@property(strong, nonatomic)UILabel *top;
@property(strong, nonatomic)UILabel *money;
@property(strong, nonatomic)UILabel *done;
@property (nonatomic, copy) themeClickBlock themeClick;
- (void)themeClick:(themeClickBlock)block;
@end

NS_ASSUME_NONNULL_END
