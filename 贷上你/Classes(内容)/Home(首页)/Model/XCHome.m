//
//  XCHome.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/25.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCHome.h"

@implementation XCHome


//+ (NSDictionary *)mj_objectClassInArray{
//
//    return @{
//             @"banners" : @"XCbanner",
//             @"hotProducts" : @"XChotProduct",
//             @"menus" : @"XCmenu"
//             };
//}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value使用[YYEatModel class]或YYEatModel.class或@"YYEatModel"没有区别
    return @{@"banners" : [XCBanner class] , @"hotProducts" : [XCHotProduct class], @"menus" : [XCMenu class] ,@"selfProducts":[XCHotProduct class]};
}



@end
