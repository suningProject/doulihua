//
//  UIView+Extension.h
//  
//
//  Created by 李林杰 on 15-3-16.
//  Copyright (c) 2015年 李林杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 *  UIView的尺寸
 */
@property(nonatomic,assign)CGSize size;

/**
 *  获取或者更改控件的宽度
 */
@property(nonatomic,assign)CGFloat w;

/**
 *  获取或者更改控件的高度
 */
@property(nonatomic,assign)CGFloat h;

/**
 *  获取或者更改控件的x坐标
 */
@property(nonatomic,assign)CGFloat x;

/**
 *  获取或者更改控件的y坐标
 */
@property(nonatomic,assign)CGFloat y;
@end



@interface UILabel (Extension)

+ (instancetype) labelWithText:(NSString *)text
                    textClolor:(UIColor *)color
                          font:(CGFloat)font
                         frame:(CGRect)frame
                   isAggravation:(BOOL)isAggravation;
/**
 创建Label
 
 @param text 文本
 @param color 颜色
 @param font 大小
 @param frame 位置
 @return UILabel
 */
+ (instancetype)  labelWithText:(NSString *)text 
                     textClolor:(UIColor *)color 
                           font:(CGFloat)font 
                          frame:(CGRect)frame;

@end


@interface UIButton (Extension)

/**
 创建UIButton
 
 @param text 文本
 @param font 文本大小
 @param ntColor 默认文字颜色
 @param htColor 选中文字颜色
 @param frame frame
 @return UIButton
 */
+ (instancetype) buttonWithText:(NSString *)text font:(CGFloat) font nmlTitleColor:(UIColor *)ntColor hightTitleColor:(UIColor *)htColor frame:(CGRect) frame;



/**
 创建UIButton带点击事件
 
 @param text 文本
 @param font 文本大小
 @param ntColor 默认文字颜色
 @param htColor 选中文字颜色
 @param frame frame
 @param target 代理
 @param action 点击事件
 @return UIButton
 */
+ (instancetype) buttonWithText:(NSString *)text font:(CGFloat) font nmlTitleColor:(UIColor *)ntColor hightTitleColor:(UIColor *)htColor frame:(CGRect) frame target:(id)target  action:(SEL)action;

@end

@interface UITextField (Extension)

/**
 创建UITextField
 
 @param placeholder 默认文本
 @param tColor 文本颜色
 @param style 边框样式
 @param frame  frame
 @return UITextField
 */
+ (instancetype) textFieldWithPlaceholder:(NSString *)placeholder textColor:(UIColor *)tColor borderStyle:(UITextBorderStyle )style frame:(CGRect)frame ;


@end
