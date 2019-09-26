//
//  UIBarButtonItem+Extension.h
//  
//
//  Created by 李林杰 on 15/10/21.
//  Copyright © 2015年 李林杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  自定义带图片的item
 *
 *  @param normalImage      正常状态的图片
 *  @param HeightLightImage 高亮状态图片
 *  @param target           按钮target
 *  @param action        A   按钮点击触发方法
 *
 *  @return UIBarButtonItem
 */
+(instancetype)barBarItemWithNromalImage:(NSString *)normalImage HeightLightImage:(NSString *)HeightLightImage  target:(id) target  action:(SEL)action;

/**
 *  返回固定样式导航条Item
 */
+(instancetype)barBarItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

/**
 *  返回固定返回按钮
 */
+(instancetype)backItemWithTitle:(NSString *)title target:(id)target action:(SEL)action;

@end


