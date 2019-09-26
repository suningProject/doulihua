//
//  XCTabBarController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCTabBarController.h"
#import "XCHomeController.h"
#import "XCLoanController.h"
#import "XCMoneyController.h"
#import "XCPersonalController.h"


@interface XCTabBarController ()<UIAlertViewDelegate>
@property (nonatomic,copy)NSString *url;
@end

@implementation XCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildControllers];
    [self versionUpdate];
    
}

// 判断是否需要更新
- (void)versionUpdate{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    CFShow(CFBridgingRetain(info));
    double appVersion = [[info objectForKey:@"CFBundleShortVersionString"]doubleValue];
    
    NSDictionary *dic = @{@"category":@"iosVersion"};
    [XCNetworking post:@"/sysconstant/getconstants" params:dic  success:^(id  _Nonnull responseObj) {
        NSDictionary *data = [NSJSONSerialization JSONObjectWithData:responseObj
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        
       
        if ([dic[@"status"] intValue] == 0) {
           
            NSMutableArray * array = (NSMutableArray*)data[@"data"];
            if (array.count!= 0) {
                NSDictionary *info =  data[@"data"][0];
                
                self.url = [info[@"value"] stringByReplacingOccurrencesOfString:@"'\'" withString:@""];
                if(appVersion<[info[@"show"] floatValue]){
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"发现新版本" message:@"是否更新" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
                    [alert show];
                }
            }
        }else{
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.url]];
    }
}

- (void)setupChildControllers{
    XCHomeController *home = [[XCHomeController alloc]init];
//    home.title = @"51贷款王";
    [self addChildVCWith:home title:@"首页" nmImgName:@"tab_icon_home_n" selImageName:@"tab_icon_home_s"];
    XCLoanController *Loan = [[XCLoanController alloc] init];
    Loan.title = @"贷款大全";
    [self addChildVCWith:Loan title:@"贷款大全" nmImgName:@"tab_icon_loan_n" selImageName:@"tab_icon_loan_s"];
//    XCMoneyController *money = [[XCMoneyController alloc] init];
//    money.title = @"必下款";
//    [self addChildVCWith:money title:@"必下款" nmImgName:@"tab_icon_hot_n" selImageName:@"tab_icon_hot_s"];
    XCPersonalController *personal = [[XCPersonalController alloc] init];
    [self addChildVCWith:personal title:@"个人" nmImgName:@"tab_icon_me_n" selImageName:@"tab_icon_me_s"];
}

- (void) addChildVCWith:(UIViewController *)vc title:(NSString *)title nmImgName:(NSString *)nmlImageName selImageName:(NSString *)selImageName{
    
    XCNavigationController *nvc =[[XCNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nvc];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       colorFromRGB(0x9195A0), UITextAttributeTextColor,
                                                       nil] forState:UIControlStateNormal];
//     R 255  G 137  B  64
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       CREATE_RGB_COLOR(255, 137, 64), UITextAttributeTextColor,
                                                       nil] forState:UIControlStateSelected];
    nvc.tabBarItem.title = title;
    UIImage *nmlImage = [UIImage imageNamed:nmlImageName];
    nmlImage = [nmlImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nvc.tabBarItem.image = nmlImage;
    
    UIImage *selImag = [UIImage imageNamed:selImageName];
    selImag = [selImag imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nvc.tabBarItem.selectedImage = selImag;
    
}

@end
