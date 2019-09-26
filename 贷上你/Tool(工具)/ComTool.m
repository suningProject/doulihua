//
//  ComTool.m
//  CashProject
//
//  Created by 叶义峰 on 2019/3/27.
//  Copyright © 2019 TDD. All rights reserved.
//

#import "ComTool.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation ComTool

+ (BOOL)deptNumInputNumber:(NSString *)str withLength:(NSInteger)length
{
    if (length == 9) {
        if (str.length != length || str.length != 12) {
            return NO;
        }
    }
    if (str.length == 0 || str.length != length) {
        return NO;
    }
    
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

+ (BOOL)regularWithStr:(NSString*)content withLength:(NSInteger)length;
{
    
    if (content.length != length) {
        return NO;
    }
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pattern];
    BOOL isMatch = [pred evaluateWithObject:content];
    return isMatch;
}

#pragma mark - 抖动
+ (void)shakeView:(UIView*)viewToShake
{
    CGFloat t =4.0;
    CGAffineTransform translateRight  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,0.0);
    CGAffineTransform translateLeft =CGAffineTransformTranslate(CGAffineTransformIdentity,-t,0.0);
    viewToShake.transform = translateLeft;
    [UIView animateWithDuration:0.07 delay:0.0 options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat animations:^{
        [UIView setAnimationRepeatCount:2.0];
        viewToShake.transform = translateRight;
    } completion:^(BOOL finished){
        if(finished){
            [UIView animateWithDuration:0.05 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                viewToShake.transform =CGAffineTransformIdentity;
            } completion:NULL];
        }
    }];
}

#pragma mark - 手机号码验证
/*
 电话号码
 移动  134［0-8］ 135 136 137 138 139 150 151 152 158 159 182 183 184 157 187 188 147 178
 联通  130 131 132 155 156 145 185 186 176
 电信  133 153 177 180 181 189
 
 上网卡专属号段
 移动 147
 联通 145
 
 虚拟运营商专属号段
 移动 1705
 联通 1709
 电信 170 1700
 
 卫星通信 1349
 */
+ (BOOL)isValidateMobile:(NSString *)phone
{
    NSString *mobile = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11){
        return NO;
    }
    else{
        /**
         * 移动号段正则表达式，新增1703、1705、1706
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(170[3,5,6])\\d{7}$";
        /**
         * 联通号段正则表达式，新增1704、1707、1708、1709，171
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(17[1,6])|(18[5,6]))\\d{8}|(170[4,7-9])\\d{7}$";
        /**
         * 电信号段正则表达式,新增1700、1701、1702、173
         */
        NSString *CT_NUM = @"^((133)|(153)|(17[3,7])|(18[0,1,9]))\\d{8}|(170[0-2])\\d{7}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}

#pragma mark - 隐藏手机号中间四位号码
+ (NSString *)hideCenterPhoneNumber:(NSString *)mobile
{
    NSString *numberString = [mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return numberString;
}

#pragma mark 隐藏银行卡号中间的数字，前6后4 剩下＊
+ (NSString*)bankCardNumSecret:(NSString*)cardNum
{
    for (int i = 6 ; i < cardNum.length - 4; i ++) {
        cardNum = [cardNum stringByReplacingCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
    }
    return cardNum;
}

#pragma mark - 随机生成一个颜色
+ (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

#pragma mark - 获取UUID
+ (NSString *)getDeviceIdentifierForVendor
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

#pragma mark - 获取版本号
+ (NSString *)getVersionStr
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

#pragma mark - 判断当前是否有网络
+ (BOOL)connectedToNetwork
{
    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
    struct sockaddr_storage zeroAddress;
    
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.ss_len = sizeof(zeroAddress);
    zeroAddress.ss_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    //获得连接的标志
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    //如果不能获取连接标志，则不能连接网络，直接返回
    if (!didRetrieveFlags)
    {
        return NO;
    }
    //根据获得的连接标志进行判断
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection) ? YES : NO;
}

#pragma mark - 设备ip
+ (NSString *)getDeviceIPAdress
{
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    // 0 表示获取成功
    if (success == 0)
    {
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    freeifaddrs(interfaces);
    //    NSLog(@"手机的IP是：%@", address);
    return address;
}

#pragma mark - 判读字符串是否空值
+ (BOOL)isEmptyString:(NSString *)stringValue {
    if (stringValue == nil || stringValue == NULL) {
        return YES;
    }
    if ([stringValue isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([stringValue isEqual:[NSNull null]]) {
        return YES;
    }
    if ([stringValue isEqualToString:@""]) {
        return YES;
    }
    if ([[stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


#pragma mark - 判读id否空值
+ (BOOL)isEmptyObject:(id)object;
{
    if (object == nil || object == NULL) {
        return YES;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([object isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}
#pragma mark - 判断输入的字符串是否全为数字
+ (BOOL)deptNumInputShouldNumber:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

// 首位 不为 0 的数字
+(BOOL)evaluateNum:(NSString *)string
{
    NSString *Unum = @"(^\\+?[1-9][0-9]*$)";
    NSPredicate *prd = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Unum];
    return [prd evaluateWithObject:self];
}

#pragma mark - 判断输入的字符串是否全为数字和 .
+ (BOOL)deptNumAndPointInput:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"^[0-9]+([.]{0,1}[0-9]+){0,1}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

#pragma mark - 只能输入数字和字母
+ (BOOL)justNumberOrletter:(NSString *)str
{
    if (str.length == 0) {
        return NO;
    }
    NSString *regex = @"[A-Za-z0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}


#pragma mark - 6-18位且同时包含数字和字母
+ (BOOL)judgePassWordLegal:(NSString *)pass
{
    /*
     分开来注释一下：
     ^ 匹配一行的开头位置
     (?![0-9]+$) 预测该位置后面不全是数字
     (?![a-zA-Z]+$) 预测该位置后面不全是字母
     [0-9A-Za-z] {6,18} 由6-18位数字或这字母组成
     $ 匹配行结尾位置
     */
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于8位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

#pragma mark - 获取字符串 Size
+ (CGSize)getSizeWithString:(NSString *)str withSize:(CGSize)aSize withFont:(UIFont *)font
{
    CGSize size = [str boundingRectWithSize:aSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
    return size;
}

/*
 //获取字符串的宽度
 -(float) widthForString:(NSString *)value fontSize:(float)fontSize andHeight:(float)height
 {
 CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, height) lineBreakMode:NSLineBreakByWordWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
 return sizeToFit.width;
 }
 //获得字符串的高度
 -(float) heightForString:(NSString *)value fontSize:(float)fontSize andWidth:(float)width
 {
 CGSize sizeToFit = [value sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];//此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
 return sizeToFit.height;
 }
 ---------------------
 作者：菜鸟and小白
 来源：CSDN
 原文：https://blog.csdn.net/fanqingtulv/article/details/51023265
 版权声明：本文为博主原创文章，转载请附上博文链接！
 */

#pragma mark - 获取的时间戳转化为正常格式
+ (NSString *)getTimeWithString:(NSString *)string
{
    // timeStampString 是服务器返回的13位时间戳
    NSString *timeStampString = string;
    // iOS 生成的时间戳是10位
    NSTimeInterval interval = [timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [formatter stringFromDate: date];
    return dateString;
}


#pragma mark - 获取的 string 转化为时间戳
+ (NSString *)getIntervalWithString:(NSString *)string
{
    //    NSString *dateStr = @"2012-5-4 4:34:23";
    //创建一个日期格式化器
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    //指定转date得日期格式化形式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate *dates = [formatter dateFromString:string];
    NSString *intervalString = [NSString stringWithFormat:@"%ld", (long)[dates timeIntervalSince1970]*1000];
    
    return intervalString;
}

#pragma mark - 重新给image一个尺寸
+ (UIImage *)imageResize:(UIImage *)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr andResizeTo:(CGSize)newSize
{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLStr]];
    NSData *newImageData = imageData;
    //压缩图片data大小
    newImageData = UIImageJPEGRepresentation([UIImage imageWithData:newImageData scale:1.0], 1.0f);
    UIImage *image = [UIImage imageWithData:newImageData];
    
    // 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
    //    CGSize newSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,(NSInteger)newSize.width, (NSInteger)newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (void)FirstInstall
{
    //   使用NSUserDefaults来判断程序是否第一次启动
//    NSUserDefaults *TimeOfBootCount = [NSUserDefaults standardUserDefaults];
//    if (![TimeOfBootCount valueForKey:installTime]) {
//        [TimeOfBootCount setValue:@"first" forKey:installTime];
//        NSLog(@"首次安装");
//    }else{
//        NSLog(@"再次安装");
//        [TimeOfBootCount setValue:@"again" forKey:installTime];
//    }
//    [TimeOfBootCount synchronize];
}

// 判断用户是否首次安装
+ (BOOL)isFirstInstall;
{
//    NSString * time = [[NSUserDefaults standardUserDefaults] objectForKey:installTime];
//    if ([time isEqualToString:@"first"]) {
//        return YES;
//    }
//    else {
//        return NO;
//    }
    return YES;
}
@end
