//
//  XCHome.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/25.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XCBanner.h"
#import "XCHotProduct.h"
#import "XCMenu.h"




@interface XCHome : NSObject
@property(nonatomic,strong)NSMutableArray<XCBanner *> *banners;
@property(nonatomic,strong)NSMutableArray<XCHotProduct *> *hotProducts;
@property(nonatomic,strong)NSMutableArray<XCMenu *> *menus;
@property(nonatomic,strong)XCHotProduct *selfProduct;
@property(nonatomic,strong)XCHotProduct *todayRecommendProduct;
@property(nonatomic,strong)NSMutableArray<XCHotProduct *> *selfProducts;
@property(nonatomic,copy)NSString *selfTitle;

@end


