//
//  ComTool.h
//  CashProject
//
//  Created by 叶义峰 on 2019/3/27.
//  Copyright © 2019 TDD. All rights reserved.
//

#import <Foundation/Foundation.h>
// 常用工具类
NS_ASSUME_NONNULL_BEGIN

@interface ComTool : NSObject
@property(nonatomic,strong) UIView * superView;

// 纯数字的长度
+ (BOOL)deptNumInputNumber:(NSString *)str withLength:(NSInteger)length;

// 验证证件类型的长度 字母 + 数字
+ (BOOL)regularWithStr:(NSString*)content withLength:(NSInteger)length;
#pragma mark - 抖动
+ (void)shakeView:(UIView*)viewToShake;

//弹出弹窗 黑底白字(仅文字做提示用)
+ (void)showTextHud:(UIView *)showView title:(NSString *)title;
//弹窗 旋转+白字 黑底
+ (void)showAnmationAndText:(UIView *)showView title:(NSString *)title;

#pragma mark - 手机号码验证
+ (BOOL)isValidateMobile:(NSString *)phone;

#pragma mark - 隐藏手机号中间四位号码
+ (NSString *)hideCenterPhoneNumber:(NSString *)mobile;
#pragma mark 隐藏银行卡号中间的数字，前6后4 剩下＊
+ (NSString*)bankCardNumSecret:(NSString*)cardNum;


#pragma mark - 随机生成一个颜色
+ (UIColor *)randomColor;

#pragma mark - 获取UUID
+ (NSString *)getDeviceIdentifierForVendor;

#pragma mark - 设备IP
+ (NSString *)getDeviceIPAdress;

#pragma mark - 获取版本号
+ (NSString *)getVersionStr;

#pragma mark - 判断当前是否有网络
+ (BOOL)connectedToNetwork;

#pragma mark - 判读字符串是否空值
+ (BOOL)isEmptyString:(NSString *)stringValue;

#pragma mark - 判读id否空值
+ (BOOL)isEmptyObject:(id)object;

#pragma mark - 判断输入的字符串是否全为数字
+ (BOOL)deptNumInputShouldNumber:(NSString *)str;
#pragma mark - 判断首位不为0
+(BOOL)evaluateNum:(NSString *)string;
#pragma mark 判断输入的字符串是否全为数字和 .
+ (BOOL)deptNumAndPointInput:(NSString *)str;
#pragma mark - 只能输入数字和字母
+ (BOOL)justNumberOrletter:(NSString *)str;
#pragma mark 6-18位且同时包含数字和字母
+ (BOOL)judgePassWordLegal:(NSString *)pass;

#pragma mark - 获取字符串 Size
+ (CGSize)getSizeWithString:(NSString *)str withSize:(CGSize)aSize withFont:(UIFont *)font;

#pragma mark - 获取的时间戳转化为正常格式
+ (NSString *)getTimeWithString:(NSString *)string;

#pragma mark - 获取的 string 转化为时间戳
+ (NSString *)getIntervalWithString:(NSString *)string;

#pragma mark - 重新给image一个尺寸
+ (UIImage *)imageResize:(UIImage *)img andResizeTo:(CGSize)newSize;
+ (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr andResizeTo:(CGSize)newSize;

// 用户首次安装时
+ (void)FirstInstall;

// 判断用户是否首次安装
+ (BOOL)isFirstInstall;
@end

NS_ASSUME_NONNULL_END
