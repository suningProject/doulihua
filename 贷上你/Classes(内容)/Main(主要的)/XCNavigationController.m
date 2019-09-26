//
//  XCNavigationController.m
//  贷上你
//
//  Created by Kunlin Lin on 2019/6/19.
//  Copyright © 2019 XCHD. All rights reserved.
//

#import "XCNavigationController.h"

@interface XCNavigationController ()

@end

@implementation XCNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    
    UINavigationBar *navBar=  [UINavigationBar appearance];
    UIFont *font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSForegroundColorAttributeName: colorFromRGB(0x07080C)};
    navBar.titleTextAttributes =dic;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {//非根控制器x
        // 非根控制器才需要设置返回按钮
        // 设置返回按钮
        UIButton *backButton = [[UIButton alloc]init];
        backButton.frame = CGRectMake(0, 0, 30, 30);
        [backButton setImage:[UIImage imageNamed:@"ommon_nav_btn_back_n"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"ommon_nav_btn_back_n"] forState:UIControlStateHighlighted];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        // 注意:一定要在按钮内容有尺寸的时候,设置才有效果
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES;
        
    }else{
    }
    // 这个方法才是真正执行跳转
    [super pushViewController:viewController animated:animated];
}

- (void) back{
    dispatch_async(dispatch_get_main_queue(), ^{
          [self popViewControllerAnimated:YES];
    });
}

- (UIImageView *)foundNavigationBarBottomLine:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self foundNavigationBarBottomLine:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)showNavBarBottomLine {
    UIImageView *bottomLine = [self foundNavigationBarBottomLine:self.navigationBar];
    if (bottomLine) {
        bottomLine.hidden = YES;
    }
    
    UIImageView *navLine = [self.navigationBar.subviews[0] viewWithTag:5757];
    if (navLine) {
        navLine.hidden = NO;
        CGRect bottomLineFrame = bottomLine.frame;
        bottomLineFrame.origin.y = CGRectGetMaxY(self.navigationBar.frame);
        navLine.frame = bottomLineFrame;
    }else {
        CGRect bottomLineFrame = bottomLine.frame;
        bottomLineFrame.origin.y = CGRectGetMaxY(self.navigationBar.frame);
        UIImageView *navLine = [[UIImageView alloc] initWithFrame:bottomLineFrame];
        navLine.tag = 5757;
        navLine.backgroundColor = [UIColor lightGrayColor];
        if (self.navigationBar.subviews.count) {
            [self.navigationBar.subviews[0] addSubview:navLine];
        }else{
            bottomLine.hidden = NO;
        }
    }
}

- (void)hideNavBarBottomLine {
    UIImageView *bottomLine = [self foundNavigationBarBottomLine:self.navigationBar];
    if (bottomLine) {
        bottomLine.hidden = YES;
    }
    UIImageView *navLine = [self.navigationBar.subviews[0] viewWithTag:5757];
    if (navLine) {
        navLine.hidden = YES;
    }
}

@end
