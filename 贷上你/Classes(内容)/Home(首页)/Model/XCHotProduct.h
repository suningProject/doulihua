//
//  XCHotProduct.h
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/25.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCHotProduct : NSObject
@property(nonatomic,assign)NSInteger productId;
@property(nonatomic,copy) NSString *name;//产品名称
@property(nonatomic,copy) NSString *h5Href;//产品h5落地页
@property(nonatomic,copy) NSString *logo;
@property(nonatomic,copy) NSString *title;//产品标题
@property(nonatomic,copy) NSString *introduce;//产品介绍
@property(nonatomic,copy) NSString *month;//出借期限
@property(nonatomic,copy) NSString *tag;//产品标签
@property(nonatomic,assign) NSInteger orderNum;// 默认顺序，降序排列
@property(nonatomic,assign) NSInteger lowMoney;// 最低额度
@property(nonatomic,assign) NSInteger highMoney;// 最高额度
@property(nonatomic,assign) NSInteger applyCount;//
@property(nonatomic,assign) NSInteger passCount;// 
@end

NS_ASSUME_NONNULL_END
