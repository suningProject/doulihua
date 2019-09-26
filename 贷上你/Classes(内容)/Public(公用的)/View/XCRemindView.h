//
//  XCRemindView.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/26.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCRemindView : UIView
@property(nonatomic,copy) NSString *title;

+ (void)show:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
