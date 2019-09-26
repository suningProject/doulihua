//
//  XCWebViewController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/24.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCWebViewController.h"
#import <WebKit/WebKit.h>
#import "DKProgressLayer.h"
#import "UIWebView+DKProgress.h"
@interface XCWebViewController ()

@property (nonatomic, strong) WKWebView *myWebView;

@end

@implementation XCWebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0,screenWidth, (isIPhone6plus || isIPhone6)? (screenHeight-navigationBarHeight-22):(screenHeight-navigationBarHeight))];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    [self.view addSubview:webView];
    
    webView.dk_progressLayer = [[DKProgressLayer alloc] initWithFrame:CGRectMake(0, 40, DK_DEVICE_WIDTH, 2)];
    webView.dk_progressLayer.progressColor = colorFromRGB(0x4d75fd);
    webView.dk_progressLayer.progressStyle = DKProgressStyle_Noraml;
    [self.navigationController.navigationBar.layer addSublayer:webView.dk_progressLayer];
    
    [self joinPo];
}

- (void) viewWillDisappear:(BOOL)animated{
    [self cleanCacheAndCookie];
}

- (void)cleanCacheAndCookie{
    
//    //清除cookies
//    NSHTTPCookie *cookie;
//    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (cookie in [storage cookies]){
//        [storage deleteCookie:cookie];
//    }
    
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
    
}


// 统计pv
- (void)joinPo{
    XCUser *get = [MNCacheClass mn_getSaveModelWithkey:@"XCUser" modelClass:[XCUser class]];
    NSDictionary *dic = @{@"userId":[NSNumber numberWithInteger:get.userId],
                          @"productId":[NSNumber numberWithInteger:self.productId],
                          };
    [XCNetworking post:@"/product/userjoinproduct" params:dic  success:^(id  _Nonnull responseObj) {
    } failure:^(NSError * _Nonnull error) {
    }];
}

@end
