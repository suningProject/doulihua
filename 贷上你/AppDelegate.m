//
//  AppDelegate.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "AppDelegate.h"
#import "XCTabBarController.h"
#import "Reachability.h"
#import "AFNetworking.h"

#import "LaunchIntroductionView.h" // 启动界面


@interface AppDelegate ()

@end

@implementation AppDelegate

static NSString *const kAppVersion = @"appVersion";



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UINavigationBar appearance] setBarTintColor:CREATE_RGB_COLOR(255, 137, 64)];
//    
   [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

//  1. 获取秘钥
    [XCNetworking key:^(NSString * _Nonnull key) {
        [[NSUserDefaults standardUserDefaults]setObject:key forKey:@"key"];
    }];
    
//  2 .是否加密
    [XCNetworking encryption:^(NSString * _Nonnull key) {
        [[NSUserDefaults standardUserDefaults]setObject:key forKey:@"encryption"];
    }];
    
    [NSThread sleepForTimeInterval:1];
     [self setRootVc]; // 设置根视图控制器

    [self.window makeKeyWindow];
    
    [self addReachabilityManager];
 
    return YES;
}

#pragma mark  引导页通知
- (void)changeAdVC
{
    [self setRootVc];
}

#pragma mark - 设置根视图控制器
- (void)setRootVc
{
    XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
    if (get.userId) {
        self.window.rootViewController = [[XCTabBarController alloc] init];
    }else{
        self.window.rootViewController = [[XCLoginController alloc] init];
    }
}
#pragma mark - 判断是使用该项目
- (BOOL)isFirstLauch
{
    //获取当前版本号
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentAppVersion = infoDic[@"CFBundleShortVersionString"];
    //获取上次启动应用保存的appVersion
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:kAppVersion];
    //App首次运行
    if (version == nil || ![version isEqualToString:currentAppVersion]) {
        [[NSUserDefaults standardUserDefaults] setObject:currentAppVersion forKey:kAppVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }else{
        return NO;
    }
}

- (void)afNetworkStatusChanged{
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
  
}

- (void)addReachabilityManager {
    AFNetworkReachabilityManager *afNetworkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    //       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(afNetworkStatusChanged) name:AFNetworkingReachabilityDidChangeNotification object:nil];//这个可以放在需要侦听的页面
    [afNetworkReachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"网络不通：%@",@(status) );
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"网络通过WIFI连接：%@",@(status));
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"网络通过无线连接：%@",@(status) );
                break;
            }
            default:
                break;
        }

        NSLog(@"网络状态数字返回：%@",@(status));
        NSLog(@"网络状态返回: %@", AFStringFromNetworkReachabilityStatus(status));
        NSLog(@"isReachable: %@",@([AFNetworkReachabilityManager sharedManager].isReachable));
        NSLog(@"isReachableViaWWAN: %@",@([AFNetworkReachabilityManager sharedManager].isReachableViaWWAN));
        NSLog(@"isReachableViaWiFi: %@",@([AFNetworkReachabilityManager sharedManager].isReachableViaWiFi));
    }];
    
    [afNetworkReachabilityManager startMonitoring];  //开启网络监视器；
}

@end
