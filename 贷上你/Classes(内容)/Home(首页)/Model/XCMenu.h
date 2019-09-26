//
//  XCMenu.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/25.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCMenu : NSObject
@property(nonatomic,assign)NSInteger productId;
@property(nonatomic,copy)NSString *categoryName;
@property(nonatomic,copy) NSString *categoryPic;
@property(nonatomic,copy) NSString *menuHref;
@property(nonatomic,copy) NSString *order;
@end

NS_ASSUME_NONNULL_END
